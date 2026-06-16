`timescale 1ns / 1ps

module led_sb_ctrl(
  // Интерфейс системной шины, предназначенный для взаимодействия с внешним миром
  input  logic        clk_i,
  input  logic        rst_i,
  input  logic        req_i,
  input  logic        write_enable_i,
  input  logic [31:0] addr_i,
  input  logic [31:0] write_data_i,
  output logic [31:0] read_data_o,

  // Интерфейс внешнего порта, предназначенный для взаимодействия со светодиодами
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

assign is_val_addr = addr_i == 32'h0;
assign is_mode_addr = addr_i == 32'h4;
assign is_rst_addr = addr_i == 32'h24;
assign write_req = write_enable_i & req_i;
assign read_req = ~write_enable_i & req_i;
assign rst = rst_i | (write_req & is_rst_addr & (write_data_i == 32'd1));
assign val_en = write_req & is_val_addr;
assign mode_en = write_req & is_mode_addr;

always_ff @(posedge clk_i) begin
    if (rst) led_val <= 0;
    else if (val_en) led_val <= write_data_i[15:0];
end

always_ff @(posedge clk_i) begin
    if (rst) led_mode <= 0;
    else if (mode_en) led_mode <= write_data_i[0];
end

always_ff @(posedge clk_i) begin
    if (rst) read_data_o <= 0;
    else if (read_req & (is_val_addr | is_mode_addr)) read_data_o <= (is_val_addr ? {16'd0, led_val}: {31'd0, led_mode});
end

assign reset = ~led_mode | (cntr >= 32'd20_000_000) | rst;

always_ff @(posedge clk_i) begin
    if (reset) cntr <= 0;
    else if (led_mode) cntr <= cntr + 32'd1;
end

assign led_o = (cntr < 32'd10_000_000) ? led_val : 16'd0;

endmodule