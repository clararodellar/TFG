/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/URJC/4.CUARTO/TFG/TRABAJO/FPGA/PWM_prueba_lazocerrado_v3/binary_to_bcd.vhd";
extern char *IEEE_P_3620187407;
extern char *IEEE_P_1242562249;

char *ieee_p_1242562249_sub_1547198987_1035706684(char *, char *, char *, char *, char *, char *);


static void work_a_1543659282_3212880686_p_0(char *t0)
{
    char t20[16];
    char t21[16];
    char t25[16];
    char t27[16];
    char t33[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    int t16;
    unsigned char t17;
    int t18;
    unsigned char t19;
    char *t22;
    int t23;
    unsigned char t24;
    char *t26;
    char *t28;
    char *t29;
    int t30;
    unsigned int t31;
    char *t34;
    char *t35;
    int t36;
    char *t37;
    char *t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    unsigned int t42;
    unsigned int t43;

LAB0:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t1 = (t0 + 1608U);
    t3 = *((char **)t1);
    t1 = (t3 + 0);
    memcpy(t1, t2, 8U);
    xsi_set_current_line(48, ng0);
    t1 = xsi_get_transient_memory(12U);
    memset(t1, 0, 12U);
    t2 = t1;
    memset(t2, (unsigned char)2, 12U);
    t3 = (t0 + 1488U);
    t4 = *((char **)t3);
    t3 = (t4 + 0);
    memcpy(t3, t1, 12U);
    xsi_set_current_line(50, ng0);
    t1 = (t0 + 5044);
    *((int *)t1) = 0;
    t2 = (t0 + 5048);
    *((int *)t2) = 7;
    t5 = 0;
    t6 = 7;

LAB2:    if (t5 <= t6)
        goto LAB3;

LAB5:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 1488U);
    t2 = *((char **)t1);
    t1 = (t0 + 2992);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t10 = (t4 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t2, 12U);
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 2912);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 1488U);
    t4 = *((char **)t3);
    t7 = (11 - 10);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t3 = (t4 + t9);
    t10 = xsi_get_transient_memory(11U);
    memcpy(t10, t3, 11U);
    t11 = (t0 + 1488U);
    t12 = *((char **)t11);
    t13 = (11 - 11);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t11 = (t12 + t15);
    memcpy(t11, t10, 11U);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1608U);
    t2 = *((char **)t1);
    t16 = (7 - 7);
    t7 = (t16 * -1);
    t8 = (1U * t7);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    t17 = *((unsigned char *)t1);
    t3 = (t0 + 1488U);
    t4 = *((char **)t3);
    t18 = (0 - 11);
    t13 = (t18 * -1);
    t14 = (1U * t13);
    t15 = (0 + t14);
    t3 = (t4 + t15);
    *((unsigned char *)t3) = t17;
    xsi_set_current_line(53, ng0);
    t1 = (t0 + 1608U);
    t2 = *((char **)t1);
    t7 = (7 - 6);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    t3 = xsi_get_transient_memory(7U);
    memcpy(t3, t1, 7U);
    t4 = (t0 + 1608U);
    t10 = *((char **)t4);
    t13 = (7 - 7);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t4 = (t10 + t15);
    memcpy(t4, t3, 7U);
    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1608U);
    t2 = *((char **)t1);
    t16 = (0 - 7);
    t7 = (t16 * -1);
    t8 = (1U * t7);
    t9 = (0 + t8);
    t1 = (t2 + t9);
    *((unsigned char *)t1) = (unsigned char)2;
    xsi_set_current_line(56, ng0);
    t1 = (t0 + 5044);
    t16 = *((int *)t1);
    t19 = (t16 < 7);
    if (t19 == 1)
        goto LAB9;

LAB10:    t17 = (unsigned char)0;

LAB11:    if (t17 != 0)
        goto LAB6;

LAB8:
LAB7:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 5044);
    t16 = *((int *)t1);
    t19 = (t16 < 7);
    if (t19 == 1)
        goto LAB15;

LAB16:    t17 = (unsigned char)0;

LAB17:    if (t17 != 0)
        goto LAB12;

LAB14:
LAB13:    xsi_set_current_line(62, ng0);
    t1 = (t0 + 5044);
    t16 = *((int *)t1);
    t19 = (t16 < 7);
    if (t19 == 1)
        goto LAB21;

LAB22:    t17 = (unsigned char)0;

LAB23:    if (t17 != 0)
        goto LAB18;

LAB20:
LAB19:
LAB4:    t1 = (t0 + 5044);
    t5 = *((int *)t1);
    t2 = (t0 + 5048);
    t6 = *((int *)t2);
    if (t5 == t6)
        goto LAB5;

LAB24:    t16 = (t5 + 1);
    t5 = t16;
    t3 = (t0 + 5044);
    *((int *)t3) = t5;
    goto LAB2;

LAB6:    xsi_set_current_line(57, ng0);
    t22 = (t0 + 1488U);
    t26 = *((char **)t22);
    t13 = (11 - 3);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t22 = (t26 + t15);
    t28 = (t27 + 0U);
    t29 = (t28 + 0U);
    *((int *)t29) = 3;
    t29 = (t28 + 4U);
    *((int *)t29) = 0;
    t29 = (t28 + 8U);
    *((int *)t29) = -1;
    t30 = (0 - 3);
    t31 = (t30 * -1);
    t31 = (t31 + 1);
    t29 = (t28 + 12U);
    *((unsigned int *)t29) = t31;
    t29 = (t0 + 5056);
    t34 = (t33 + 0U);
    t35 = (t34 + 0U);
    *((int *)t35) = 0;
    t35 = (t34 + 4U);
    *((int *)t35) = 3;
    t35 = (t34 + 8U);
    *((int *)t35) = 1;
    t36 = (3 - 0);
    t31 = (t36 * 1);
    t31 = (t31 + 1);
    t35 = (t34 + 12U);
    *((unsigned int *)t35) = t31;
    t35 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t25, t22, t27, t29, t33);
    t37 = (t0 + 1488U);
    t38 = *((char **)t37);
    t31 = (11 - 3);
    t39 = (t31 * 1U);
    t40 = (0 + t39);
    t37 = (t38 + t40);
    t41 = (t25 + 12U);
    t42 = *((unsigned int *)t41);
    t43 = (1U * t42);
    memcpy(t37, t35, t43);
    goto LAB7;

LAB9:    t2 = (t0 + 1488U);
    t3 = *((char **)t2);
    t7 = (11 - 3);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t2 = (t3 + t9);
    t4 = (t20 + 0U);
    t10 = (t4 + 0U);
    *((int *)t10) = 3;
    t10 = (t4 + 4U);
    *((int *)t10) = 0;
    t10 = (t4 + 8U);
    *((int *)t10) = -1;
    t18 = (0 - 3);
    t13 = (t18 * -1);
    t13 = (t13 + 1);
    t10 = (t4 + 12U);
    *((unsigned int *)t10) = t13;
    t10 = (t0 + 5052);
    t12 = (t21 + 0U);
    t22 = (t12 + 0U);
    *((int *)t22) = 0;
    t22 = (t12 + 4U);
    *((int *)t22) = 3;
    t22 = (t12 + 8U);
    *((int *)t22) = 1;
    t23 = (3 - 0);
    t13 = (t23 * 1);
    t13 = (t13 + 1);
    t22 = (t12 + 12U);
    *((unsigned int *)t22) = t13;
    t24 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t2, t20, t10, t21);
    t17 = t24;
    goto LAB11;

LAB12:    xsi_set_current_line(60, ng0);
    t22 = (t0 + 1488U);
    t26 = *((char **)t22);
    t13 = (11 - 7);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t22 = (t26 + t15);
    t28 = (t27 + 0U);
    t29 = (t28 + 0U);
    *((int *)t29) = 7;
    t29 = (t28 + 4U);
    *((int *)t29) = 4;
    t29 = (t28 + 8U);
    *((int *)t29) = -1;
    t30 = (4 - 7);
    t31 = (t30 * -1);
    t31 = (t31 + 1);
    t29 = (t28 + 12U);
    *((unsigned int *)t29) = t31;
    t29 = (t0 + 5064);
    t34 = (t33 + 0U);
    t35 = (t34 + 0U);
    *((int *)t35) = 0;
    t35 = (t34 + 4U);
    *((int *)t35) = 3;
    t35 = (t34 + 8U);
    *((int *)t35) = 1;
    t36 = (3 - 0);
    t31 = (t36 * 1);
    t31 = (t31 + 1);
    t35 = (t34 + 12U);
    *((unsigned int *)t35) = t31;
    t35 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t25, t22, t27, t29, t33);
    t37 = (t0 + 1488U);
    t38 = *((char **)t37);
    t31 = (11 - 7);
    t39 = (t31 * 1U);
    t40 = (0 + t39);
    t37 = (t38 + t40);
    t41 = (t25 + 12U);
    t42 = *((unsigned int *)t41);
    t43 = (1U * t42);
    memcpy(t37, t35, t43);
    goto LAB13;

LAB15:    t2 = (t0 + 1488U);
    t3 = *((char **)t2);
    t7 = (11 - 7);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t2 = (t3 + t9);
    t4 = (t20 + 0U);
    t10 = (t4 + 0U);
    *((int *)t10) = 7;
    t10 = (t4 + 4U);
    *((int *)t10) = 4;
    t10 = (t4 + 8U);
    *((int *)t10) = -1;
    t18 = (4 - 7);
    t13 = (t18 * -1);
    t13 = (t13 + 1);
    t10 = (t4 + 12U);
    *((unsigned int *)t10) = t13;
    t10 = (t0 + 5060);
    t12 = (t21 + 0U);
    t22 = (t12 + 0U);
    *((int *)t22) = 0;
    t22 = (t12 + 4U);
    *((int *)t22) = 3;
    t22 = (t12 + 8U);
    *((int *)t22) = 1;
    t23 = (3 - 0);
    t13 = (t23 * 1);
    t13 = (t13 + 1);
    t22 = (t12 + 12U);
    *((unsigned int *)t22) = t13;
    t24 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t2, t20, t10, t21);
    t17 = t24;
    goto LAB17;

LAB18:    xsi_set_current_line(63, ng0);
    t22 = (t0 + 1488U);
    t26 = *((char **)t22);
    t13 = (11 - 11);
    t14 = (t13 * 1U);
    t15 = (0 + t14);
    t22 = (t26 + t15);
    t28 = (t27 + 0U);
    t29 = (t28 + 0U);
    *((int *)t29) = 11;
    t29 = (t28 + 4U);
    *((int *)t29) = 8;
    t29 = (t28 + 8U);
    *((int *)t29) = -1;
    t30 = (8 - 11);
    t31 = (t30 * -1);
    t31 = (t31 + 1);
    t29 = (t28 + 12U);
    *((unsigned int *)t29) = t31;
    t29 = (t0 + 5072);
    t34 = (t33 + 0U);
    t35 = (t34 + 0U);
    *((int *)t35) = 0;
    t35 = (t34 + 4U);
    *((int *)t35) = 3;
    t35 = (t34 + 8U);
    *((int *)t35) = 1;
    t36 = (3 - 0);
    t31 = (t36 * 1);
    t31 = (t31 + 1);
    t35 = (t34 + 12U);
    *((unsigned int *)t35) = t31;
    t35 = ieee_p_1242562249_sub_1547198987_1035706684(IEEE_P_1242562249, t25, t22, t27, t29, t33);
    t37 = (t0 + 1488U);
    t38 = *((char **)t37);
    t31 = (11 - 11);
    t39 = (t31 * 1U);
    t40 = (0 + t39);
    t37 = (t38 + t40);
    t41 = (t25 + 12U);
    t42 = *((unsigned int *)t41);
    t43 = (1U * t42);
    memcpy(t37, t35, t43);
    goto LAB19;

LAB21:    t2 = (t0 + 1488U);
    t3 = *((char **)t2);
    t7 = (11 - 11);
    t8 = (t7 * 1U);
    t9 = (0 + t8);
    t2 = (t3 + t9);
    t4 = (t20 + 0U);
    t10 = (t4 + 0U);
    *((int *)t10) = 11;
    t10 = (t4 + 4U);
    *((int *)t10) = 8;
    t10 = (t4 + 8U);
    *((int *)t10) = -1;
    t18 = (8 - 11);
    t13 = (t18 * -1);
    t13 = (t13 + 1);
    t10 = (t4 + 12U);
    *((unsigned int *)t10) = t13;
    t10 = (t0 + 5068);
    t12 = (t21 + 0U);
    t22 = (t12 + 0U);
    *((int *)t22) = 0;
    t22 = (t12 + 4U);
    *((int *)t22) = 3;
    t22 = (t12 + 8U);
    *((int *)t22) = 1;
    t23 = (3 - 0);
    t13 = (t23 * 1);
    t13 = (t13 + 1);
    t22 = (t12 + 12U);
    *((unsigned int *)t22) = t13;
    t24 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t2, t20, t10, t21);
    t17 = t24;
    goto LAB23;

}


extern void work_a_1543659282_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1543659282_3212880686_p_0};
	xsi_register_didat("work_a_1543659282_3212880686", "isim/tb_juntar_isim_beh.exe.sim/work/a_1543659282_3212880686.didat");
	xsi_register_executes(pe);
}
