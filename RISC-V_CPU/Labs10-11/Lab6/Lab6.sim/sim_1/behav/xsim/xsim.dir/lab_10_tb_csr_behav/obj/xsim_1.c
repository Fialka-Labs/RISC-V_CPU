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
IKI_DLLESPEC extern void execute_8(char*, char *);
IKI_DLLESPEC extern void execute_9(char*, char *);
IKI_DLLESPEC extern void execute_10(char*, char *);
IKI_DLLESPEC extern void execute_11(char*, char *);
IKI_DLLESPEC extern void execute_15(char*, char *);
IKI_DLLESPEC extern void execute_36(char*, char *);
IKI_DLLESPEC extern void execute_37(char*, char *);
IKI_DLLESPEC extern void execute_38(char*, char *);
IKI_DLLESPEC extern void execute_39(char*, char *);
IKI_DLLESPEC extern void execute_40(char*, char *);
IKI_DLLESPEC extern void execute_41(char*, char *);
IKI_DLLESPEC extern void execute_42(char*, char *);
IKI_DLLESPEC extern void execute_43(char*, char *);
IKI_DLLESPEC extern void execute_44(char*, char *);
IKI_DLLESPEC extern void execute_53(char*, char *);
IKI_DLLESPEC extern void execute_54(char*, char *);
IKI_DLLESPEC extern void svlog_sampling_process_execute(char*, char*, char*);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_3(char*, char *);
IKI_DLLESPEC extern void vlog_sv_sequence_execute_0 (char*, char*, char*);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_1(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_6(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_2(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_9(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_3(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_7(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_11(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_12(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_4(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_10(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_14(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_15(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_5(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_13(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_17(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_18(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_6(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_16(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_20(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_21(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_7(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_19(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_23(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_24(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_8(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_22(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_26(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_27(char*, char *);
IKI_DLLESPEC extern void assertion_action_m_6a3bc8e2_5988f460_9(char*, char *);
IKI_DLLESPEC extern void sequence_expr_m_6a3bc8e2_5988f460_25(char*, char *);
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
IKI_DLLESPEC extern void execute_4(char*, char *);
IKI_DLLESPEC extern void execute_5(char*, char *);
IKI_DLLESPEC extern void execute_6(char*, char *);
IKI_DLLESPEC extern void execute_7(char*, char *);
IKI_DLLESPEC extern void vlog_simple_process_execute_0_fast_for_reg(char*, char*, char*);
IKI_DLLESPEC extern void execute_46(char*, char *);
IKI_DLLESPEC extern void execute_47(char*, char *);
IKI_DLLESPEC extern void execute_48(char*, char *);
IKI_DLLESPEC extern void execute_49(char*, char *);
IKI_DLLESPEC extern void execute_209(char*, char *);
IKI_DLLESPEC extern void execute_210(char*, char *);
IKI_DLLESPEC extern void execute_211(char*, char *);
IKI_DLLESPEC extern void execute_212(char*, char *);
IKI_DLLESPEC extern void execute_213(char*, char *);
IKI_DLLESPEC extern void execute_214(char*, char *);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
IKI_DLLESPEC extern void transaction_0(char*, char*, unsigned, unsigned, unsigned);
IKI_DLLESPEC extern void vlog_transfunc_eventcallback_2state(char*, char*, unsigned, unsigned, unsigned, char *);
funcp funcTab[82] = {(funcp)execute_8, (funcp)execute_9, (funcp)execute_10, (funcp)execute_11, (funcp)execute_15, (funcp)execute_36, (funcp)execute_37, (funcp)execute_38, (funcp)execute_39, (funcp)execute_40, (funcp)execute_41, (funcp)execute_42, (funcp)execute_43, (funcp)execute_44, (funcp)execute_53, (funcp)execute_54, (funcp)svlog_sampling_process_execute, (funcp)sequence_expr_m_6a3bc8e2_5988f460_2, (funcp)sequence_expr_m_6a3bc8e2_5988f460_3, (funcp)vlog_sv_sequence_execute_0 , (funcp)assertion_action_m_6a3bc8e2_5988f460_1, (funcp)sequence_expr_m_6a3bc8e2_5988f460_1, (funcp)sequence_expr_m_6a3bc8e2_5988f460_5, (funcp)sequence_expr_m_6a3bc8e2_5988f460_6, (funcp)assertion_action_m_6a3bc8e2_5988f460_2, (funcp)sequence_expr_m_6a3bc8e2_5988f460_4, (funcp)sequence_expr_m_6a3bc8e2_5988f460_8, (funcp)sequence_expr_m_6a3bc8e2_5988f460_9, (funcp)assertion_action_m_6a3bc8e2_5988f460_3, (funcp)sequence_expr_m_6a3bc8e2_5988f460_7, (funcp)sequence_expr_m_6a3bc8e2_5988f460_11, (funcp)sequence_expr_m_6a3bc8e2_5988f460_12, (funcp)assertion_action_m_6a3bc8e2_5988f460_4, (funcp)sequence_expr_m_6a3bc8e2_5988f460_10, (funcp)sequence_expr_m_6a3bc8e2_5988f460_14, (funcp)sequence_expr_m_6a3bc8e2_5988f460_15, (funcp)assertion_action_m_6a3bc8e2_5988f460_5, (funcp)sequence_expr_m_6a3bc8e2_5988f460_13, (funcp)sequence_expr_m_6a3bc8e2_5988f460_17, (funcp)sequence_expr_m_6a3bc8e2_5988f460_18, (funcp)assertion_action_m_6a3bc8e2_5988f460_6, (funcp)sequence_expr_m_6a3bc8e2_5988f460_16, (funcp)sequence_expr_m_6a3bc8e2_5988f460_20, (funcp)sequence_expr_m_6a3bc8e2_5988f460_21, (funcp)assertion_action_m_6a3bc8e2_5988f460_7, (funcp)sequence_expr_m_6a3bc8e2_5988f460_19, (funcp)sequence_expr_m_6a3bc8e2_5988f460_23, (funcp)sequence_expr_m_6a3bc8e2_5988f460_24, (funcp)assertion_action_m_6a3bc8e2_5988f460_8, (funcp)sequence_expr_m_6a3bc8e2_5988f460_22, (funcp)sequence_expr_m_6a3bc8e2_5988f460_26, (funcp)sequence_expr_m_6a3bc8e2_5988f460_27, (funcp)assertion_action_m_6a3bc8e2_5988f460_9, (funcp)sequence_expr_m_6a3bc8e2_5988f460_25, (funcp)execute_199, (funcp)execute_200, (funcp)execute_201, (funcp)execute_202, (funcp)execute_203, (funcp)execute_204, (funcp)execute_205, (funcp)execute_206, (funcp)execute_207, (funcp)execute_208, (funcp)execute_4, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)vlog_simple_process_execute_0_fast_for_reg, (funcp)execute_46, (funcp)execute_47, (funcp)execute_48, (funcp)execute_49, (funcp)execute_209, (funcp)execute_210, (funcp)execute_211, (funcp)execute_212, (funcp)execute_213, (funcp)execute_214, (funcp)vlog_transfunc_eventcallback, (funcp)transaction_0, (funcp)vlog_transfunc_eventcallback_2state};
const int NumRelocateId= 82;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/lab_10_tb_csr_behav/xsim.reloc",  (void **)funcTab, 82);

	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/lab_10_tb_csr_behav/xsim.reloc");
}

void simulate(char *dp)
{
iki_register_root_pointers(2, 10448, -5,0,10632, -5,0) ; 
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/lab_10_tb_csr_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
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
    iki_set_sv_type_file_path_name("xsim.dir/lab_10_tb_csr_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/lab_10_tb_csr_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/lab_10_tb_csr_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, (void*)0, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
