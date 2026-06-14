`timescale 1ns / 1ps

module lsu(
  input logic clk_i,
  input logic rst_i,

  input  logic        core_req_i,
  input  logic        core_we_i,
  input  logic [ 2:0] core_size_i,
  input  logic [31:0] core_addr_i,
  input  logic [31:0] core_wd_i,
  output logic [31:0] core_rd_o,
  output logic        core_stall_o,

  output logic        mem_req_o,
  output logic        mem_we_o,
  output logic [ 3:0] mem_be_o,
  output logic [31:0] mem_addr_o,
  output logic [31:0] mem_wd_o,
  input  logic [31:0] mem_rd_i,
  input  logic        mem_ready_i
);

import decoder_pkg::*;

logic [ 1:0] byte_offset;
logic        half_offset;

logic [ 3:0] mem_be_w;
logic [ 3:0] mem_be_h;
logic [ 3:0] mem_be_b;

logic [31:0] core_rd_w;
logic [31:0] core_rd_h;
logic [31:0] core_rd_hu;
logic [31:0] core_rd_b;
logic [31:0] core_rd_bu;

logic [31:0] mem_wd_w;
logic [31:0] mem_wd_h;
logic [31:0] mem_wd_b;

logic [ 7:0] first_byte;
logic [ 7:0] second_byte;
logic [ 7:0] third_byte;
logic [ 7:0] fourth_byte;

logic [31:0] SE_first_byte;
logic [31:0] SE_second_byte;
logic [31:0] SE_third_byte;
logic [31:0] SE_fourth_byte;

logic [31:0] UE_first_byte;
logic [31:0] UE_second_byte;
logic [31:0] UE_third_byte;
logic [31:0] UE_fourth_byte;

logic [15:0] first_half_word;
logic [15:0] second_half_word;

logic [31:0] SE_first_half_word;
logic [31:0] SE_second_half_word;

logic [31:0] UE_first_half_word;
logic [31:0] UE_second_half_word;

logic stall_reg;

assign mem_addr_o = core_addr_i;

assign byte_offset = core_addr_i[1:0];
assign half_offset = core_addr_i[1];

assign mem_be_w = 4'b1111;
assign mem_be_b = 4'b0001 << byte_offset;

assign core_rd_w = mem_rd_i;

assign mem_wd_w = core_wd_i;
assign mem_wd_h = { {2{core_wd_i[15:0]}} };
assign mem_wd_b = { {4{core_wd_i[ 7:0]}} };

assign first_byte  = mem_rd_i[ 7: 0];
assign second_byte = mem_rd_i[15: 8];
assign third_byte  = mem_rd_i[23:16];
assign fourth_byte = mem_rd_i[31:24];

// Знаковое расширение для битов
assign SE_first_byte  = { {24{ first_byte[7]}},  first_byte };
assign SE_second_byte = { {24{second_byte[7]}}, second_byte };
assign SE_third_byte  = { {24{ third_byte[7]}},  third_byte };
assign SE_fourth_byte = { {24{fourth_byte[7]}}, fourth_byte };

assign UE_first_byte  = { 24'd0,  first_byte };
assign UE_second_byte = { 24'd0, second_byte };
assign UE_third_byte  = { 24'd0,  third_byte };
assign UE_fourth_byte = { 24'd0, fourth_byte };

assign first_half_word  = mem_rd_i[15:0];
assign second_half_word = mem_rd_i[31:16];

// Знаковое расширение для полуслова
assign SE_first_half_word  = { {16{ first_half_word[15]}},  first_half_word };
assign SE_second_half_word = { {16{second_half_word[15]}}, second_half_word };

assign UE_first_half_word  = { 16'd0,  first_half_word };
assign UE_second_half_word = { 16'd0, second_half_word };

// Выбор первой или второй половины слова
always_comb begin
    case(half_offset)
        1'b0: mem_be_h <= 4'b0011;
        1'b1: mem_be_h <= 4'b1100;
   endcase
end

// Выходной бит знакового расширения
always_comb begin
    case(byte_offset)
        2'b00: core_rd_b <= SE_first_byte;
        2'b01: core_rd_b <= SE_second_byte;
        2'b10: core_rd_b <= SE_third_byte;
        2'b11: core_rd_b <= SE_fourth_byte;
    endcase
end

// Выход беззнакового расширения
always_comb begin
    case(byte_offset)
        2'b00: core_rd_bu <= UE_first_byte;
        2'b01: core_rd_bu <= UE_second_byte;
        2'b10: core_rd_bu <= UE_third_byte;
        2'b11: core_rd_bu <= UE_fourth_byte;
    endcase
end

// Выход знакового расширения полуслова
always_comb begin
    case(half_offset)
        1'b0: core_rd_h <= SE_first_half_word;
        1'b1: core_rd_h <= SE_second_half_word;
    endcase
end

// Выход знакового расширения полуслова
always_comb begin 
    case(half_offset)
        1'b0: core_rd_hu <= UE_first_half_word;
        1'b1: core_rd_hu <= UE_second_half_word;
    endcase
end

// Выбор mem_be_o
always_comb begin
    case(core_size_i)
        LDST_W: mem_be_o <= mem_be_w;
        LDST_H: mem_be_o <= mem_be_h; // mem_be_h с мультиплексора
        LDST_B: mem_be_o <= mem_be_b; // mem_be_b с левого сдвига
        default:
            mem_be_o <= 0;
    endcase
end

// Выбор core_rd_o
always_comb begin
    case(core_size_i)
        LDST_W:  core_rd_o <= core_rd_w;
        LDST_H:  core_rd_o <= core_rd_h;
        LDST_B:  core_rd_o <= core_rd_b;
        LDST_BU: core_rd_o <= core_rd_bu;
        LDST_HU: core_rd_o <= core_rd_hu;
        default:
            core_rd_o <= 0;
    endcase
end

// Выбор mem_wd_o
always_comb begin
    case(core_size_i)
        LDST_W: mem_wd_o <= mem_wd_w;
        LDST_H: mem_wd_o <= mem_wd_h;
        LDST_B: mem_wd_o <= mem_wd_b;
        default:
            mem_wd_o <= 0;
    endcase
end

assign core_stall_o = ~(mem_ready_i && stall_reg) && core_req_i;

always_ff @(posedge clk_i) begin
    if(rst_i) begin
        stall_reg <= 1'b0;
    end else begin
        stall_reg <= core_stall_o;
    end
end

assign mem_req_o = core_req_i;
assign mem_we_o  = core_we_i;
    
endmodule