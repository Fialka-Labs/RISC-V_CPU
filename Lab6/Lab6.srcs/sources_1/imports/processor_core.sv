`timescale 1ns / 1ps

module processor_core(
    input  logic        clk_i,
    input  logic        rst_i,
    
    input  logic        stall_i,
    input  logic [31:0] instr_i,
    input  logic [31:0] mem_rd_i,
    
    input  logic        irq_req_i,
    
    output logic [31:0] instr_addr_o,
    output logic [31:0] mem_addr_o,
    output logic [ 2:0] mem_size_o,
    output logic        mem_req_o,
    output logic        mem_we_o,
    output logic [31:0] mem_wd_o,
    
    output logic        irq_ret_o
);
    // Провода сумматоров
    logic [31:0] sum;
    logic [31:0] sum_1;
    logic [31:0] sum_0;
    logic [31:0] jalr_mult;
    logic [31:0] PC;
    logic [31:0] jal_mult;
    logic [31:0] branch_mult;
    
    logic [31:0] trap_mult;
    logic [31:0] mret_mult;
    
    // Провода комманд 
    logic [31:0] imm_I;
    logic [31:0] imm_U;
    logic [31:0] imm_S;
    logic [31:0] imm_B;
    logic [31:0] imm_J;
    
    logic [31:0] imm_Z;
    
    // Провода декодера
    logic        b;
    logic        jal;
    logic        jalr;
    logic        ill_instr;   
    logic [ 1:0] wb_sel;
    logic [ 4:0] alu_op;
    logic [ 1:0] a_sel;
    logic [ 2:0] b_sel;
    logic        gpr_we;
    logic        mem_req;
    logic        mem_we;
    
    logic [ 3:0] csr_op;
    logic        csr_we;
    logic        mret;

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
    
    
    // Провода CSR
    logic        trap;
    logic [31:0] mcause;
    logic [31:0] csr_wd;
    logic [31:0] mie;
    logic [31:0] mepc;
    logic [31:0] mtvec;
    
    // Провода IRQ
    logic        irq;
    logic [31:0] irq_cause_o;
    
    // Извлечение непосредственных значений
    assign imm_I = {{20{instr_i[31]}}, instr_i[31:20]};
    assign imm_U = {instr_i[31:12], 12'h0};
    assign imm_S = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
    assign imm_B = {{20{instr_i[31]}}, instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};
    assign imm_J = {{12{instr_i[31]}}, instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};
    
    assign imm_Z = {{27{1'b0}}, instr_i[19:15]};
    
    // Вычисление адресов
    assign sum = RD1 + imm_I;
    assign sum_1 = {sum[31:1], 1'b0};
    
    // Разрешение записи в регистровый файл
    assign WE = gpr_we && !(stall_i || trap);
    
    // trap
    assign trap = irq || ill_instr;
    
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
            2'd2: wb_data = csr_wd;
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
    
    
    always_comb begin
        if (trap)
            trap_mult = mtvec;
        else
            trap_mult = jalr_mult;
    end
    
    always_comb begin
        if (mret)
            mret_mult = mepc;
        else
            mret_mult = trap_mult;
    end
    
    // Программный счетчик
    always_ff @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            PC <= 32'd0;
        else if (!stall_i || trap)
            PC <= mret_mult;
    end
    
    
    always_comb begin
        if (ill_instr)
            mcause = 32'h0000_0002;
        else
            mcause = irq_cause_o;
    end
    
    // Выходные сигналы памяти
    assign mem_req_o = !trap && mem_req;
    assign mem_we_o  = !trap && mem_we;
        
    // Декодер инструкций
    decoder Main_decoder (
        .fetched_instr_i(instr_i),
        .branch_o(b),
        .jal_o(jal),
        .jalr_o(jalr),
        .mem_size_o(mem_size_o),
        .mem_req_o(mem_req),
        .mem_we_o(mem_we),
        .wb_sel_o(wb_sel),
        .alu_op_o(alu_op),
        .a_sel_o(a_sel),
        .b_sel_o(b_sel),
        .gpr_we_o(gpr_we),
        .illegal_instr_o(ill_instr),
        
        .csr_op_o(csr_op),
        .csr_we_o(csr_we),
        .mret_o(mret)
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
    
    
    // CSR-контроллер (Control status registers) 
    csr_controller CSR (
        .clk_i(clk_i),
        .trap_i(trap),
        .opcode_i(csr_op),
        .write_enable_i(csr_we),
        .rst_i(rst_i),
        .addr_i(instr_i[31:20]),
        .pc_i(PC),
        .mcause_i(mcause),
        .rs1_data_i(RD1),
        .imm_data_i(imm_Z),
        .read_data_o(csr_wd),
        .mie_o(mie),
        .mepc_o(mepc),
        .mtvec_o(mtvec)
    );
    
    // Контроллер прерываний (IRQ)
    interrupt_controller IRQ (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .exception_i(ill_instr),
        .irq_req_i(irq_req_i),
        .mie_i(mie[16]),
        .mret_i(mret),
        .irq_o(irq),
        .irq_cause_o(irq_cause_o),
        .irq_ret_o(irq_ret_o)
    );
    
    // Выходные сигналы
    assign instr_addr_o = PC;
    assign mem_addr_o   = result_o;
    assign mem_wd_o     = RD2;

endmodule