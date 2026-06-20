`timescale 1ns / 1ps

module vga_sb_ctrl (
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        clk100m_i,
    input  logic        req_i,
    input  logic        write_enable_i,
    input  logic [3:0]  mem_be_i,
    input  logic [31:0] addr_i,
    input  logic [31:0] write_data_i,
    output logic [31:0] read_data_o,

    output logic [3:0]  vga_r_o,
    output logic [3:0]  vga_g_o,
    output logic [3:0]  vga_b_o,
    output logic        vga_hs_o,
    output logic        vga_vs_o
);
    
logic char_map_req_i;
logic char_map_we_i;
logic char_map_rdata_o;

logic col_map_req_i;
logic col_map_we_i;
logic col_map_rdata_o;

logic char_tiff_req_i;
logic char_tiff_we_i;
logic char_tiff_rdata_o;

always_comb begin
    char_map_req_i = 0;
    char_map_we_i = 0;
    char_map_rdata_o = 0;

    col_map_req_i = 0;
    col_map_we_i = 0;
    col_map_rdata_o = 0;

    char_tiff_req_i = 0;
    char_tiff_we_i = 0;
    char_tiff_rdata_o = 0;
    
    case(addr_i[13:12])
        2'b00: begin
            char_map_req_i = req_i;
            char_map_we_i = mem_be_i;
            char_map_rdata_o = read_data_o;
        end
        2'b01: begin
            col_map_req_i = req_i;
            col_map_we_i = mem_be_i;
            col_map_rdata_o = read_data_o;
        end
        2'b10: begin
            char_tiff_req_i = req_i;
            char_tiff_we_i = mem_be_i;
            char_tiff_rdata_o = read_data_o;
        end
        default: ;
    endcase
end

vgachargen VGA (
    .clk_i(clk_i),         // Системный тактовый сигнал
    .clk100m_i(clk100m_i), // Тактовый сигнал 100 МГц
    .rst_i(rst_i),         // Сигнал сброса

    // Интерфейс карты символов
    //.char_map_req_i,                  // Запрос к карте символов
    .char_map_addr_i(addr_i[11:2]),     // Адрес ячейки карты символов
    //.char_map_we_i,                   // Разрешение записи байта
    .char_map_be_i(mem_be_i ),          // Маска байтов для записи
    .char_map_wdata_i(write_data_i),    // ASCII-код символа для записи
    //.char_map_rdata_o,                // Данные чтения из карты

    // Интерфейс палитры цветов
    //.col_map_req_i,                   // Запрос к палитре цветов
    .col_map_addr_i(addr_i[11:2]),      // Адрес ячейки палитры
    //.col_map_we_i,                    // Разрешение записи в палитру
    .col_map_be_i(mem_be_i ),           // Маска байтов для записи
    .col_map_wdata_i(write_data_i),     // Код цвета для палитры
    //.col_map_rdata_o,                 // Данные чтения из палитры

    // Интерфейс тайлов шрифта
    //.char_tiff_req_i,                 // Запрос к тайлам шрифта
    .char_tiff_addr_i(addr_i[11:2]),    // Адрес ячейки памяти тайлов
    //.char_tiff_we_i,                  // Разрешение записи в тайлы
    //.char_tiff_be_i(mem_be_i),        // Маска байтов для записи
    .char_tiff_wdata_i(write_data_i),   // Данные для записи в тайлы шрифта
    //.char_tiff_rdata_o,               // Данные чтения из памяти тайлов

    .vga_r_o(vga_r_o),   // Красный канал VGA
    .vga_g_o(vga_g_o),   // Зеленый канал VGA
    .vga_b_o(vga_b_o),   // Синий канал VGA
    .vga_hs_o(vga_hs_o), // Горизонтальная синхронизация VGA
    .vga_vs_o(vga_vs_o)  // Вертикальная синхронизация VGA
);

endmodule