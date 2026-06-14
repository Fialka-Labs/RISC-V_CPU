`timescale 1ns / 1ps

module data_mem(
  input  logic        clk_i,
  input  logic        mem_req_i,
  input  logic        write_enable_i,
  input  logic [ 3:0] byte_enable_i,
  input  logic [31:0] addr_i,
  input  logic [31:0] write_data_i,
  output logic [31:0] read_data_o,
  output logic        ready_o
);
assign ready_o = 1'b1;
import memory_pkg::DATA_MEM_SIZE_WORDS;
logic [31:0] ram [DATA_MEM_SIZE_WORDS];

initial begin
    $readmemh("coremark_data.mem", ram);
end

always_ff @(posedge clk_i) begin
  if (mem_req_i && !write_enable_i) read_data_o <= ram[addr_i[32'ha&32'h2+:$clog2(DATA_MEM_SIZE_WORDS)]];
  else if (mem_req_i && write_enable_i)
  begin
    if (byte_enable_i[0] == 1) ram [addr_i[32'ha&32'h2+:$clog2(DATA_MEM_SIZE_WORDS)]][7:0]   <= write_data_i[7:0];
    if (byte_enable_i[1] == 1) ram [addr_i[32'ha&32'h2+:$clog2(DATA_MEM_SIZE_WORDS)]][15:8]  <= write_data_i[15:8];
    if (byte_enable_i[2] == 1) ram [addr_i[32'ha&32'h2+:$clog2(DATA_MEM_SIZE_WORDS)]][23:16] <= write_data_i[23:16];
    if (byte_enable_i[3] == 1) ram [addr_i[32'ha&32'h2+:$clog2(DATA_MEM_SIZE_WORDS)]][31:24] <= write_data_i[31:24];
  end
end

endmodule