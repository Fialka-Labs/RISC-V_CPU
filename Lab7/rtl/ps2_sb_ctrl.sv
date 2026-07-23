`timescale 1ns / 1ps

module ps2_sb_ctrl(
/*
    Часть интерфейса модуля, отвечающая за подключение к системной шине
*/
  input  logic         clk_i,
  input  logic         rst_i,
  input  logic [31:0]  addr_i,
  input  logic         req_i,
  input  logic [31:0]  write_data_i,
  input  logic         write_enable_i,
  output logic [31:0]  read_data_o,

/*
    Часть интерфейса модуля, отвечающая за отправку запросов на прерывание
    процессорного ядра
*/

  output logic        interrupt_request_o,
  input  logic        interrupt_return_i,

/*
    Часть интерфейса модуля, отвечающая за подключение к модулю,
    осуществляющему приём данных с клавиатуры
*/
  input  logic kclk_i,
  input  logic kdata_i
);

logic [7:0] scan_code;
logic       scan_code_is_unread;

logic [7:0] keycode_o;
logic       keycode_valid_o;

PS2Receiver ps2receiver(
    .clk_i(clk_i),         
    .rst_i(rst_i),         
    .kclk_i(kclk_i),       
    .kdata_i(kdata_i),     
    .keycode_o(keycode_o), 
    .keycode_valid_o(keycode_valid_o)
);

logic write_req;
logic read_req;

assign write_req = req_i & write_enable_i;
assign read_req  = req_i & ~write_enable_i;

// scan_code
always_ff @(posedge clk_i) begin
    if (keycode_valid_o)
        scan_code <= keycode_o;
    if (((addr_i == 32'h24) & write_req & (write_data_i == 32'd1)) | rst_i)
        scan_code <= 8'b0;
end

// scan_code_is_unread
always_ff @(posedge clk_i) begin
    if (keycode_valid_o) 
        scan_code_is_unread <= 1'b1;
    else begin
        if ((addr_i == 32'h0) & read_req)
            scan_code_is_unread <= 1'b0;
        if (interrupt_return_i)
            scan_code_is_unread <= 1'b0;
    end
    if (((addr_i == 32'h24) & write_req & (write_data_i == 32'd1)) | rst_i) 
        scan_code_is_unread <= 1'b0;
end

// read_data_o
always_ff @(posedge clk_i) begin
    if ((addr_i == 32'h0) & read_req)
        read_data_o <= {24'b0, scan_code};
    if ((addr_i == 32'h4) & read_req)
        read_data_o <= {31'b0, scan_code_is_unread};
end

assign interrupt_request_o = scan_code_is_unread;

endmodule
