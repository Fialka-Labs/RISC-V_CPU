#include "platform.h"

int main(int argc, char** argv)
{
	led_ptr->rst = 1; 
	led_ptr->rst = 0;
	while(1) {}
	return 0;
}

void int_handler()
{
	uint32_t sw_i = sw_ptr->value;
	uint32_t sw_en = sw_i & 0x00008000;
	uint32_t out_o;
	
	uint32_t mask_source = 0x0000AAAA; // Маска чётных битов
	uint32_t mask_1 = 0x00003333; // 1-я стадия: группы по 2 бита
	uint32_t mask_2 = 0x00000F0F; // 2-я стадия: группы по 4 бита
	uint32_t mask_4 = 0x000000FF; // 3-я стадия: группы по 8 бит
	
	uint32_t x = sw_i & mask_source; // Выделение нужных битов
	x >>= 1; // Сдвиг вправо на 1
	
	// Стадия сжатия 1
	uint32_t temp = x >> 1;
	x = (temp | x) & mask_1;
	
	// Стадия сжатия 2
	temp = x >> 2;
	x = (temp | x) & mask_2;
	
	// Стадия сжатия 3
	temp = x >> 4;
	x = (temp | x) & mask_4;
	
	// Результат в out_o
	out_o = x;
	
	if (sw_en == 0x00008000) {
		led_ptr->value = out_o;
	}
	else led_ptr->value = 0x00000000;
}