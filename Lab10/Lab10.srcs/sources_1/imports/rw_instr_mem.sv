`timescale 1ns / 1ps

module rw_instr_mem
import memory_pkg::INSTR_MEM_SIZE_BYTES;
import memory_pkg::INSTR_MEM_SIZE_WORDS;
(
    input  logic        clk_i,
    input  logic [31:0] read_addr_i,
    output logic [31:0] read_data_o,
    
    input  logic [31:0] write_addr_i,
    input  logic [31:0] write_data_i,
    input  logic        write_enable_i
);

logic [31:0] ROM [INSTR_MEM_SIZE_WORDS];

assign read_data_o = ROM[read_addr_i[$clog2(INSTR_MEM_SIZE_BYTES)-1:2]];

always_ff @(posedge clk_i) begin
    if(write_enable_i) begin
        ROM[write_addr_i[$clog2(INSTR_MEM_SIZE_BYTES)-1:2]] <= write_data_i;
    end
end

initial begin
    $readmemh("coremark_instr.mem", ROM);
end 

endmodule