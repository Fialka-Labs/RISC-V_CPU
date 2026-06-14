`timescale 1ns / 1ps

module decoder(
    input  logic [31:0]  fetched_instr_i,  // Инструкция, подлежащая декодированию
    output logic [1:0]   a_sel_o,          // Управляющий сигнал мультиплексора для выбора первого операнда АЛУ
    output logic [2:0]   b_sel_o,          // Управляющий сигнал мультиплексора для выбора второго операнда АЛУ
    output logic [4:0]   alu_op_o,         // Операция АЛУ
    output logic [2:0]   csr_op_o,         // Операция модуля CSR
    output logic         csr_we_o,         // Разрешение на запись в CSR
    output logic         mem_req_o,        // Запрос на доступ к памяти (часть интерфейса памяти)
    output logic         mem_we_o,         // Сигнал разрешения записи в память, «write enable» (при равенстве нулю происходит чтение)
    output logic [2:0]   mem_size_o,       // Управляющий сигнал для выбора размера слова при чтении-записи в память (часть интерфейса памяти)
    output logic         gpr_we_o,         // Сигнал разрешения записи в регистровый файл
    output logic [1:0]   wb_sel_o,         // Управляющий сигнал мультиплексора для выбора данных, записываемых в регистровый файл
    output logic         illegal_instr_o,  // Сигнал о некорректной инструкции
    output logic         branch_o,         // Сигнал об инструкции условного перехода
    output logic         jal_o,            // Сигнал об инструкции безусловного перехода jal
    output logic         jalr_o,           // Сигнал об инструкции безусловного перехода jalr
    output logic         mret_o            // Сигнал об инструкции возврата из прерывания/исключения mret
);
    
import decoder_pkg::*;
import csr_pkg::*;

// Разбираем инструкцию на составляющие
logic [2:0] func3;
logic [6:0] func7;
logic [4:0] op_code;
logic [4:0] rd;
logic [4:0] rs1;

assign op_code = fetched_instr_i[6:2];    
assign func3 =   fetched_instr_i[14:12];    
assign func7 =   fetched_instr_i[31:25];    
assign rd =      fetched_instr_i[11:7];
assign rs1 =     fetched_instr_i[19:15];

always_comb begin
    // Сбрасываем все сигналы по умолчанию
    a_sel_o = 0;
    b_sel_o = 0;
    alu_op_o = 0;
    csr_we_o = 0;
    csr_op_o = 0;
    mem_req_o = 0;
    mem_we_o = 0;
    mem_size_o = 0;
    gpr_we_o = 0;
    wb_sel_o = 0;
    illegal_instr_o = 0;
    branch_o = 0;
    jal_o = 0;
    jalr_o = 0;
    mret_o = 0;
    
    // Проверяем что инструкция выровнена правильно
    case(fetched_instr_i[1:0])
        2'b11: 
        begin
            case(op_code)               
                OP_OPCODE:  // (rd = alu_op(rs1, rs2)); Записать в rd результат вычисления 
                                // АЛУ над rs1 и rs2; R-тип - регистр-регистр
                begin
                    a_sel_o = OP_A_RS1;
                    b_sel_o = OP_B_RS2;
                    gpr_we_o = 1'd1;
                    wb_sel_o = WB_EX_RESULT; // Результат АЛУ

                    case(func7)   
                        7'b000_0000: 
                            // Баазовые операции 
                            alu_op_o = {func7[5:4], func3};
                        7'b010_0000: // Специальные случаи с отличным func7
                            case(func3)
                                3'b000: alu_op_o = ALU_SUB;  // Вычитание
                                3'b101: alu_op_o = ALU_SRA;  // Арифметический сдвиг
                                default: begin
                                    illegal_instr_o = 1'd1;
                                    gpr_we_o = 1'd0; 
                                end
                            endcase
                        default: begin
                            illegal_instr_o = 1'd1;
                            gpr_we_o = 1'd0; 
                        end
                    endcase
                end
                
                OP_IMM_OPCODE: // (rd = alu_op(rs1, imm)); Записать в rd результат вычисления 
                                    // АЛУ над rs1 и imm; I-тип - регистр-константа
                begin
                    gpr_we_o = 1'd1; 
                    a_sel_o = OP_A_RS1;
                    b_sel_o = OP_B_IMM_I;  
                    
                    case(func3)
                        // Базовые арифметические и логические
                        3'b000: alu_op_o = ALU_ADD;
                        3'b100: alu_op_o = ALU_XOR;
                        3'b110: alu_op_o = ALU_OR;
                        3'b111: alu_op_o = ALU_AND;
                        3'b010: alu_op_o = ALU_SLTS;  // Сравнение со знаком
                        3'b011: alu_op_o = ALU_SLTU;  // Беззнаковое сравнение
                        3'b001: // Сдвиги влево
                            case(func7)
                                7'b000_0000: alu_op_o = ALU_SLL;
                                default: begin
                                    illegal_instr_o = 1'd1;
                                    gpr_we_o = 1'd0; 
                                end
                            endcase
                        3'b101: // Сдвиги вправо
                            case(func7)
                                7'b000_0000: alu_op_o = ALU_SRL;  // Логический
                                7'b010_0000: alu_op_o = ALU_SRA;  // Арифметический
                                default: begin
                                    illegal_instr_o = 1'd1;
                                    gpr_we_o = 1'd0; 
                                end
                            endcase
                        default: begin
                            illegal_instr_o = 1'd1;
                            gpr_we_o = 1'd0; 
                        end
                    endcase
                end
                
                LOAD_OPCODE: // (rd = Mem[rs1 + imm]); Записать в rd данные из 
                                    // памяти по адресу rs1+imm; I-тип - регистр-константа
                begin         
                    gpr_we_o = 1'd1;                 
                    a_sel_o = OP_A_RS1;
                    b_sel_o = OP_B_IMM_I;  // Смещение                            
                    alu_op_o = ALU_ADD;    
                    wb_sel_o = WB_LSU_DATA; // Данные из памяти
                    
                    case(func3)
                        LDST_B, LDST_H, LDST_W, LDST_BU, LDST_HU: begin
                            mem_req_o = 1'd1;
                            mem_size_o = func3;  // Размер определяется func3
                        end
                        default: begin
                            illegal_instr_o = 1'd1;
                            gpr_we_o = 1'd0;
                        end
                    endcase                            
                end
                
                STORE_OPCODE: // (Mem[rs1 + imm] = rs2); Записать в память по адресу rs1+imm данные из rs2; S-тип - запись в память
                begin
                    a_sel_o = OP_A_RS1;
                    b_sel_o = OP_B_IMM_S;  
                    alu_op_o = ALU_ADD;     // Всегда сложение для вычисления адреса
                    mem_we_o = 1'd1;       // Разрешаем запись в память
                    gpr_we_o = 1'd0;       // В регистр ничего не пишем
                    
                    case(func3)
                        LDST_B, LDST_H, LDST_W: begin
                            mem_req_o = 1'd1;
                            mem_size_o = func3;
                        end
                        default: begin
                            // Неизвестный код инструкции
                            illegal_instr_o = 1'd1;
                            mem_we_o = 1'd0;
                        end
                    endcase
                end
                
                BRANCH_OPCODE: // Условные переходы
                begin
                    a_sel_o = OP_A_RS1;
                    b_sel_o = OP_B_RS2;    // Сравниваем два регистра
                    branch_o = 1'd1;       // Это инструкция перехода
                    gpr_we_o = 1'd0;       // Регистр не обновляем
                    
                    case(func3)
                        // Все варианты сравнений
                        3'b000: alu_op_o = ALU_EQ;   // Равно
                        3'b001: alu_op_o = ALU_NE;   // Не равно
                        3'b100: alu_op_o = ALU_LTS;  // Меньше (со знаком)
                        3'b101: alu_op_o = ALU_GES;  // Больше или равно (с знаком)
                        3'b110: alu_op_o = ALU_LTU;  // Меньше (без знака)
                        3'b111: alu_op_o = ALU_GEU;  // Больше или равно (без знака)
                        default: begin
                            illegal_instr_o = 1'd1;
                            branch_o = 1'd0;
                        end
                    endcase
                end
                
                JAL_OPCODE: // (rd = PC + 4; PC = rs1+imm); Записать в rd следующий адрес счетчика команд, 
                                // увеличить счетчик команд на значение imm; I-тип - регистр-константа
                begin
                    gpr_we_o = 1'd1; 
                    a_sel_o = OP_A_CURR_PC;  // Берем текущий PC
                    b_sel_o = OP_B_INCR;     // И инкремент
                    jal_o = 1'd1;            // Это JAL
                    alu_op_o = ALU_ADD;      // PC + 4 в регистр
                end
                
                JALR_OPCODE: // Косвенный переход
                begin
                    case(func3)
                        3'b000: begin
                            gpr_we_o = 1'd1; 
                            a_sel_o = OP_A_CURR_PC;
                            b_sel_o = OP_B_INCR;
                            jalr_o = 1'd1;    
                            alu_op_o = ALU_ADD;
                        end
                        default:
                            // Неизвестный код инструкции
                            illegal_instr_o = 1'd1;
                    endcase
                end
                
                LUI_OPCODE: // Загрузка верхних битов
                begin
                    gpr_we_o = 1'd1; 
                    a_sel_o = OP_A_ZERO;     // Прибавляем к нулю
                    b_sel_o = OP_B_IMM_U;    // U-type immediate
                    alu_op_o = ALU_ADD;
                end
                
                AUIPC_OPCODE: // Смещение от PC
                begin
                    gpr_we_o = 1'd1; 
                    a_sel_o = OP_A_CURR_PC;  // Берем PC
                    b_sel_o = OP_B_IMM_U;    // И смещение
                    alu_op_o = ALU_ADD;
                end
                
                MISC_MEM_OPCODE: 
                begin
                    if(func3 !== 3'b000) begin
                        // Неизвестный код инструкции
                        illegal_instr_o = 1'd1;
                    end
                end
                
                SYSTEM_OPCODE: // Системные инструкции
                begin
                    case(func3)
                        3'b000: begin
                            // MRET инструкция:
                            if (func7 == 7'b0011000 && rs1 == 5'b00000 && rd == 5'b00000) begin
                                mret_o = 1'd1;
                            end
                            // ECALL/EBREAK инструкции
                            else if (func7 == 7'b0000000) begin
                                illegal_instr_o = 1'd1;
                            end
                            else begin
                                // Неизвестный код инструкции
                                illegal_instr_o = 1'd1;
                            end
                        end
                        // Операции с CSR
                        CSR_RW, CSR_RS, CSR_RC, 
                        CSR_RWI, CSR_RSI, CSR_RCI: begin
                            gpr_we_o = 1'd1;      
                            wb_sel_o = WB_CSR_DATA; // Данные из CSR регистра
                            csr_we_o = 1'd1;       
                            csr_op_o = func3;      // Тип операции CSR
                        end
                        default: begin
                            // Неизвестный код инструкции
                            illegal_instr_o = 1'd1;
                        end
                    endcase
                end
                
                default: begin
                    // Неизвестный код инструкции
                    illegal_instr_o = 1'd1;
                end
            endcase
        end
        default: begin
            // Неизвестный код инструкции
            illegal_instr_o = 1'd1;
        end
    endcase
end
    
endmodule