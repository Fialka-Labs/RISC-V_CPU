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

// Регистры CSR
logic [31:0] reg_mie;
logic [31:0] reg_mtvec;
logic [31:0] reg_mscratch;
logic [31:0] reg_mepc;
logic [31:0] reg_mcause;

logic [31:0] current_csr_value;

always_comb begin
    case(addr_i)
        MIE_ADDR:      current_csr_value = reg_mie;
        MTVEC_ADDR:    current_csr_value = reg_mtvec;
        MSCRATCH_ADDR: current_csr_value = reg_mscratch;
        MEPC_ADDR:     current_csr_value = reg_mepc;
        MCAUSE_ADDR:   current_csr_value = reg_mcause;
        default:       current_csr_value = 32'b0;
    endcase
end

logic [31:0] data_reg;

always_comb begin
    case(opcode_i)
        CSR_RW:  data_reg = rs1_data_i;
        CSR_RS:  data_reg = rs1_data_i | current_csr_value;
        CSR_RC:  data_reg = ~rs1_data_i & current_csr_value;
        CSR_RWI: data_reg = imm_data_i;
        CSR_RSI: data_reg = imm_data_i | current_csr_value;
        CSR_RCI: data_reg = ~imm_data_i & current_csr_value;
        default: data_reg = 32'b0;
    endcase
end

// Запись регистров
always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i) begin
        reg_mie      <= '0;
        reg_mtvec    <= '0;
        reg_mscratch <= '0;
        reg_mepc     <= '0;
        reg_mcause   <= '0;
    end else begin
        if (trap_i) begin
            reg_mepc   <= pc_i;
            reg_mcause <= mcause_i;
        end else begin
            if (write_enable_i) begin
                case(addr_i)
                    MIE_ADDR:      reg_mie      <= data_reg;
                    MTVEC_ADDR:    reg_mtvec    <= data_reg;
                    MSCRATCH_ADDR: reg_mscratch <= data_reg;
                    MEPC_ADDR:     reg_mepc     <= data_reg;
                    MCAUSE_ADDR:   reg_mcause   <= data_reg;
                endcase
            end
        end
    end
end

// Чтение CSR
always_comb begin
    case(addr_i)
        MIE_ADDR:      read_data_o = reg_mie;
        MTVEC_ADDR:    read_data_o = reg_mtvec;
        MSCRATCH_ADDR: read_data_o = reg_mscratch;
        MEPC_ADDR:     read_data_o = reg_mepc;
        MCAUSE_ADDR:   read_data_o = reg_mcause;
        default:       read_data_o = '0;
    endcase
end

// Выходы
assign mie_o   = reg_mie;
assign mtvec_o = reg_mtvec;
assign mepc_o  = reg_mepc;

endmodule