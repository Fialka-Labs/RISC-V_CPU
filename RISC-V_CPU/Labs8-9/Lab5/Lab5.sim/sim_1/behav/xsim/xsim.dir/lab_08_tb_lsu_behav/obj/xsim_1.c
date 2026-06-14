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
IKI_DLLESPEC extern void execute_57(char*, char *);
IKI_DLLESPEC extern void execute_58(char*, char *);
IKI_DLLESPEC extern void execute_59(char*, char *);
IKI_DLLESPEC extern void execute_72(char*, char *);
IKI_DLLESPEC extern void execute_74(char*, char *);
IKI_DLLESPEC extern void execute_76(char*, char *);
IKI_DLLESPEC extern void execute_77(char*, char *);
IKI_DLLESPEC extern void execute_78(char*, char *);
IKI_DLLESPEC extern void execute_121(char*, char *);
IKI_DLLESPEC extern void execute_122(char*, char *);
IKI_DLLESPEC extern void svlog_sampling_process_execute(char*, char*, char*);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_3(char*, char *);
IKI_DLLESPEC extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_6(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_9(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_7(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_12(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_10(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_13(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_14(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_16(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_15(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_18(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_7(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_17(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_20(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_21(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_19(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_23(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_24(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_9(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_22(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_26(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_10(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_25(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_28(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_29(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_27(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_31(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_32(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_795c128b_82e2908_12(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_795c128b_82e2908_30(char*, char *);
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
IKI_DLLESPEC extern void execute_26(char*, char *);
IKI_DLLESPEC extern void execute_27(char*, char *);
IKI_DLLESPEC extern void execute_28(char*, char *);
IKI_DLLESPEC extern void execute_29(char*, char *);
IKI_DLLESPEC extern void execute_30(char*, char *);
IKI_DLLESPEC extern void execute_31(char*, char *);
IKI_DLLESPEC extern void execute_32(char*, char *);
IKI_DLLESPEC extern void execute_33(char*, char *);
IKI_DLLESPEC extern void execute_34(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
IKI_DLLESPEC extern void execute_85(char*, char *);
IKI_DLLESPEC extern void execute_86(char*, char *);
IKI_DLLESPEC extern void execute_87(char*, char *);
IKI_DLLESPEC extern void execute_88(char*, char *);
IKI_DLLESPEC extern void execute_91(char*, char *);
IKI_DLLESPEC extern void execute_92(char*, char *);
IKI_DLLESPEC extern void execute_93(char*, char *);
IKI_DLLESPEC extern void execute_94(char*, char *);
IKI_DLLESPEC extern void execute_95(char*, char *);
IKI_DLLESPEC extern void execute_96(char*, char *);
IKI_DLLESPEC extern void execute_97(char*, char *);
IKI_DLLESPEC extern void execute_98(char*, char *);
IKI_DLLESPEC extern void execute_99(char*, char *);
IKI_DLLESPEC extern void execute_100(char*, char *);
IKI_DLLESPEC extern void execute_101(char*, char *);
IKI_DLLESPEC extern void execute_102(char*, char *);
IKI_DLLESPEC extern void execute_103(char*, char *);
IKI_DLLESPEC extern void execute_104(char*, char *);
IKI_DLLESPEC extern void execute_105(char*, char *);
IKI_DLLESPEC extern void execute_106(char*, char *);
IKI_DLLESPEC extern void execute_107(char*, char *);
IKI_DLLESPEC extern void execute_108(char*, char *);
IKI_DLLESPEC extern void execute_109(char*, char *);
IKI_DLLESPEC extern void execute_110(char*, char *);
IKI_DLLESPEC extern void execute_111(char*, char *);
IKI_DLLESPEC extern void execute_36(char*, char *);
IKI_DLLESPEC extern void execute_37(char*, char *);
IKI_DLLESPEC extern void execute_50(char*, char *);
IKI_DLLESPEC extern void execute_51(char*, char *);
IKI_DLLESPEC extern void execute_114(char*, char *);
IKI_DLLESPEC extern void execute_115(char*, char *);
IKI_DLLESPEC extern void execute_116(char*, char *);
IKI_DLLESPEC extern void execute_117(char*, char *);
IKI_DLLESPEC extern void execute_118(char*, char *);
IKI_DLLESPEC extern void execute_119(char*, char *);
IKI_DLLESPEC extern void execute_80(char*, char *);
IKI_DLLESPEC extern void execute_81(char*, char *);
IKI_DLLESPEC extern void execute_82(char*, char *);
IKI_DLLESPEC extern void execute_83(char*, char *);
IKI_DLLESPEC extern void execute_234(char*, char *);
IKI_DLLESPEC extern void execute_235(char*, char *);
IKI_DLLESPEC extern void execute_236(char*, char *);
IKI_DLLESPEC extern void execute_237(char*, char *);
IKI_DLLESPEC extern void execute_238(char*, char *);
IKI_DLLESPEC extern void execute_239(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[132] = {(funcp)execute_23, (funcp)execute_57, (funcp)execute_58, (funcp)execute_59, (funcp)execute_72, (funcp)execute_74, (funcp)execute_76, (funcp)execute_77, (funcp)execute_78, (funcp)execute_121, (funcp)execute_122, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_795c128b_82e2908_2, (funcp)sequence_expr_m_795c128b_82e2908_3, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_795c128b_82e2908_1, (funcp)sequence_expr_m_795c128b_82e2908_1, (funcp)sequence_expr_m_795c128b_82e2908_5, (funcp)sequence_expr_m_795c128b_82e2908_6, (funcp)assertion_action_m_795c128b_82e2908_2, (funcp)sequence_expr_m_795c128b_82e2908_4, (funcp)sequence_expr_m_795c128b_82e2908_8, (funcp)sequence_expr_m_795c128b_82e2908_9, (funcp)assertion_action_m_795c128b_82e2908_3, (funcp)sequence_expr_m_795c128b_82e2908_7, (funcp)sequence_expr_m_795c128b_82e2908_11, (funcp)sequence_expr_m_795c128b_82e2908_12, (funcp)assertion_action_m_795c128b_82e2908_4, (funcp)sequence_expr_m_795c128b_82e2908_10, (funcp)sequence_expr_m_795c128b_82e2908_13, (funcp)sequence_expr_m_795c128b_82e2908_14, (funcp)assertion_action_m_795c128b_82e2908_5, (funcp)sequence_expr_m_795c128b_82e2908_16, (funcp)assertion_action_m_795c128b_82e2908_6, (funcp)sequence_expr_m_795c128b_82e2908_15, (funcp)sequence_expr_m_795c128b_82e2908_18, (funcp)assertion_action_m_795c128b_82e2908_7, (funcp)sequence_expr_m_795c128b_82e2908_17, (funcp)sequence_expr_m_795c128b_82e2908_20, (funcp)sequence_expr_m_795c128b_82e2908_21, (funcp)assertion_action_m_795c128b_82e2908_8, (funcp)sequence_expr_m_795c128b_82e2908_19, (funcp)sequence_expr_m_795c128b_82e2908_23, (funcp)sequence_expr_m_795c128b_82e2908_24, (funcp)assertion_action_m_795c128b_82e2908_9, (funcp)sequence_expr_m_795c128b_82e2908_22, (funcp)sequence_expr_m_795c128b_82e2908_26, (funcp)assertion_action_m_795c128b_82e2908_10, (funcp)sequence_expr_m_795c128b_82e2908_25, (funcp)sequence_expr_m_795c128b_82e2908_28, (funcp)sequence_expr_m_795c128b_82e2908_29, (funcp)assertion_action_m_795c128b_82e2908_11, (funcp)sequence_expr_m_795c128b_82e2908_27, (funcp)sequence_expr_m_795c128b_82e2908_31, (funcp)sequence_expr_m_795c128b_82e2908_32, (funcp)assertion_action_m_795c128b_82e2908_12, (funcp)sequence_expr_m_795c128b_82e2908_30, (funcp)execute_216, (funcp)execute_217, (funcp)execute_218, (funcp)execute_219, (funcp)execute_220, (funcp)execute_221, (funcp)execute_222, (funcp)execute_223, (funcp)execute_224, (funcp)execute_225, (funcp)execute_226, (funcp)execute_227, (funcp)execute_228, (funcp)execute_229, (funcp)execute_230, (funcp)execute_231, (funcp)execute_232, (funcp)execute_233, (funcp)execute_26, (funcp)execute_27, (funcp)execute_28, (funcp)execute_29, (funcp)execute_30, (funcp)execute_31, (funcp)execute_32, (funcp)execute_33, (funcp)execute_34, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_85, (funcp)execute_86, (funcp)execute_87, (funcp)execute_88, (funcp)execute_91, (funcp)execute_92, (funcp)execute_93, (funcp)execute_94, (funcp)execute_95, (funcp)execute_96, (funcp)execute_97, (funcp)execute_98, (funcp)execute_99, (funcp)execute_100, (funcp)execute_101, (funcp)execute_102, (funcp)execute_103, (funcp)execute_104, (funcp)execute_105, (funcp)execute_106, (funcp)execute_107, (funcp)execute_108, (funcp)execute_109, (funcp)execute_110, (funcp)execute_111, (funcp)execute_36, (funcp)execute_37, (funcp)execute_50, (funcp)execute_51, (funcp)execute_114, (funcp)execute_115, (funcp)execute_116, (funcp)execute_117, (funcp)execute_118, (funcp)execute_119, (funcp)execute_80, (funcp)execute_81, (funcp)execute_82, (funcp)execute_83, (funcp)execute_234, (funcp)execute_235, (funcp)execute_236, (funcp)execute_237, (funcp)execute_238, (funcp)execute_239, (funcp)vlog_transfunc_eventcallback, (funcp)vlog_transfunc_eventcallback_2state};
const int NumRelocateId= 132;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/lab_08_tb_lsu_behav/xsim.reloc",  (void **)funcTab, 132);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/lab_08_tb_lsu_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(5, 8336, 1,2, 0, 32,8520, 1,2, 0, 32,8704, 2,0,0,24704, 14,0,0,24520, 13,0,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/lab_08_tb_lsu_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void subprog_m_795c128b_82e2908_23() ;
void subprog_m_795c128b_82e2908_22() ;
void subprog_m_795c128b_82e2908_21() ;
void subprog_m_795c128b_82e2908_28() ;
void subprog_m_795c128b_82e2908_27() ;
void subprog_m_795c128b_82e2908_26() ;
static char* ng130[] = {(void *)subprog_m_795c128b_82e2908_23, (void *)subprog_m_795c128b_82e2908_22, (void *)subprog_m_795c128b_82e2908_21};
static char* ng140[] = {(void *)subprog_m_795c128b_82e2908_28, (void *)subprog_m_795c128b_82e2908_27, (void *)subprog_m_795c128b_82e2908_26};
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
    iki_set_sv_type_file_path_name("xsim.dir/lab_08_tb_lsu_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/lab_08_tb_lsu_behav/xsim.crvsdump");
    iki_svlog_initialize_virtual_tables(2, 13, ng130, 14, ng140);
    void* design_handle = iki_create_design("xsim.dir/lab_08_tb_lsu_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
