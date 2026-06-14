`timescale 1ns / 1ps;

module sw_sb_ctrl(
    // Интерфейс системной шины, предназначенный для взаимодействия с внешним миром
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        req_i,
    input  logic        write_enable_i,
    input  logic [31:0] addr_i,
    input  logic [31:0] write_data_i,  // Не используется, поскольку память
                                     // реализована в переключателях
    output logic [31:0] read_data_o,

    // Интерфейс контроллера прерываний, сигнализирующий процессору о возникновении необработанного прерывания

    output logic        interrupt_request_o,
    input  logic        interrupt_return_i,

    // Интерфейс внешнего порта, предназначенный для взаимодействия с переключателями
    input logic [15:0]  sw_i
);

logic [15:0] registr_sw;

always_ff @(posedge clk_i) begin
    if (rst_i) registr_sw <= 0;
    else begin
        if (registr_sw != sw_i & ~interrupt_return_i) interrupt_request_o <= 1;       
        else interrupt_request_o <= 0;
        registr_sw <= sw_i;
    end
end


always_ff @(posedge clk_i) begin
    if (rst_i) read_data_o <= 0;
    else if (addr_i == 0 & ~write_enable_i & req_i) read_data_o <= {16'b0, sw_i};
end

endmodule
