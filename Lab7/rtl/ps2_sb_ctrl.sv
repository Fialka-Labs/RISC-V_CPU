`timescale 1ns / 1ps

module ps2_sb_ctrl(
    // Шина подключения модуля, подключенная к процессору и системной шине
    input  logic         clk_i,
    input  logic         rst_i,
    input  logic [31:0]  addr_i,
    input  logic         req_i,
    input  logic [31:0]  write_data_i,
    input  logic         write_enable_i,
    output logic [31:0]  read_data_o,
    
    // Линии запроса прерывания и подтверждения прерывания
    output logic interrupt_request_o,
    input  logic interrupt_return_i,
    
    // Входы подключения к линиям тактового сигнала и данных клавиатуры
    input  logic kclk_i,
    input  logic kdata_i
);
logic [7:0] scan_code;
logic       scan_code_is_unread;

// Приёмник PS/2, обрабатывающий сигналы клавиатуры
logic [7:0] keycode;
logic keycode_valid;

PS2Receiver PS_2 (
    .clk_i(clk_i),                  // Системный тактовый сигнал
    .rst_i(rst_i),                  // Системный сброс
    .kclk_i(kclk_i),                // Тактовый сигнал, поступающий с клавиатуры
    .kdata_i(kdata_i),              // Данные, поступающие с клавиатуры
    .keycode_o(keycode),            // Принятый скан-код клавиши
    .keycode_valid_o(keycode_valid) // Флаг достоверности данных на выходе
);

assign interrupt_request_o = scan_code_is_unread;

logic write_req;
logic read_req;
assign write_req = req_i & write_enable_i;
assign read_req  = req_i & ~write_enable_i;

logic ill_addr;
logic read_req_scan_code;
logic read_req_scan_code_is_unread;
logic write_req_reset; 

always_comb begin
    ill_addr = 0;
    read_req_scan_code = 0;
    read_req_scan_code_is_unread = 0;
    write_req_reset = 0;
    
    if(addr_i[31:24] == 8'h03) begin
        case(addr_i[23:0])
            24'h000000: begin
               if(read_req)  read_req_scan_code = 1;
            end
            24'h000004: begin
               if(read_req)  read_req_scan_code_is_unread = 1;
            end
            24'h000024: begin
               if(write_req) write_req_reset = 1;
            end
            default: ill_addr = 1;
        endcase
    end
    else begin
        ill_addr = 1;
    end
end

always_ff@(posedge clk_i) begin
    if(rst_i) begin
        scan_code <= '0;
        scan_code_is_unread <= '0;
    end
    else begin
        if(keycode_valid) begin
            scan_code <= keycode;
            scan_code_is_unread <= 1;
        end
        else begin
            if(read_req_scan_code) begin          // Чтение по адресу скан-кода               
                read_data_o <= {24'b0, scan_code};
                scan_code_is_unread <= '0;
            end
            if(interrupt_return_i ) scan_code_is_unread <= '0;
        end
        if(read_req_scan_code_is_unread) begin    // Чтение флага scan_code_is_unread
            read_data_o <= {31'b0, scan_code_is_unread};
        end
        if(write_req_reset) begin                 // Запись сброса
            scan_code <= '0;
            scan_code_is_unread <= '0;
        end
    end
end 
    
endmodule