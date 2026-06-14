`timescale 1ns / 1ps

module daisy_chain(
    input  logic [15:0] masked_irq_i,
    input  logic        ready_i,
    input  logic        irq_ret_i,
    input  logic        clk_i,
    input  logic        rst_i,
    
    output logic [15:0] irq_ret_o,
    output logic [31:0] irq_cause_o,
    output logic        irq_o 
);

logic [15:0] cause;
logic [16:0] b;

logic [15:0] rg;

assign b[0] = ready_i;

genvar i;
generate
    for (i = 0; i < 16; i++) begin
        assign cause[i] = masked_irq_i[i] && b[i];
        assign b[i + 1] = b[i] && !(masked_irq_i[i] && b[i]); 
    end
endgenerate

assign irq_o = |cause;
assign irq_cause_o = {12'h800, cause, 4'h0};

always_ff @(posedge clk_i or posedge rst_i) begin
    if (rst_i) rg <= 0;
    else if (irq_o) rg <= cause;
end

always_comb begin
    if (irq_ret_i) irq_ret_o = rg;
    else irq_ret_o = 16'd0;
end

endmodule