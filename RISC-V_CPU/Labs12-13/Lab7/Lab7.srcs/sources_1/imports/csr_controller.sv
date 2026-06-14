`timescale 1ns / 1ps

module csr_controller(
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        trap_i,
    
    input  logic [ 2:0] opcode_i,
    
    input  logic [11:0] addr_i,
    input  logic [31:0] pc_i,
    input  logic [31:0] mcause_i,
    input  logic [31:0] rs1_data_i,
    input  logic [31:0] imm_data_i,
    input  logic        write_enable_i,
    
    output logic [31:0] read_data_o,
    output logic [31:0] mie_o,
    output logic [31:0] mepc_o,
    output logic [31:0] mtvec_o
);

import csr_pkg::*;

logic [31:0] data_reg;

always_comb begin
    case(opcode_i)
        CSR_RW:  
            begin
                data_reg = rs1_data_i;
            end
        CSR_RS:
            begin
                data_reg = rs1_data_i | read_data_o;
            end  
        CSR_RC:
            begin
                data_reg = ~rs1_data_i & read_data_o;
            end
        CSR_RWI:
            begin
                data_reg = imm_data_i;
            end
        CSR_RSI:
            begin
                data_reg = imm_data_i | read_data_o;
            end
        CSR_RCI:
            begin
                data_reg = ~imm_data_i & read_data_o;
            end
        default: 
            begin
                data_reg = 0;
            end
    endcase
end

logic en_mie;
logic en_mtvec;
logic en_mscratch;
logic en_mepc;
logic en_mcause;

always_comb begin
    case(addr_i)
         MIE_ADDR: 
            begin
                en_mie = write_enable_i;
                en_mtvec = '0;
                en_mscratch = '0;
                en_mepc = trap_i;
                en_mcause = trap_i;
            end
         MTVEC_ADDR:
            begin
                en_mie = '0;
                en_mtvec = write_enable_i;
                en_mscratch = '0;
                en_mepc = trap_i;
                en_mcause = trap_i;
            end
         MSCRATCH_ADDR:
            begin
                en_mie = '0;
                en_mtvec = '0;
                en_mscratch = write_enable_i;
                en_mepc = trap_i;
                en_mcause = trap_i;
            end
         MEPC_ADDR:
            begin
                en_mie = '0;
                en_mtvec = '0;
                en_mscratch = '0;
                en_mepc = write_enable_i | trap_i;
                en_mcause = trap_i;
            end
         MCAUSE_ADDR:  
            begin
                en_mie = '0;
                en_mtvec = '0;
                en_mscratch = '0;
                en_mepc = trap_i;
                en_mcause = write_enable_i | trap_i;
            end
        default:
            begin
                en_mie = '0;
                en_mtvec = '0;
                en_mscratch = '0;
                en_mepc = '0;
                en_mcause = '0;
            end 
    endcase
end

logic [31:0] reg_mie;      // Регистр маски перехватов
logic [31:0] reg_mtvec;    // Базовый адрес обработчика перехвата
logic [31:0] reg_mscratch; // Адрес верхушки стека обработчика перехвата
logic [31:0] reg_mepc;     // Регистр, хранящий адрес перехваченной инструкции
logic [31:0] reg_mcause;   // Причина перехвата

always_ff@(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin
        reg_mie <= '0;
        reg_mtvec <= '0;
        reg_mscratch <= '0;
        reg_mepc <= '0;
        reg_mcause <= '0;
    end
    else begin
        reg_mie <= (en_mie)? data_reg : reg_mie;
        reg_mtvec <= (en_mtvec)? data_reg : reg_mtvec;
        reg_mscratch <= (en_mscratch)? data_reg : en_mscratch;
        reg_mepc <= (en_mepc) ? ((trap_i)? pc_i : data_reg) : reg_mepc;
        reg_mcause <= (en_mcause) ? ((trap_i)? mcause_i : data_reg) : reg_mcause;
    end
end

always_comb begin
    case(addr_i)
         MIE_ADDR: 
            begin
               read_data_o = reg_mie;
            end
         MTVEC_ADDR:
            begin
                read_data_o = reg_mtvec;
            end
         MSCRATCH_ADDR:
            begin
                read_data_o = reg_mscratch;
            end
         MEPC_ADDR:
            begin
                read_data_o = reg_mepc;
            end
         MCAUSE_ADDR:  
            begin
                read_data_o = reg_mcause;
            end
        default:
            begin
                read_data_o = '0;
            end 
    endcase
end

assign mie_o = reg_mie;
assign mtvec_o = reg_mtvec;
assign mepc_o = reg_mepc;
    
endmodule