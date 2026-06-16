`timescale 1ns / 1ps

module interrupt_controller(
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        exception_i,
    input  logic [15:0] irq_req_i,
    input  logic [15:0] mie_i,
    input  logic        mret_i,
    
    output logic [15:0] irq_ret_o,
    output logic [31:0] irq_cause_o,
    output logic        irq_o
);

logic exc_h; // регистры
logic irq_h;

always_ff@(posedge clk_i or posedge rst_i) begin
    if(rst_i) begin
        exc_h <= 0;
        irq_h <= 0;
    end
    else begin
        exc_h <= (~mret_i & (exception_i | exc_h));
        irq_h <= ~(mret_i & ~(exception_i | exc_h)) & (irq_o | irq_h);
    end
end

daisy_chain daisy_chain (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .masked_irq_i(irq_req_i & mie_i),
    .irq_ret_i(mret_i & ~(exception_i | exc_h)),
    .ready_i(~(irq_h | exception_i | exc_h)),
    .irq_ret_o(irq_ret_o),
    .irq_cause_o(irq_cause_o),
    .irq_o(irq_o)
);
    
endmodule