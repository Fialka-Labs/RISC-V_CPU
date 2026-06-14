`timescale 1ns / 1ps

module CYBERcobra (
    input  logic         clk_i,
    input  logic         rst_i, 
    input  logic [15:0]  sw_i,
    output logic [31:0]  out_o
);

logic [31:0] imem;
logic [1:0]  ws; // Write Sourse, т.е. управление данными на входе WD
logic        b; // branch, т.е. условный переход (перепрыгивание заданного количества команд)
logic        j; // jump, т.е. безусловный переход

logic [31:0] pc_i;
logic [31:0] pc_o;

logic [31:0] b_i; // Провод на fulladder32

logic [31:0] rd1;
logic [31:0] rd2;
logic [31:0] wd;

logic [31:0] alu_o;
logic        flag; // Условие условного перехода, т.е. условный переход выполняется при flag == 1


always_ff @(posedge clk_i or posedge rst_i) begin 
    if (rst_i) pc_o <= 0;  
    else pc_o <= pc_i;
end

always_comb
begin
    ws = imem[29:28];
    case(ws)
        2'b00 : wd = {{9{imem[27]}}, imem[27:5]}; // Запись константы в регистровый файл
        2'b01 : wd = alu_o; // Запись результата АЛУ в регистровый файл
        2'b10 : wd = {{15{sw_i[15]}}, sw_i}; // Загрузка данных с внешних устройств
        default : wd = 32'd0; // Разрешение неопределённости при WS == 3
    endcase
    
    b = imem[30];
    j = imem[31];
    if ((b && flag) || j) b_i = {{22{imem[12]}}, imem[12:5], 2'b0}; // Выполнение условного перехода
    else b_i = 32'd4;
    
    j = imem[31];
    
end

instr_mem instr_mem(
    .read_addr_i(pc_o),
    .read_data_o(imem));
   
fulladder32 fulladder32(
    .a_i(pc_o),
    .b_i(b_i),
    .carry_i(0),
    .sum_o(pc_i));

register_file register_file(
    .clk_i(clk_i),
    .write_enable_i(!(b || j)), // Если не операция какого-либо перехода, то только в этом случае данные будут записаны в регистровый файл
    .read_addr1_i(imem[22:18]), // Указание на то, из какого регистра будут браться данные на АЛУ
    .read_addr2_i(imem[17:13]), // Аналогично 1 регистру
    .write_addr_i(imem[4:0]), // Указание на то, в какой регистр запишутся данные
    .write_data_i(wd), // Запись результат АЛУ в указанный в WA регистр
    .read_data1_o(rd1),
    .read_data2_o(rd2));
    
alu alu(
    .a_i(rd1),
    .b_i(rd2),
    .alu_op_i(imem[27:23]), // Указание на то, какая операция АЛУ будет выполнена
    .result_o(alu_o),
    .flag_o(flag));
    
assign out_o = rd1;

endmodule;