`timescale 1ns / 1ps

module fulladder4(
    input logic [3:0] a_i,
    input logic [3:0] b_i,
    input logic carry_i,
    
    output logic [3:0] sum_o,
    output logic carry_o
);

logic carry_wire[3:0];

fulladder adder0(
    .a_i(a_i[0]), 
    .b_i(b_i[0]), 
    .carry_i(carry_i), 
    .sum_o(sum_o[0]), 
    .carry_o(carry_wire[0]));

fulladder adder1(
    .a_i(a_i[1]), 
    .b_i(b_i[1]), 
    .carry_i(carry_wire[0]), 
    .sum_o(sum_o[1]), 
    .carry_o(carry_wire[1]));
    
fulladder adder2(
    .a_i(a_i[2]), 
    .b_i(b_i[2]), 
    .carry_i(carry_wire[1]), 
    .sum_o(sum_o[2]), 
    .carry_o(carry_wire[2]));

fulladder adder3(
    .a_i(a_i[3]), 
    .b_i(b_i[3]), 
    .carry_i(carry_wire[2]), 
    .sum_o(sum_o[3]), 
    .carry_o(carry_wire[3]));
 
assign carry_o = carry_wire[3];

endmodule
