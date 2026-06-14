/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2020 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/

#if defined(_WIN32)
 #include "stdio.h"
 #define IKI_DLLESPEC __declspec(dllimport)
#else
 #define IKI_DLLESPEC
#endif
#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
IKI_DLLESPEC extern void execute_23(char*, char *);
IKI_DLLESPEC extern void execute_25(char*, char *);
IKI_DLLESPEC extern void execute_55(char*, char *);
IKI_DLLESPEC extern void execute_56(char*, char *);
IKI_DLLESPEC extern void execute_57(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_75(char*, char *);
IKI_DLLESPEC extern void execute_150(char*, char *);
IKI_DLLESPEC extern void execute_237(char*, char *);
IKI_DLLESPEC extern void execute_238(char*, char *);
IKI_DLLESPEC extern void execute_239(char*, char *);
IKI_DLLESPEC extern void execute_240(char*, char *);
IKI_DLLESPEC extern void execute_241(char*, char *);
IKI_DLLESPEC extern void execute_242(char*, char *);
IKI_DLLESPEC extern void vlog_const_rhs_process_execute_0_fast_for_reg(char*, char*, char*);
IKI_DLLESPEC extern void execute_246(char*, char *);
IKI_DLLESPEC extern void execute_248(char*, char *);
IKI_DLLESPEC extern void svlog_sampling_process_execute(char*, char*, char*);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_1(char*, char *);
IKI_DLLESPEC extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_4(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_7(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_9(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_10(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_12(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_13(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_14(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_15(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_16(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_17(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_7(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_18(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_19(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_21(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_22(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_9(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_20(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_23(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_24(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_10(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_26(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_27(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_25(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_28(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_29(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_12(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_30(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_31(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_13(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_32(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_33(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_14(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_34(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_d2a50a61_68c8e2c4_35(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_d2a50a61_68c8e2c4_15(char*, char *);
IKI_DLLESPEC extern void execute_318(char*, char *);
IKI_DLLESPEC extern void execute_319(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_156(char*, char *);
IKI_DLLESPEC extern void execute_157(char*, char *);
IKI_DLLESPEC extern void execute_158(char*, char *);
IKI_DLLESPEC extern void execute_159(char*, char *);
IKI_DLLESPEC extern void execute_160(char*, char *);
IKI_DLLESPEC extern void execute_73(char*, char *);
IKI_DLLESPEC extern void execute_161(char*, char *);
IKI_DLLESPEC extern void execute_162(char*, char *);
IKI_DLLESPEC extern void execute_163(char*, char *);
IKI_DLLESPEC extern void execute_164(char*, char *);
IKI_DLLESPEC extern void execute_165(char*, char *);
IKI_DLLESPEC extern void execute_166(char*, char *);
IKI_DLLESPEC extern void execute_167(char*, char *);
IKI_DLLESPEC extern void execute_168(char*, char *);
IKI_DLLESPEC extern void execute_169(char*, char *);
IKI_DLLESPEC extern void execute_170(char*, char *);
IKI_DLLESPEC extern void execute_171(char*, char *);
IKI_DLLESPEC extern void execute_172(char*, char *);
IKI_DLLESPEC extern void execute_173(char*, char *);
IKI_DLLESPEC extern void execute_174(char*, char *);
IKI_DLLESPEC extern void execute_175(char*, char *);
IKI_DLLESPEC extern void execute_176(char*, char *);
IKI_DLLESPEC extern void execute_177(char*, char *);
IKI_DLLESPEC extern void execute_178(char*, char *);
IKI_DLLESPEC extern void execute_179(char*, char *);
IKI_DLLESPEC extern void execute_180(char*, char *);
IKI_DLLESPEC extern void execute_181(char*, char *);
IKI_DLLESPEC extern void execute_182(char*, char *);
IKI_DLLESPEC extern void execute_183(char*, char *);
IKI_DLLESPEC extern void execute_184(char*, char *);
IKI_DLLESPEC extern void execute_185(char*, char *);
IKI_DLLESPEC extern void execute_186(char*, char *);
IKI_DLLESPEC extern void execute_187(char*, char *);
IKI_DLLESPEC extern void execute_188(char*, char *);
IKI_DLLESPEC extern void execute_189(char*, char *);
IKI_DLLESPEC extern void execute_190(char*, char *);
IKI_DLLESPEC extern void execute_191(char*, char *);
IKI_DLLESPEC extern void execute_192(char*, char *);
IKI_DLLESPEC extern void execute_193(char*, char *);
IKI_DLLESPEC extern void execute_194(char*, char *);
IKI_DLLESPEC extern void execute_195(char*, char *);
IKI_DLLESPEC extern void execute_196(char*, char *);
IKI_DLLESPEC extern void execute_197(char*, char *);
IKI_DLLESPEC extern void execute_198(char*, char *);
IKI_DLLESPEC extern void execute_199(char*, char *);
IKI_DLLESPEC extern void execute_200(char*, char *);
IKI_DLLESPEC extern void execute_201(char*, char *);
IKI_DLLESPEC extern void execute_202(char*, char *);
IKI_DLLESPEC extern void execute_203(char*, char *);
IKI_DLLESPEC extern void execute_204(char*, char *);
IKI_DLLESPEC extern void execute_205(char*, char *);
IKI_DLLESPEC extern void execute_206(char*, char *);
IKI_DLLESPEC extern void execute_207(char*, char *);
IKI_DLLESPEC extern void execute_208(char*, char *);
IKI_DLLESPEC extern void execute_209(char*, char *);
IKI_DLLESPEC extern void execute_210(char*, char *);
IKI_DLLESPEC extern void execute_211(char*, char *);
IKI_DLLESPEC extern void execute_212(char*, char *);
IKI_DLLESPEC extern void execute_213(char*, char *);
IKI_DLLESPEC extern void execute_214(char*, char *);
IKI_DLLESPEC extern void execute_215(char*, char *);
IKI_DLLESPEC extern void execute_216(char*, char *);
IKI_DLLESPEC extern void execute_217(char*, char *);
IKI_DLLESPEC extern void execute_218(char*, char *);
IKI_DLLESPEC extern void execute_219(char*, char *);
IKI_DLLESPEC extern void execute_220(char*, char *);
IKI_DLLESPEC extern void execute_221(char*, char *);
IKI_DLLESPEC extern void execute_222(char*, char *);
IKI_DLLESPEC extern void execute_223(char*, char *);
IKI_DLLESPEC extern void execute_224(char*, char *);
IKI_DLLESPEC extern void execute_225(char*, char *);
IKI_DLLESPEC extern void execute_226(char*, char *);
IKI_DLLESPEC extern void execute_227(char*, char *);
IKI_DLLESPEC extern void execute_228(char*, char *);
IKI_DLLESPEC extern void execute_229(char*, char *);
IKI_DLLESPEC extern void execute_230(char*, char *);
IKI_DLLESPEC extern void execute_231(char*, char *);
IKI_DLLESPEC extern void execute_232(char*, char *);
IKI_DLLESPEC extern void execute_233(char*, char *);
IKI_DLLESPEC extern void execute_234(char*, char *);
IKI_DLLESPEC extern void execute_235(char*, char *);
IKI_DLLESPEC extern void execute_236(char*, char *);
IKI_DLLESPEC extern void execute_62(char*, char *);
IKI_DLLESPEC extern void execute_64(char*, char *);
IKI_DLLESPEC extern void execute_66(char*, char *);
IKI_DLLESPEC extern void execute_68(char*, char *);
IKI_DLLESPEC extern void execute_70(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_152(char*, char *);
IKI_DLLESPEC extern void execute_153(char*, char *);
IKI_DLLESPEC extern void execute_154(char*, char *);
IKI_DLLESPEC extern void execute_155(char*, char *);
IKI_DLLESPEC extern void execute_320(char*, char *);
IKI_DLLESPEC extern void execute_321(char*, char *);
IKI_DLLESPEC extern void execute_322(char*, char *);
IKI_DLLESPEC extern void execute_323(char*, char *);
IKI_DLLESPEC extern void execute_324(char*, char *);
IKI_DLLESPEC extern void execute_325(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_48(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[173] = {(funcp)execute_23, (funcp)execute_25, (funcp)execute_55, (funcp)execute_56, (funcp)execute_57, (funcp)execute_74, (funcp)execute_75, (funcp)execute_150, (funcp)execute_237, (funcp)execute_238, (funcp)execute_239, (funcp)execute_240, (funcp)execute_241, (funcp)execute_242, (funcp)vlog_const_rhs_process_execute_0_fast_for_reg, (funcp)execute_246, (funcp)execute_248, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_1, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_d2a50a61_68c8e2c4_1, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_3, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_4, (funcp)assertion_action_m_d2a50a61_68c8e2c4_2, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_2, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_6, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_7, (funcp)assertion_action_m_d2a50a61_68c8e2c4_3, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_5, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_9, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_10, (funcp)assertion_action_m_d2a50a61_68c8e2c4_4, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_8, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_12, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_13, (funcp)assertion_action_m_d2a50a61_68c8e2c4_5, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_11, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_14, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_15, (funcp)assertion_action_m_d2a50a61_68c8e2c4_6, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_16, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_17, (funcp)assertion_action_m_d2a50a61_68c8e2c4_7, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_18, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_19, (funcp)assertion_action_m_d2a50a61_68c8e2c4_8, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_21, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_22, (funcp)assertion_action_m_d2a50a61_68c8e2c4_9, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_20, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_23, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_24, (funcp)assertion_action_m_d2a50a61_68c8e2c4_10, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_26, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_27, (funcp)assertion_action_m_d2a50a61_68c8e2c4_11, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_25, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_28, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_29, (funcp)assertion_action_m_d2a50a61_68c8e2c4_12, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_30, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_31, (funcp)assertion_action_m_d2a50a61_68c8e2c4_13, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_32, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_33, (funcp)assertion_action_m_d2a50a61_68c8e2c4_14, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_34, (funcp)sequence_expr_m_d2a50a61_68c8e2c4_35, (funcp)assertion_action_m_d2a50a61_68c8e2c4_15, (funcp)execute_318, (funcp)execute_319, (funcp)execute_59, (funcp)execute_156, (funcp)execute_157, (funcp)execute_158, (funcp)execute_159, (funcp)execute_160, (funcp)execute_73, (funcp)execute_161, (funcp)execute_162, (funcp)execute_163, (funcp)execute_164, (funcp)execute_165, (funcp)execute_166, (funcp)execute_167, (funcp)execute_168, (funcp)execute_169, (funcp)execute_170, (funcp)execute_171, (funcp)execute_172, (funcp)execute_173, (funcp)execute_174, (funcp)execute_175, (funcp)execute_176, (funcp)execute_177, (funcp)execute_178, (funcp)execute_179, (funcp)execute_180, (funcp)execute_181, (funcp)execute_182, (funcp)execute_183, (funcp)execute_184, (funcp)execute_185, (funcp)execute_186, (funcp)execute_187, (funcp)execute_188, (funcp)execute_189, (funcp)execute_190, (funcp)execute_191, (funcp)execute_192, (funcp)execute_193, (funcp)execute_194, (funcp)execute_195, (funcp)execute_196, (funcp)execute_197, (funcp)execute_198, (funcp)execute_199, (funcp)execute_200, (funcp)execute_201, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_205, (funcp)execute_206, (funcp)execute_207, (funcp)execute_208, (funcp)execute_209, (funcp)execute_210, (funcp)execute_211, (funcp)execute_212, (funcp)execute_213, (funcp)execute_214, (funcp)execute_215, (funcp)execute_216, (funcp)execute_217, (funcp)execute_218, (funcp)execute_219, (funcp)execute_220, (funcp)execute_221, (funcp)execute_222, (funcp)execute_223, (funcp)execute_224, (funcp)execute_225, (funcp)execute_226, (funcp)execute_227, (funcp)execute_228, (funcp)execute_229, (funcp)execute_230, (funcp)execute_231, (funcp)execute_232, (funcp)execute_233, (funcp)execute_234, (funcp)execute_235, (funcp)execute_236, (funcp)execute_62, (funcp)execute_64, (funcp)execute_66, (funcp)execute_68, (funcp)execute_70, (funcp)execute_72, (funcp)execute_152, (funcp)execute_153, (funcp)execute_154, (funcp)execute_155, (funcp)execute_320, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_324, (funcp)execute_325, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_48, (funcp)vlog_transfunc_eventcallback_2state};
const int NumRelocateId= 173;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/lab_05_tb_decoder_behav/xsim.reloc",  (void **)funcTab, 173);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/lab_05_tb_decoder_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(20, 6280, 3,2, 0, 32,6648, 4,0,0,6464, 3,2, 0, 32,18808, 17,0,0,19176, 18,0,0,17424, -5,0,17608, -5,0,21200, 20,0,0,22488, 27,0,0,22304, 26,0,0,23040, 30,0,0,22672, 28,0,0,21384, 21,0,0,20464, 19,0,0,21568, 22,0,0,21752, 23,0,0,21936, 24,0,0,22120, 25,0,0,22856, 29,0,0,6832, 14,0,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/lab_05_tb_decoder_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void subprog_m_d2a50a61_68c8e2c4_42() ;
void subprog_m_d2a50a61_68c8e2c4_41() ;
void subprog_m_d2a50a61_68c8e2c4_40() ;
void subprog_m_d2a50a61_68c8e2c4_39() ;
void subprog_m_d2a50a61_68c8e2c4_38() ;
void subprog_m_d2a50a61_68c8e2c4_37() ;
void subprog_m_d2a50a61_68c8e2c4_36() ;
void subprog_m_d2a50a61_68c8e2c4_35() ;
void subprog_m_d2a50a61_68c8e2c4_34() ;
void subprog_m_d2a50a61_68c8e2c4_33() ;
void subprog_m_d2a50a61_68c8e2c4_32() ;
void subprog_m_d2a50a61_68c8e2c4_31() ;
void subprog_m_d2a50a61_68c8e2c4_30() ;
void subprog_m_d2a50a61_68c8e2c4_29() ;
void subprog_m_d2a50a61_68c8e2c4_28() ;
void subprog_m_d2a50a61_68c8e2c4_47() ;
void subprog_m_d2a50a61_68c8e2c4_46() ;
void subprog_m_d2a50a61_68c8e2c4_45() ;
void subprog_m_d2a50a61_68c8e2c4_51() ;
void subprog_m_d2a50a61_68c8e2c4_50() ;
void subprog_m_d2a50a61_68c8e2c4_49() ;
void subprog_m_d2a50a61_68c8e2c4_56() ;
void subprog_m_d2a50a61_68c8e2c4_55() ;
void subprog_m_d2a50a61_68c8e2c4_54() ;
void subprog_m_d2a50a61_68c8e2c4_59() ;
void subprog_m_d2a50a61_68c8e2c4_92() ;
void subprog_m_d2a50a61_68c8e2c4_95() ;
void subprog_m_d2a50a61_68c8e2c4_98() ;
void subprog_m_d2a50a61_68c8e2c4_101() ;
void subprog_m_d2a50a61_68c8e2c4_64() ;
void subprog_m_d2a50a61_68c8e2c4_63() ;
void subprog_m_d2a50a61_68c8e2c4_62() ;
void subprog_m_d2a50a61_68c8e2c4_69() ;
void subprog_m_d2a50a61_68c8e2c4_68() ;
void subprog_m_d2a50a61_68c8e2c4_67() ;
void subprog_m_d2a50a61_68c8e2c4_74() ;
void subprog_m_d2a50a61_68c8e2c4_73() ;
void subprog_m_d2a50a61_68c8e2c4_72() ;
void subprog_m_d2a50a61_68c8e2c4_79() ;
void subprog_m_d2a50a61_68c8e2c4_78() ;
void subprog_m_d2a50a61_68c8e2c4_77() ;
void subprog_m_d2a50a61_68c8e2c4_84() ;
void subprog_m_d2a50a61_68c8e2c4_83() ;
void subprog_m_d2a50a61_68c8e2c4_82() ;
void subprog_m_d2a50a61_68c8e2c4_89() ;
void subprog_m_d2a50a61_68c8e2c4_88() ;
void subprog_m_d2a50a61_68c8e2c4_87() ;
static char* ng140[] = {(void *)subprog_m_d2a50a61_68c8e2c4_42, (void *)subprog_m_d2a50a61_68c8e2c4_41, (void *)subprog_m_d2a50a61_68c8e2c4_40, (void *)subprog_m_d2a50a61_68c8e2c4_39, (void *)subprog_m_d2a50a61_68c8e2c4_38, (void *)subprog_m_d2a50a61_68c8e2c4_37, (void *)subprog_m_d2a50a61_68c8e2c4_36, (void *)subprog_m_d2a50a61_68c8e2c4_35, (void *)subprog_m_d2a50a61_68c8e2c4_34, (void *)subprog_m_d2a50a61_68c8e2c4_33, (void *)subprog_m_d2a50a61_68c8e2c4_32, (void *)subprog_m_d2a50a61_68c8e2c4_31, (void *)subprog_m_d2a50a61_68c8e2c4_30, (void *)subprog_m_d2a50a61_68c8e2c4_29, (void *)subprog_m_d2a50a61_68c8e2c4_28};
static char* ng170[] = {(void *)subprog_m_d2a50a61_68c8e2c4_47, (void *)subprog_m_d2a50a61_68c8e2c4_46, (void *)subprog_m_d2a50a61_68c8e2c4_45};
static char* ng180[] = {(void *)subprog_m_d2a50a61_68c8e2c4_51, (void *)subprog_m_d2a50a61_68c8e2c4_50, (void *)subprog_m_d2a50a61_68c8e2c4_49};
static char* ng190[] = {(void *)subprog_m_d2a50a61_68c8e2c4_56, (void *)subprog_m_d2a50a61_68c8e2c4_55, (void *)subprog_m_d2a50a61_68c8e2c4_54};
static char* ng200[] = {(void *)subprog_m_d2a50a61_68c8e2c4_59};
static char* ng210[] = {(void *)subprog_m_d2a50a61_68c8e2c4_92};
static char* ng220[] = {(void *)subprog_m_d2a50a61_68c8e2c4_95};
static char* ng230[] = {(void *)subprog_m_d2a50a61_68c8e2c4_98};
static char* ng240[] = {(void *)subprog_m_d2a50a61_68c8e2c4_101};
static char* ng250[] = {(void *)subprog_m_d2a50a61_68c8e2c4_64, (void *)subprog_m_d2a50a61_68c8e2c4_63, (void *)subprog_m_d2a50a61_68c8e2c4_62};
static char* ng260[] = {(void *)subprog_m_d2a50a61_68c8e2c4_69, (void *)subprog_m_d2a50a61_68c8e2c4_68, (void *)subprog_m_d2a50a61_68c8e2c4_67};
static char* ng270[] = {(void *)subprog_m_d2a50a61_68c8e2c4_74, (void *)subprog_m_d2a50a61_68c8e2c4_73, (void *)subprog_m_d2a50a61_68c8e2c4_72};
static char* ng280[] = {(void *)subprog_m_d2a50a61_68c8e2c4_79, (void *)subprog_m_d2a50a61_68c8e2c4_78, (void *)subprog_m_d2a50a61_68c8e2c4_77};
static char* ng290[] = {(void *)subprog_m_d2a50a61_68c8e2c4_84, (void *)subprog_m_d2a50a61_68c8e2c4_83, (void *)subprog_m_d2a50a61_68c8e2c4_82};
static char* ng300[] = {(void *)subprog_m_d2a50a61_68c8e2c4_89, (void *)subprog_m_d2a50a61_68c8e2c4_88, (void *)subprog_m_d2a50a61_68c8e2c4_87};
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_xsimdir_location_if_remapped(argc, argv)  ;
    iki_set_sv_type_file_path_name("xsim.dir/lab_05_tb_decoder_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/lab_05_tb_decoder_behav/xsim.crvsdump");
    iki_svlog_initialize_virtual_tables(15, 14, ng140, 17, ng170, 18, ng180, 19, ng190, 20, ng200, 21, ng210, 22, ng220, 23, ng230, 24, ng240, 25, ng250, 26, ng260, 27, ng270, 28, ng280, 29, ng290, 30, ng300);
    void* design_handle = iki_create_design("xsim.dir/lab_05_tb_decoder_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
