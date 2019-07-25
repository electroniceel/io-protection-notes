*****
* (c) ON SEMICONDUCTOR
* Models developed and under copyright by:
* ON SEMICONDUCTOR

* ============================================================
* | Legal Notice: This material is intended for free  
* | software support. The file may be copied and distributed.
* | However,reselling the material is illegal.
* ============================================================

* ============================================================      
* |   LM224, LM324, LM324A, LM2902, LM2902V, NCV2902
* |                 OP-AMP MACRO-MODEL
* |           Designed in pSpice Version 9.2
* |
* | The content of this model is subject to change
* | without notice and may not be modified or altered
* | without permission from ON Semiconductor. This model
* | has been carefully checked and is believed to be
* | accurate, however ON Semiconductor does not assume
* | liability for the use of this model or the results
* | obtained from using it.
* ============================================================

* ============================================================
* Features: - True Differential Input Stage
*           - Single Supply Operation: 3.0 V to 32 V
*           - Low Input Bias Currents: 100 nA Maximum (LM324A)
*           - Internally Compensated
*           - Common Mode Range Extends to Negative Supply
* ============================================================

* $Author: Vallabh Chilakapati $
* $Date: 4 Aug 2006 $

* NOTE: - Noise is not modeled.
*       - Temperature is not modeled.
*       - PSR is not modeled.
*       - Model is for single device only.  Simulated supply current is 1/2 of
*         total package current.

* Connections:
*                   Non-Inverting Input
*                   |   Inverting Input
*                   |   |  +ve Supply Voltage
*                   |   |  |   -ve Supply Voltage
*                   |   |  |   |   Output
*                   |   |  |   |   |
.SUBCKT LM324    1   2  11  12  24

***** Input Stage *****
Q_Q1    4 5 6   QPNP1    
Q_Q2    7 8 9   QPNP2
I_I1    111 10  DC 1m
R_RC1   4 12    95.49
R_RC2   7 12    95.49
R_RE1   10 6    43.79
R_RE2   10 9    43.79
V_Vio   2 8 0Vdc
E_E4    1 5 16 14   1
E_EVcc  111 0 11 0  1
G_Vcc   0 11    poly(1) 11 0    0.278m 2.4u

***** Gain Stage & Frequency Response Stage *****
R_R3    13 12   1000  
R_R4    111 13  100k  
E_Eref  14 0 13 0   1
G_G1    14 15 7 4   0.01047
R_Rc    14 15   9.549Meg
C_Cc    14 15   1.667n

***** Output Stage *****
E_E1    22 14 15 14 1
V_F1    23 24   0
F_F1    11 0 V_F1   1
R_Rout  22 23   13

***** Common Mode Rejection *****
R_R1    3 1 1Meg
R_R2    2 3 1Meg
G_G2    14 16 3 14  5.6234n
R_Rcmr  17 16   10k
L_Lcmr  14 17   1.59H

***** Output Voltage Limiting *****
D_D1    15 18   D10D1
D_D2    19 15   D10D1
V_Voh   111 18  2.19
V_Vol   19 12   0.63

***** Output Current Limiting *****
D_D3    15 21   D10D1
D_D4    20 15   D10D1
V_V3    21 23   -0.207
V_V4    23 20   -0.467

***** Models *****
.model QPNP1    PNP(Bf=6041.7)
.model QPNP2    PNP(Bf=5186.8)
.MODEL D10D1 D IS=1E-15 RS=1.000E-3 VJ=.75 BV=100E6
.ENDS
