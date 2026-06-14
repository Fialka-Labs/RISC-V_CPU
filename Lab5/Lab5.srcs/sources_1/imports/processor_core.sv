`timescale 1ns / 1ps

module processor_core(
    input  logic        clk_i,
    input  logic        rst_i,
    
    input  logic        stall_i,
    input  logic [31:0] instr_i,
    input  logic [31:0] mem_rd_i,

    output logic [31:0] instr_addr_o,
    output logic [31:0] mem_addr_o,
    output logic [ 2:0] mem_size_o,
    output logic        mem_req_o,
    output logic        mem_we_o,
    output logic [31:0] mem_wd_o
);
    // Провода сумматоров
    logic [31:0] sum;
    logic [31:0] sum_1;
    logic [31:0] sum_0;
    logic [31:0] jalr_mult;
    logic [31:0] PC;
    logic [31:0] jal_mult;
    logic [31:0] branch_mult;
    
    // Провода комманд 
    logic [31:0] imm_I;
    logic [31:0] imm_U;
    logic [31:0] imm_S;
    logic [31:0] imm_B;
    logic [31:0] imm_J;
    
    // Провода декодера
    logic        b;
    logic        jal;
    logic        jalr;   
    logic [ 1:0] wb_sel;
    logic [ 4:0] alu_op;
    logic [ 1:0] a_sel;
    logic [ 2:0] b_sel;
    logic        gpr_we;
    logic        mem_req;
    logic        mem_we;

    // Провода регистрового файла
    logic [31:0] RD1;
    logic [31:0] RD2;
    logic        WE;
    logic [31:0] wb_data;
    
    // Провода АЛУ
    logic [31:0] a_i;
    logic [31:0] b_i;
    logic [31:0] result_o;
    logic        flag;
    
    // Извлечение непосредственных значений
    assign imm_I = {{20{instr_i[31]}}, instr_i[31:20]};
    assign imm_U = {instr_i[31:12], 12'h0};
    assign imm_S = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
    assign imm_B = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
    assign imm_J = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
    
    // Вычисление адресов
    assign sum = RD1 + imm_I;
    assign sum_1 = {sum[31:1], 1'b0};
    
    // Разрешение записи в регистровый файл
    assign WE = gpr_we && ~(stall_i);
    
    // Выбор операнда a_i для АЛУ
    always_comb begin
        case(a_sel)
            2'd0: a_i = RD1;
            2'd1: a_i = PC;
            default: a_i = 32'd0;
        endcase
    end
    
    // Выбор операнда b_i для АЛУ
    always_comb begin
        case(b_sel)
            3'd0: b_i = RD2;
            3'd1: b_i = imm_I;
            3'd2: b_i = imm_U;
            3'd3: b_i = imm_S;
            3'd4: b_i = 32'd4;
        endcase
    end
    
    // Выбор данных для обратной записи
    always_comb begin
        case(wb_sel)
            2'd0: wb_data = result_o;
            2'd1: wb_data = mem_rd_i;
        endcase
    end
    
    // Логика переходов
    always_comb begin
        case(b)
            1'b0: branch_mult = imm_J;
            1'b1: branch_mult = imm_B;
        endcase
    end
    
    always_comb begin
        if ((flag && b) || jal)
            jal_mult = branch_mult;
        else
            jal_mult = 32'd4;
    end
    
    // Вычисление следующего PC
    assign sum_0 = PC + jal_mult;
    
    always_comb begin
        if (jalr)
            jalr_mult = sum_1;
        else
            jalr_mult = sum_0;
    end
    
    // Программный счетчик
    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            PC <= 32'd0;
        else if (~stall_i)
            PC <= jalr_mult;
    end
        
    // Декодер инструкций
    decoder Main_decoder (
        .fetched_instr_i(instr_i),
        .branch_o(b),
        .jal_o(jal),
        .jalr_o(jalr),
        .mem_size_o(mem_size_o),
        .mem_req_o(mem_req_o),
        .mem_we_o(mem_we_o),
        .wb_sel_o(wb_sel),
        .alu_op_o(alu_op),
        .a_sel_o(a_sel),
        .b_sel_o(b_sel),
        .gpr_we_o(gpr_we),
        .illegal_instr_o(),
        
        .csr_op_o(),
        .csr_we_o(),
        .mret_o()
    );
    
    // Регистровый файл
    register_file Register_File (
        .clk_i(clk_i),
        .read_addr1_i(instr_i[19:15]),
        .read_addr2_i(instr_i[24:20]),
        .write_addr_i(instr_i[11:7]),
        .write_data_i(wb_data),
        .write_enable_i(WE),
        .read_data1_o(RD1),
        .read_data2_o(RD2)
    );
    
    // Арифметико-логическое устройство
    alu ALU (
        .a_i(a_i),
        .b_i(b_i),
        .alu_op_i(alu_op),
        .flag_o(flag),
        .result_o(result_o)
    );
    
    // Выходные сигналы
    assign instr_addr_o = PC;
    assign mem_addr_o   = result_o;
    assign mem_wd_o     = RD2;

endmodule