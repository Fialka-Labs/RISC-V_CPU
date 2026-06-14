`timescale 1ns / 1ps

module timer_sb_ctrl(
/*
    Часть интерфейса модуля, отвечающая за подключение к системной шине
*/
    input  logic        clk_i,
    input  logic        rst_i,
    input  logic        req_i,
    input  logic        write_enable_i,
    input  logic [31:0] addr_i,
    input  logic [31:0] write_data_i,
    output logic [31:0] read_data_o,
    output logic        ready_o,
/*
    Часть интерфейса модуля, отвечающая за отправку запросов на прерывание
    процессорного ядра
*/
    output logic        interrupt_request_o
);

logic [63:0] system_counter;
logic [63:0] delay;
enum logic [1:0] {OFF, NTIMES, FOREVER} mode, next_mode;
logic [31:0] repeat_counter;
logic [63:0] system_counter_at_start;

assign ready_o = req_i;

always_comb begin
    next_mode = mode; // Обновление режима
    
    // Чтение из адресного пространства
    if (req_i && !write_enable_i) begin
        case (addr_i)
            32'h00: read_data_o = system_counter[31:0];
            32'h04: read_data_o = system_counter[63:32];
            32'h08: read_data_o = delay[31:0];
            32'h0c: read_data_o = delay[63:32];
            32'h10: read_data_o = {30'b0, mode};
            32'h14: read_data_o = repeat_counter;
            default: read_data_o = 32'd0;
        endcase
    end
    else read_data_o = 32'd0;
    
    // Задаём новый режим
    if (req_i && write_enable_i && (addr_i == 32'h10)) begin
        case (write_data_i[1:0])
            2'd0: next_mode = OFF;
            2'd1: next_mode = NTIMES;
            2'd2: next_mode = FOREVER;
            default: next_mode = OFF;
        endcase
    end
    else if ((mode == NTIMES) && (repeat_counter == 32'd0)) begin
        next_mode = OFF;
    end
end

// Условие генерации прерывания (длится ровно 1 такт)
assign interrupt_request_o = (mode != OFF) 
       && (system_counter == system_counter_at_start + delay);

always_ff @(posedge clk_i) begin
    // Аппаратный сброс
    if (rst_i) begin
        system_counter          <= 64'd0;
        delay                   <= 64'd0;
        mode                    <= OFF;
        repeat_counter          <= 32'd0;
        system_counter_at_start <= 64'd0;
    end
    else begin
        system_counter <= system_counter + 64'd1; // Инкремент системного счётчика каждый такт
        
        if (req_i && write_enable_i) begin
            case (addr_i)
                32'h08: delay[31:0]  <= write_data_i;
                32'h0c: delay[63:32] <= write_data_i;
                32'h10: begin
                    mode <= next_mode; // Обновление режима
                    
                    // Старт таймера
                    if (write_data_i[1:0] != 2'd0)
                        system_counter_at_start <= system_counter;
                end
                32'h14: repeat_counter <= write_data_i;
                32'h24: begin
                    if (write_data_i == 32'd1) begin
                        system_counter          <= 64'd0;
                        delay                   <= 64'd0;
                        mode                    <= OFF;
                        repeat_counter          <= 32'd0;
                        system_counter_at_start <= 64'd0;
                    end
                end
                default:;
            endcase
        end
        // Автовыключение режима NTIMES
        else if ((mode == NTIMES) && (repeat_counter == 32'd0)) begin
            mode <= OFF;
        end
        
        // Обработка прерывания
        if (interrupt_request_o) begin
            // Бесконечный режим
            if (mode == FOREVER) begin
                system_counter_at_start <= system_counter;
            end
            else if (mode == NTIMES) begin
                if (repeat_counter != 32'd0) begin
                    // Уменьшаем счётчик повторений
                    repeat_counter <= repeat_counter - 32'd1;

                    if (repeat_counter == 32'd1) begin
                        // Это было последнее прерывание, поэтому выключаем
                        mode <= OFF;
                    end
                    else begin
                        // Иначе перезапускаем таймер
                        system_counter_at_start <= system_counter;
                    end
                end
            end
        end
    end
end
endmodule