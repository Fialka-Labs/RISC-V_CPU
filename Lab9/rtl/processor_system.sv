`timescale 10ns / 1ps

module processor_system(
    input logic clk_i,
    input logic resetn_i,
    
    // Входы и выходы периферии
    input  logic [15:0] sw_i,       // Переключатели
    
    output logic [15:0] led_o,      // Светодиоды
    
    input  logic        kclk_i,     // Тактирующий сигнал клавиатуры
    input  logic        kdata_i,    // Сигнал данных клавиатуры
    
    output logic [ 6:0] hex_led_o,  // Вывод семисегментных индикаторов
    output logic [ 7:0] hex_sel_o,  // Селектор семисегментных индикаторов
    
    input  logic        rx_i,       // Линия приёма по UART
    output logic        tx_o,       // Линия передачи по UART
    
    output logic [3:0]  vga_r_o,    // Красный канал vga
    output logic [3:0]  vga_g_o,    // Зелёный канал vga
    output logic [3:0]  vga_b_o,    // Синий канал vga
    output logic        vga_hs_o,   // Линия горизонтальной синхронизации vga
    output logic        vga_vs_o    // Линия вертикальной синхронизации vga
);

import memory_pkg::*;

logic sysclk, rst;
sys_clk_rst_gen divider(
    .ex_clk_i(clk_i),
    .ex_areset_n_i(resetn_i),
    .div_i(5),
    .sys_clk_o(sysclk), 
    .sys_reset_o(rst)
);

// Сигналы ядра
logic [31:0] instr;
logic [31:0] mem_rd;
logic [31:0] instr_addr;
logic [31:0] mem_addr;
logic [ 2:0] mem_size;
logic        mem_req;
logic        mem_we;
logic [31:0] mem_wd;
logic        stall;

logic [15:0] irq_req;
logic [15:0] irq_ret;

logic        sw_irq_req;
logic        sw_irq_ret;

assign irq_req = {15'b0, sw_irq_req};
assign sw_irq_ret = irq_ret[0];

// Сигналы для LSU
logic        lsu_mem_req;
logic        lsu_mem_we;
logic [ 3:0] lsu_mem_be;
logic [31:0] lsu_mem_addr;
logic [31:0] lsu_mem_wd;
logic [31:0] lsu_mem_rd;
logic        lsu_mem_ready;


// Сигналы для мультиплексора
logic        mult_req;
logic        mult_we;
logic [ 3:0] mult_be;
logic [31:0] mult_wd;
logic [31:0] mult_addr;

// Сигналы для периферии
logic [255:0] onehot_o;
logic [7:0]   peripherial_address;
logic         sw_req;
logic         led_req;
logic         mem_req_periph;

assign peripherial_address = lsu_mem_addr[31:24];
assign onehot_o = 256'd1 << peripherial_address;

assign mem_req_periph = mult_req & onehot_o[0];
assign sw_req =         mult_req & onehot_o[1];
assign led_req =        mult_req & onehot_o[2];

logic [31:0] data_mem_rd;
logic [31:0] sw_rd;
logic [31:0] led_rd;

always_comb begin
    case (peripherial_address)
        8'd0: lsu_mem_rd = data_mem_rd;
        8'd1: lsu_mem_rd = sw_rd;
        8'd2: lsu_mem_rd = led_rd;
    endcase
end

// Сигналы для программатора
logic [31:0] bluster_instr_addr;
logic [31:0] bluster_instr_wdata;
logic        bluster_instr_we;

logic [31:0] bluster_data_addr;
logic [31:0] bluster_data_wdata;
logic        bluster_data_we;

logic        bluster_core_reset;

// Мультиплексор
always_comb begin
    if (bluster_core_reset) begin
        mult_req  = bluster_data_we;
        mult_we   = bluster_data_we;
        mult_be   = 4'hF;
        mult_wd   = bluster_data_wdata;
        mult_addr = bluster_data_addr;
    end
    else begin
        mult_req  = lsu_mem_req;
        mult_we   = lsu_mem_we;
        mult_be   = lsu_mem_be;
        mult_wd   = lsu_mem_wd;
        mult_addr = lsu_mem_addr;
    end
end

// Память инструкций (старая)
/*instr_mem instr_mem(
    .read_addr_i(instr_addr),
    .read_data_o(instr)
);*/

// Память инструкций (новая)
rw_instr_mem rw_instr_mem(
    .clk_i(sysclk),
    .read_addr_i(instr_addr),
    .read_data_o(instr),
    .write_addr_i(bluster_instr_addr),
    .write_data_i(bluster_instr_wdata),
    .write_enable_i(bluster_instr_we)
);

// Программатор
bluster bluster(
    .clk_i(sysclk),
    .rst_i(rst),
    .rx_i(rx_i),
    .tx_o(tx_o),
    .instr_addr_o(bluster_instr_addr),
    .instr_wdata_o(bluster_instr_wdata),
    .instr_we_o(bluster_instr_we),
    .data_addr_o(bluster_data_addr),
    .data_wdata_o(bluster_data_wdata),
    .data_we_o(bluster_data_we),
    .core_reset_o(bluster_core_reset)
);

// Память данных
data_mem data_mem(
    .clk_i(sysclk),
    .mem_req_i(mem_req_periph),
    .write_enable_i(mult_we),
    .byte_enable_i(mult_be),
    .addr_i({8'b0, mult_addr[23:0]}),
    .write_data_i(mult_wd),
    .read_data_o(data_mem_rd),
    .ready_o(lsu_mem_ready)
);

// LSU (Load-Store Unit)
lsu LSU (
    .clk_i(sysclk),
    .rst_i(rst),
    
    // Интерфейс с ядром
    .core_req_i(mem_req),
    .core_we_i(mem_we),
    .core_size_i(mem_size),
    .core_addr_i(mem_addr),
    .core_wd_i(mem_wd),
    .core_rd_o(mem_rd),
    .core_stall_o(stall),
    
    // Интерфейс с памятью
    .mem_req_o(lsu_mem_req),
    .mem_we_o(lsu_mem_we),
    .mem_be_o(lsu_mem_be),
    .mem_addr_o(lsu_mem_addr),
    .mem_wd_o(lsu_mem_wd),
    .mem_rd_i(lsu_mem_rd),
    .mem_ready_i(lsu_mem_ready)
);

// Ядро
processor_core core_inst(
    .clk_i(sysclk),
    .rst_i(bluster_core_reset),
    .stall_i(stall),
    .instr_i(instr),
    .mem_rd_i(mem_rd),
    
    .irq_req_i(irq_req),
    
    .instr_addr_o(instr_addr),
    .mem_addr_o(mem_addr),
    .mem_size_o(mem_size),
    .mem_req_o(mem_req),
    .mem_we_o(mem_we),
    .mem_wd_o(mem_wd),
    
    .irq_ret_o(irq_ret)
);

// SW переключатели
sw_sb_ctrl sw_sb_ctrl(
    .sw_i(sw_i),
    .clk_i(sysclk),
    .rst_i(rst),
    .req_i(sw_req),
    .write_enable_i(mult_we),
    .addr_i({8'b0, mult_addr[23:0]}),
    .write_data_i(mult_wd),
    .read_data_o(sw_rd),
    .interrupt_return_i(sw_irq_ret),
    .interrupt_request_o(sw_irq_req)
);

// LED светодиоды
led_sb_ctrl led_sb_ctrl(
    .clk_i(sysclk),
    .rst_i(rst),
    .req_i(led_req),
    .write_enable_i(mult_we),
    .addr_i({8'b0, mult_addr[23:0]}),
    .write_data_i(mult_wd),
    .read_data_o(led_rd),
    .led_o(led_o)
);

endmodule