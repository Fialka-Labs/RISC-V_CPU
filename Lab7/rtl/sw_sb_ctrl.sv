`timescale 1ns / 1ps;

module sw_sb_ctrl(
    // Часть интерфейса модуля, отвечающая за подключение к системной шине
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        req_i,
    input  logic        write_enable_i,
    input  logic [31:0] addr_i,
    input  logic [31:0] write_data_i,  // не используется, добавлен для
                                     // совместимости с системной шиной
    output logic [31:0] read_data_o,

    /*
        Часть интерфейса модуля, отвечающая за отправку запросов на прерывание
        процессорного ядра
    */

    output logic        interrupt_request_o,
    input  logic        interrupt_return_i,

    // Часть интерфейса модуля, отвечающая за подключение к периферии
    input logic [15:0]  sw_i
);

// Регистр для хранения предыдущего состояния переключателей
logic [15:0] reg_sw;

always_ff @(posedge clk_i) begin
    if (rst_i) reg_sw <= 0;
    else begin
        // Прерывание при изменении sw и отсутствии return
        if (reg_sw != sw_i & ~interrupt_return_i) 
             interrupt_request_o <= 1;       
        else interrupt_request_o <= 0;
        reg_sw <= sw_i; // Обновление текущего состояния
    end
end


always_ff @(posedge clk_i) begin
    if (rst_i) read_data_o <= 0;
    // Чтение sw по адресу 0
    else if (addr_i == 0 & ~write_enable_i & req_i) 
        read_data_o <= {16'b0, sw_i};
end

endmodule
