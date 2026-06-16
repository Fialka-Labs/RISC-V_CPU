`timescale 1ns / 1ps

module led_sb_ctrl(
  // Часть интерфейса модуля, отвечающая за подключение к системной шине
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        req_i,
  input  logic        write_enable_i,
  input  logic [31:0] addr_i,
  input  logic [31:0] write_data_i,
  output logic [31:0] read_data_o,

  // Часть интерфейса модуля, отвечающая за подключение к периферии
  output logic [15:0] led_o
);

logic is_val_addr;
logic is_mode_addr;
logic is_rst_addr;

logic write_req;
logic read_req;

logic rst;

logic val_en;
logic mode_en;

logic [15:0] led_val;
logic [31:0] led_mode;
logic [31:0] cntr;

logic reset;

assign is_val_addr  = addr_i == 32'h0;   // Адрес регистра значения
assign is_mode_addr = addr_i == 32'h4;   // Адрес регистра режима
assign is_rst_addr  = addr_i == 32'h24;  // Адрес регистра сброса

assign write_req = write_enable_i & req_i;  // Активная запись
assign read_req  = ~write_enable_i & req_i; // Активное чтение

assign rst = rst_i | (write_req & is_rst_addr & (write_data_i == 32'd1)); // Общий сброс
assign val_en  = write_req & is_val_addr;  // Запись значения LED
assign mode_en = write_req & is_mode_addr; // Запись режима работы

always_ff @(posedge clk_i) begin
    if (rst) 
        led_val <= 0;
    else if (val_en)
        led_val <= write_data_i[15:0]; // Сохраняем 16 бит для светодиодов
end

always_ff @(posedge clk_i) begin
    if (rst)
        led_mode <= 0;
    else if (mode_en)
        led_mode <= write_data_i[0]; // 0 - постоянный свет, 1 - мигание
end

always_ff @(posedge clk_i) begin
    if (rst)
        read_data_o <= 0;
    else if (read_req & (is_val_addr | is_mode_addr))
        read_data_o <= (is_val_addr ? {16'd0, led_val} : {31'd0, led_mode}); // Чтение регистров
end

assign reset = ~led_mode | (cntr >= 32'd20_000_000) | rst; // Сброс счётчика в нужных режимах

always_ff @(posedge clk_i) begin
    if (reset)
        cntr <= 0;
    else if (led_mode)
        cntr <= cntr + 32'd1; // Счётчик работает только в режиме мигания
end

assign led_o = (cntr < 32'd10_000_000) ? led_val : 16'd0; // Первая половина периода - свет, вторая - пауза

endmodule