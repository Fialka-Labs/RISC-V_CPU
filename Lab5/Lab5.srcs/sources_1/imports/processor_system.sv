`timescale 10ns / 1ps

module processor_system(
    input logic clk_i,
    input logic rst_i
);

import memory_pkg::*;

// Сигналы ядра
logic [31:0] instr;
logic [31:0] mem_rd;
logic [31:0] instr_addr;
logic [31:0] mem_addr;
logic [ 2:0] mem_size;
logic        mem_req;
logic        mem_we;
logic [31:0] mem_wd;
logic        stall;

// Сигналы для LSU
logic        lsu_mem_req;
logic        lsu_mem_we;
logic [ 3:0] lsu_mem_be;
logic [31:0] lsu_mem_addr;
logic [31:0] lsu_mem_wd;
logic [31:0] lsu_mem_rd;
logic        lsu_mem_ready;

instr_mem instr_mem(
    .read_addr_i(instr_addr),
    .read_data_o(instr)
);

// Память данных
data_mem data_mem(
    .clk_i(clk_i),
    .mem_req_i(lsu_mem_req),
    .write_enable_i(lsu_mem_we),
    .byte_enable_i(lsu_mem_be),
    .addr_i(lsu_mem_addr[31:0]),
    .write_data_i(lsu_mem_wd),
    .read_data_o(lsu_mem_rd),
    .ready_o(lsu_mem_ready)
);

// LSU (Load-Store Unit)
lsu LSU (
    .clk_i(clk_i),
    .rst_i(rst_i),
    
    // Интерфейс с ядром
    .core_req_i(mem_req),
    .core_we_i(mem_we),
    .core_size_i(mem_size),
    .core_addr_i(mem_addr),
    .core_wd_i(mem_wd),
    .core_rd_o(mem_rd),
    .core_stall_o(stall),
    
    // Интерфейс с памятью
    .mem_req_o(lsu_mem_req),
    .mem_we_o(lsu_mem_we),
    .mem_be_o(lsu_mem_be),
    .mem_addr_o(lsu_mem_addr),
    .mem_wd_o(lsu_mem_wd),
    .mem_rd_i(lsu_mem_rd),
    .mem_ready_i(lsu_mem_ready)
);

// Ядро
processor_core core(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .stall_i(stall),
    .instr_i(instr),
    .mem_rd_i(mem_rd),
    .instr_addr_o(instr_addr),
    .mem_addr_o(mem_addr),
    .mem_size_o(mem_size),
    .mem_req_o(mem_req),
    .mem_we_o(mem_we),
    .mem_wd_o(mem_wd)
);

endmodule