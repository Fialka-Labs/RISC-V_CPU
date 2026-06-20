`timescale 1ns / 1ps

module bluster
(
    input   logic clk_i,
    input   logic rst_i,
    
    input   logic rx_i,
    output  logic tx_o,
    
    output logic [31:0] instr_addr_o,
    output logic [31:0] instr_wdata_o,
    output logic        instr_we_o,
    
    output logic [31:0] data_addr_o,
    output logic [31:0] data_wdata_o,
    output logic        data_we_o,
    
    output logic core_reset_o
);

import memory_pkg::INSTR_MEM_SIZE_BYTES;
import bluster_pkg::INIT_MSG_SIZE;
import bluster_pkg::FLASH_MSG_SIZE;
import bluster_pkg::ACK_MSG_SIZE;

enum logic [2:0] {
    RCV_NEXT_COMMAND,
    INIT_MSG,
    RCV_SIZE,
    SIZE_ACK,
    FLASH,
    FLASH_ACK,
    FINISH
} state, next_state;

logic rx_busy, rx_valid, tx_busy, tx_valid;
logic [7:0] rx_data, tx_data;

logic [5:0] msg_counter;
logic [31:0] size_counter, flash_counter;
logic [3:0][7:0] flash_size, flash_addr;

logic send_fin, size_fin, flash_fin, next_round;

assign send_fin   = (msg_counter == 0) && !tx_busy;
assign size_fin   = (size_counter == 0) && !rx_busy;
assign flash_fin  = (flash_counter == 0) && !rx_busy;
assign next_round = (flash_addr != '1) && !rx_busy;

logic [7:0][7:0] flash_size_ascii, flash_addr_ascii;

genvar i;
generate
    for (i = 0; i < 4; i++) begin
        assign flash_size_ascii[i*2]   = flash_size[i][3:0] < 4'ha ? flash_size[i][3:0] + 8'h30 : flash_size[i][3:0] + 8'h57;
        assign flash_size_ascii[i*2+1] = flash_size[i][7:4] < 4'ha ? flash_size[i][7:4] + 8'h30 : flash_size[i][7:4] + 8'h57;

        assign flash_addr_ascii[i*2]   = flash_addr[i][3:0] < 4'ha ? flash_addr[i][3:0] + 8'h30 : flash_addr[i][3:0] + 8'h57;
        assign flash_addr_ascii[i*2+1] = flash_addr[i][7:4] < 4'ha ? flash_addr[i][7:4] + 8'h30 : flash_addr[i][7:4] + 8'h57;
    end
endgenerate

logic [INIT_MSG_SIZE-1:0][7:0] init_msg;
assign init_msg = {
    8'h72,8'h65,8'h61,8'h64,8'h79,8'h20,8'h66,8'h6F,
    8'h72,8'h20,8'h66,8'h6C,8'h61,8'h73,8'h68,8'h20,
    8'h73,8'h74,8'h61,8'h72,8'h74,8'h69,8'h6E,8'h67,
    8'h20,8'h66,8'h72,8'h6F,8'h6D,8'h20,8'h30,8'h78,
    flash_addr_ascii,8'h0a
};

logic [FLASH_MSG_SIZE-1:0][7:0] flash_msg;
assign flash_msg = {
    8'h66,8'h69,8'h6E,8'h69,8'h73,8'h68,8'h65,8'h64,
    8'h20,8'h77,8'h72,8'h69,8'h74,8'h65,8'h20,8'h30,
    8'h78,flash_size_ascii,8'h20,8'h62,8'h79,
    8'h74,8'h65,8'h73,8'h20,8'h73,8'h74,8'h61,8'h72,
    8'h74,8'h69,8'h6E,8'h67,8'h20,8'h66,8'h72,8'h6F,
    8'h6D,8'h20,8'h30,8'h78,flash_addr_ascii,
    8'h0a
};


// Конечный автомат состояний
// state
always_ff @(posedge clk_i) begin
    if (rst_i) state <= RCV_NEXT_COMMAND;
    else       state <= next_state;
end

// next_state
always_comb begin
    next_state = state;
    case (state)
        RCV_NEXT_COMMAND: begin
            if      (size_fin & next_round)  next_state = INIT_MSG;
            else if (size_fin & ~next_round) next_state = FINISH;
        end
        FINISH: next_state = FINISH;
        INIT_MSG:  if (send_fin)  next_state = RCV_SIZE;
        RCV_SIZE:  if (size_fin)  next_state = SIZE_ACK;
        SIZE_ACK:  if (send_fin)  next_state = FLASH;
        FLASH:     if (flash_fin) next_state = FLASH_ACK;
        FLASH_ACK: if (send_fin)  next_state = RCV_NEXT_COMMAND;
    endcase
end

// size_counter
always_ff @(posedge clk_i) begin
    if (rst_i) size_counter <= 4;
    else begin
        case (state)
            RCV_NEXT_COMMAND: if (rx_valid) size_counter--;
            RCV_SIZE:         if (rx_valid) size_counter--;
            default:          size_counter <= 4;
        endcase
    end
end

// flash_counter
always_ff @(posedge clk_i) begin
    if (rst_i) flash_counter <= flash_size;
    else begin
        case (state)
            FLASH: begin
                if (rx_valid)
                    flash_counter <= flash_counter - 1;
            end
            default: flash_counter <= flash_size;
        endcase
    end
end

// msg_counter
always_ff @(posedge clk_i) begin
    if (rst_i) msg_counter <= INIT_MSG_SIZE-1;
    else begin
        case (state)
            RCV_NEXT_COMMAND: msg_counter <= INIT_MSG_SIZE-1;
            INIT_MSG:  if (~tx_busy) msg_counter--;
            RCV_SIZE:  msg_counter <= ACK_MSG_SIZE-1;
            SIZE_ACK:  if (~tx_busy) msg_counter--;
            FLASH:     msg_counter <= FLASH_MSG_SIZE-1;
            FLASH_ACK: if (~tx_busy) msg_counter--;
        endcase
    end
end

// UART
// tx_valid
always_comb begin
    case (state)
        INIT_MSG:  tx_valid = ~tx_busy;
        SIZE_ACK:  tx_valid = ~tx_busy;
        FLASH_ACK: tx_valid = ~tx_busy;
        default:   tx_valid = 0;
    endcase
end

// tx_data
always_comb begin
    case (state)
        INIT_MSG:  tx_data = init_msg[msg_counter];
        SIZE_ACK:  tx_data = flash_size[msg_counter];
        FLASH_ACK: tx_data = flash_msg[msg_counter];
        default:   tx_data = 0;
    endcase
end


// Реализация интерфейсов памяти инструкций и данных
always_ff @(posedge clk_i) begin
    if (rst_i) begin
        instr_addr_o <= 0;
        instr_wdata_o <= 0;
        instr_we_o <= 0;
        data_addr_o <= 0;
        data_wdata_o <= 0;
        data_we_o <= 0;
    end else begin
        case (state)
            FLASH: begin
                if (rx_valid) begin
                    if (flash_addr < INSTR_MEM_SIZE_BYTES) begin
                        instr_wdata_o <= {instr_wdata_o[23:0], rx_data};
                        instr_we_o    <= (flash_counter[1:0] == 2'b01);
                        instr_addr_o  <= flash_addr + flash_counter - 1;
                        data_we_o     <= 0;
                    end else begin
                        data_wdata_o <= {data_wdata_o[23:0], rx_data};
                        data_we_o    <= (flash_counter[1:0] == 2'b01);
                        data_addr_o  <= flash_addr + flash_counter - 1;
                        instr_we_o   <= 0;
                    end
                end else begin
                    instr_we_o <= 0;
                    data_we_o  <= 0;
                end
            end
            default: begin
                instr_we_o <= 0;
                data_we_o  <= 0;
            end
        endcase
    end
end


// Реализация оставшейся части логики
// flash_size
always_ff @(posedge clk_i) begin
    if (rst_i) flash_size <= 0;
    else if (state == RCV_SIZE && rx_valid)
        flash_size <= {flash_size[2:0], rx_data};
end

// flash_addr
always_ff @(posedge clk_i) begin
    if (rst_i) flash_addr <= 0;
    else if (state == RCV_NEXT_COMMAND && rx_valid)
        flash_addr <= {flash_addr[2:0], rx_data};
end

// core_reset_o
always_ff @(posedge clk_i) begin
    if (rst_i) core_reset_o <= 1;
    else       core_reset_o <= (state != FINISH);
end

uart_rx rx(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .rx_i(rx_i),
    .busy_o(rx_busy),
    .baudrate_i(17'd115200),
    .parity_en_i(1'b1),
    .stopbit_i(2'b1),
    .rx_data_o(rx_data),
    .rx_valid_o(rx_valid)
);

uart_tx tx(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .tx_o(tx_o),
    .busy_o(tx_busy),
    .baudrate_i(17'd115200),
    .parity_en_i(1'b1),
    .stopbit_i(2'b1),
    .tx_data_i(tx_data),
    .tx_valid_i(tx_valid)
);

endmodule