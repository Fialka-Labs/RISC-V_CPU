`timescale 1ns / 1ps

module bluster
(
    input   logic clk_i,
    input   logic rst_i,
    
    input   logic rx_i,
    output  logic tx_o,
    
    output logic [ 31:0] instr_addr_o,
    output logic [ 31:0] instr_wdata_o,
    output logic         instr_we_o,
    
    output logic [ 31:0] data_addr_o,
    output logic [ 31:0] data_wdata_o,
    output logic         data_we_o,
    
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
}
state, next_state;

logic rx_busy, rx_valid, tx_busy, tx_valid;
logic [7:0] rx_data, tx_data;

logic [5:0] msg_counter;
logic [31:0] size_counter, flash_counter;
logic [3:0] [7:0] flash_size, flash_addr;

logic send_fin, size_fin, flash_fin, next_round;

assign send_fin   = (msg_counter   == 0) && !tx_busy;
assign size_fin   = (size_counter  == 0) && !rx_busy;
assign flash_fin  = (flash_counter == 0) && !rx_busy;
assign next_round = (flash_addr    != '1) && !rx_busy;

logic [7:0] [7:0] flash_size_ascii, flash_addr_ascii;

genvar i;
generate
    for (i = 0; i < 4; i = i + 1) begin
        assign flash_size_ascii[i*2]    = flash_size[i][3:0] < 4'ha ? flash_size[i][3:0] + 8'h30 :
                                                                       flash_size[i][3:0] + 8'h57;
        assign flash_size_ascii[i*2+1]  = flash_size[i][7:4] < 4'ha ? flash_size[i][7:4] + 8'h30 :
                                                                       flash_size[i][7:4] + 8'h57;
        
        assign flash_addr_ascii[i*2]    = flash_addr[i][3:0] < 4'ha ? flash_addr[i][3:0] + 8'h30 :
                                                                       flash_addr[i][3:0] + 8'h57;
        assign flash_addr_ascii[i*2+1]  = flash_addr[i][7:4] < 4'ha ? flash_addr[i][7:4] + 8'h30 :
                                                                       flash_addr[i][7:4] + 8'h57;
    end 
endgenerate

logic [INIT_MSG_SIZE-1:0][7:0] init_msg;
assign init_msg = { 8'h72, 8'h65, 8'h61, 8'h64, 8'h79, 8'h20, 8'h66, 8'h6F,
                    8'h72, 8'h20, 8'h66, 8'h6C, 8'h61, 8'h73, 8'h68, 8'h20,
                    8'h73, 8'h74, 8'h61, 8'h72, 8'h74, 8'h69, 8'h6E, 8'h67,
                    8'h20, 8'h66, 8'h72, 8'h6F, 8'h6D, 8'h20, 8'h30, 8'h78,
                    flash_addr_ascii, 8'h0a};

logic [FLASH_MSG_SIZE-1:0][7:0] flash_msg;
assign flash_msg = {8'h66, 8'h69, 8'h6E, 8'h69, 8'h73, 8'h68, 8'h65, 8'h64,
                    8'h20, 8'h77, 8'h72, 8'h69, 8'h74, 8'h65, 8'h20, 8'h30,
                    8'h78,      flash_size_ascii,      8'h20, 8'h62, 8'h79,
                    8'h74, 8'h65, 8'h73, 8'h20, 8'h73, 8'h74, 8'h61, 8'h72,
                    8'h74, 8'h69, 8'h6E, 8'h67, 8'h20, 8'h66, 8'h72, 8'h6F,
                    8'h6D, 8'h20, 8'h30, 8'h78,     flash_addr_ascii,
                    8'h0a};

logic tx_fire;
assign tx_fire  = (state == INIT_MSG || state == SIZE_ACK || state == FLASH_ACK) && !tx_busy;
assign tx_valid = tx_fire;

always_ff @(posedge clk_i) begin
    if (rst_i) begin
        state <= RCV_NEXT_COMMAND;
        size_counter <= 4;
        flash_counter <= 0;
        msg_counter <= INIT_MSG_SIZE - 1;
        
        instr_addr_o <= 0;
        instr_wdata_o <= 0;
        instr_we_o <= 0;
        data_addr_o <= 0;
        data_wdata_o <= 0;
        data_we_o <= 0;
        
        flash_size <= 0;
        flash_addr <= 0;
        tx_data <= 0;
        core_reset_o <= 1;
    end
    else begin
        state <= next_state;

        case (state)
            RCV_NEXT_COMMAND: begin
                if (rx_valid) begin
                    size_counter <= size_counter - 1;
                    flash_addr <= {flash_addr[2:0], rx_data};
                end
                flash_counter <= flash_size;
                tx_data <= 0;
                msg_counter <= INIT_MSG_SIZE - 1;
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end

            FINISH: begin
                size_counter <= 4;
                flash_counter <= flash_size;
                tx_data <= 0;
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 0;
            end

            INIT_MSG: begin
                size_counter <= 4;
                flash_counter <= flash_size;
                tx_data <= init_msg[msg_counter];
                if (tx_fire && msg_counter != 0) begin
                    msg_counter <= msg_counter - 1;
                end
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end

            RCV_SIZE: begin
                if (rx_valid) begin
                    size_counter <= size_counter - 1;
                    flash_size <= {flash_size[2:0], rx_data};
                end
                flash_counter <= flash_size;
                tx_data <= 0;
                msg_counter <= ACK_MSG_SIZE - 1;
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end

            SIZE_ACK: begin
                size_counter <= 4;
                flash_counter <= flash_size;
                tx_data <= flash_size_ascii[msg_counter];
                if (tx_fire && msg_counter != 0) begin
                    msg_counter <= msg_counter - 1;
                end
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end

            FLASH: begin
                size_counter <= 4;
                tx_data <= 0;

                if (rx_valid) begin
                    flash_counter <= flash_counter - 1;
                    if (flash_addr < INSTR_MEM_SIZE_BYTES) begin
                        instr_wdata_o <= {instr_wdata_o[23:0], rx_data};
                        instr_we_o <= (flash_counter[1:0] == 2'b01);
                        instr_addr_o <= flash_addr + flash_counter - 1;
                        data_we_o <= 0;
                    end
                    else begin
                        data_wdata_o <= {data_wdata_o[23:0], rx_data};
                        data_we_o <= (flash_counter[1:0] == 2'b01);
                        data_addr_o <= flash_addr + flash_counter - 1;
                        instr_we_o <= 0;
                    end
                end
                else begin
                    instr_we_o <= 0;
                    data_we_o <= 0;
                end

                msg_counter <= FLASH_MSG_SIZE - 1;
                core_reset_o <= 1;
            end

            FLASH_ACK: begin
                size_counter <= 4;
                flash_counter <= flash_size;
                tx_data <= flash_msg[msg_counter];
                if (tx_fire && msg_counter != 0) begin
                    msg_counter <= msg_counter - 1;
                end
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end

            default: begin
                size_counter <= 4;
                flash_counter <= flash_size;
                tx_data <= 0;
                instr_we_o <= 0;
                data_we_o <= 0;
                core_reset_o <= 1;
            end
        endcase
    end
end

always_comb begin
    next_state = state;
    case (state)
        RCV_NEXT_COMMAND: begin
            if (size_fin & next_round) begin
                next_state = INIT_MSG;
            end
            else if (size_fin & !next_round) begin
                next_state = FINISH;
            end
        end

        FINISH: begin
            next_state = FINISH;
        end

        INIT_MSG: begin
            if (send_fin) begin
                next_state = RCV_SIZE;
            end
        end

        RCV_SIZE: begin
            if (size_fin) begin
                next_state = SIZE_ACK;
            end
        end

        SIZE_ACK: begin
            if (send_fin) begin
                next_state = FLASH;
            end
        end

        FLASH: begin
            if (flash_fin) begin
                next_state = FLASH_ACK;
            end
        end

        FLASH_ACK: begin
            if (send_fin) begin
                next_state = RCV_NEXT_COMMAND;
            end
        end

        default: begin
            next_state = state;
        end
    endcase
end

uart_rx rx(
    .clk_i      (clk_i      ),
    .rst_i      (rst_i      ),
    .rx_i       (rx_i       ),
    .busy_o     (rx_busy    ),
    .baudrate_i (17'd115200 ),
    .parity_en_i(1'b1       ),
    .stopbit_i  (2'b1       ),
    .rx_data_o  (rx_data    ),
    .rx_valid_o (rx_valid   )
);

uart_tx tx(
    .clk_i      (clk_i      ),
    .rst_i      (rst_i      ),
    .tx_o       (tx_o       ),
    .busy_o     (tx_busy    ),
    .baudrate_i (17'd115200 ),
    .parity_en_i(1'b1       ),
    .stopbit_i  (2'b1       ),
    .tx_data_i  (tx_data    ),
    .tx_valid_i (tx_valid   )
);

endmodule