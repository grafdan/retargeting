//
//  CVXGenRangeSolver25x25+MatrixSupport.m
//  CVXSolver
//
/* Produced by CVXGEN, 2012-11-27 15:57:37 -0800.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

//  Translated to Objective-C and minor modifications
//  by Daniel Graf in November 2012.

#import "CVXGenRangeSolver25x25+MatrixSupport.h"

@implementation CVXGenRangeSolver25x25 (MatrixSupport)
/* Produced by CVXGEN, 2012-10-07 05:58:55 -0700.  */
/* CVXGEN is Copyright (C) 2006-2011 Jacob Mattingley, jem@cvxgen.com. */
/* The code in this file is Copyright (C) 2006-2011 Jacob Mattingley. */
/* CVXGEN, or solvers produced by CVXGEN, cannot be used for commercial */
/* applications without prior written permission from Jacob Mattingley. */

/* Filename: matrix_support.c. */
/* Description: Support functions for matrix multiplication and vector filling. */
-(void) multbymAWithLhs:(double *)lhs andRhs:(double *)rhs {
  lhs[0] = -rhs[0]*(1)-rhs[1]*(1)-rhs[2]*(1)-rhs[3]*(1)-rhs[4]*(1)-rhs[5]*(1)-rhs[6]*(1)-rhs[7]*(1)-rhs[8]*(1)-rhs[9]*(1)-rhs[10]*(1)-rhs[11]*(1)-rhs[12]*(1)-rhs[13]*(1)-rhs[14]*(1)-rhs[15]*(1)-rhs[16]*(1)-rhs[17]*(1)-rhs[18]*(1)-rhs[19]*(1)-rhs[20]*(1)-rhs[21]*(1)-rhs[22]*(1)-rhs[23]*(1)-rhs[24]*(1);
  lhs[1] = -rhs[25]*(1)-rhs[26]*(1)-rhs[27]*(1)-rhs[28]*(1)-rhs[29]*(1)-rhs[30]*(1)-rhs[31]*(1)-rhs[32]*(1)-rhs[33]*(1)-rhs[34]*(1)-rhs[35]*(1)-rhs[36]*(1)-rhs[37]*(1)-rhs[38]*(1)-rhs[39]*(1)-rhs[40]*(1)-rhs[41]*(1)-rhs[42]*(1)-rhs[43]*(1)-rhs[44]*(1)-rhs[45]*(1)-rhs[46]*(1)-rhs[47]*(1)-rhs[48]*(1)-rhs[49]*(1);
}

-(void) multbymATWithLhs:(double *)lhs andRhs:(double *)rhs {
  lhs[0] = -rhs[0]*(1);
  lhs[1] = -rhs[0]*(1);
  lhs[2] = -rhs[0]*(1);
  lhs[3] = -rhs[0]*(1);
  lhs[4] = -rhs[0]*(1);
  lhs[5] = -rhs[0]*(1);
  lhs[6] = -rhs[0]*(1);
  lhs[7] = -rhs[0]*(1);
  lhs[8] = -rhs[0]*(1);
  lhs[9] = -rhs[0]*(1);
  lhs[10] = -rhs[0]*(1);
  lhs[11] = -rhs[0]*(1);
  lhs[12] = -rhs[0]*(1);
  lhs[13] = -rhs[0]*(1);
  lhs[14] = -rhs[0]*(1);
  lhs[15] = -rhs[0]*(1);
  lhs[16] = -rhs[0]*(1);
  lhs[17] = -rhs[0]*(1);
  lhs[18] = -rhs[0]*(1);
  lhs[19] = -rhs[0]*(1);
  lhs[20] = -rhs[0]*(1);
  lhs[21] = -rhs[0]*(1);
  lhs[22] = -rhs[0]*(1);
  lhs[23] = -rhs[0]*(1);
  lhs[24] = -rhs[0]*(1);
  lhs[25] = -rhs[1]*(1);
  lhs[26] = -rhs[1]*(1);
  lhs[27] = -rhs[1]*(1);
  lhs[28] = -rhs[1]*(1);
  lhs[29] = -rhs[1]*(1);
  lhs[30] = -rhs[1]*(1);
  lhs[31] = -rhs[1]*(1);
  lhs[32] = -rhs[1]*(1);
  lhs[33] = -rhs[1]*(1);
  lhs[34] = -rhs[1]*(1);
  lhs[35] = -rhs[1]*(1);
  lhs[36] = -rhs[1]*(1);
  lhs[37] = -rhs[1]*(1);
  lhs[38] = -rhs[1]*(1);
  lhs[39] = -rhs[1]*(1);
  lhs[40] = -rhs[1]*(1);
  lhs[41] = -rhs[1]*(1);
  lhs[42] = -rhs[1]*(1);
  lhs[43] = -rhs[1]*(1);
  lhs[44] = -rhs[1]*(1);
  lhs[45] = -rhs[1]*(1);
  lhs[46] = -rhs[1]*(1);
  lhs[47] = -rhs[1]*(1);
  lhs[48] = -rhs[1]*(1);
  lhs[49] = -rhs[1]*(1);
}


-(void) multbymGWithLhs:(double *)lhs andRhs:(double *)rhs {
  lhs[0] = -rhs[0]*(-1);
  lhs[1] = -rhs[1]*(-1);
  lhs[2] = -rhs[2]*(-1);
  lhs[3] = -rhs[3]*(-1);
  lhs[4] = -rhs[4]*(-1);
  lhs[5] = -rhs[5]*(-1);
  lhs[6] = -rhs[6]*(-1);
  lhs[7] = -rhs[7]*(-1);
  lhs[8] = -rhs[8]*(-1);
  lhs[9] = -rhs[9]*(-1);
  lhs[10] = -rhs[10]*(-1);
  lhs[11] = -rhs[11]*(-1);
  lhs[12] = -rhs[12]*(-1);
  lhs[13] = -rhs[13]*(-1);
  lhs[14] = -rhs[14]*(-1);
  lhs[15] = -rhs[15]*(-1);
  lhs[16] = -rhs[16]*(-1);
  lhs[17] = -rhs[17]*(-1);
  lhs[18] = -rhs[18]*(-1);
  lhs[19] = -rhs[19]*(-1);
  lhs[20] = -rhs[20]*(-1);
  lhs[21] = -rhs[21]*(-1);
  lhs[22] = -rhs[22]*(-1);
  lhs[23] = -rhs[23]*(-1);
  lhs[24] = -rhs[24]*(-1);
  lhs[25] = -rhs[0]*(1);
  lhs[26] = -rhs[1]*(1);
  lhs[27] = -rhs[2]*(1);
  lhs[28] = -rhs[3]*(1);
  lhs[29] = -rhs[4]*(1);
  lhs[30] = -rhs[5]*(1);
  lhs[31] = -rhs[6]*(1);
  lhs[32] = -rhs[7]*(1);
  lhs[33] = -rhs[8]*(1);
  lhs[34] = -rhs[9]*(1);
  lhs[35] = -rhs[10]*(1);
  lhs[36] = -rhs[11]*(1);
  lhs[37] = -rhs[12]*(1);
  lhs[38] = -rhs[13]*(1);
  lhs[39] = -rhs[14]*(1);
  lhs[40] = -rhs[15]*(1);
  lhs[41] = -rhs[16]*(1);
  lhs[42] = -rhs[17]*(1);
  lhs[43] = -rhs[18]*(1);
  lhs[44] = -rhs[19]*(1);
  lhs[45] = -rhs[20]*(1);
  lhs[46] = -rhs[21]*(1);
  lhs[47] = -rhs[22]*(1);
  lhs[48] = -rhs[23]*(1);
  lhs[49] = -rhs[24]*(1);
  lhs[50] = -rhs[25]*(-1);
  lhs[51] = -rhs[26]*(-1);
  lhs[52] = -rhs[27]*(-1);
  lhs[53] = -rhs[28]*(-1);
  lhs[54] = -rhs[29]*(-1);
  lhs[55] = -rhs[30]*(-1);
  lhs[56] = -rhs[31]*(-1);
  lhs[57] = -rhs[32]*(-1);
  lhs[58] = -rhs[33]*(-1);
  lhs[59] = -rhs[34]*(-1);
  lhs[60] = -rhs[35]*(-1);
  lhs[61] = -rhs[36]*(-1);
  lhs[62] = -rhs[37]*(-1);
  lhs[63] = -rhs[38]*(-1);
  lhs[64] = -rhs[39]*(-1);
  lhs[65] = -rhs[40]*(-1);
  lhs[66] = -rhs[41]*(-1);
  lhs[67] = -rhs[42]*(-1);
  lhs[68] = -rhs[43]*(-1);
  lhs[69] = -rhs[44]*(-1);
  lhs[70] = -rhs[45]*(-1);
  lhs[71] = -rhs[46]*(-1);
  lhs[72] = -rhs[47]*(-1);
  lhs[73] = -rhs[48]*(-1);
  lhs[74] = -rhs[49]*(-1);
  lhs[75] = -rhs[25]*(1);
  lhs[76] = -rhs[26]*(1);
  lhs[77] = -rhs[27]*(1);
  lhs[78] = -rhs[28]*(1);
  lhs[79] = -rhs[29]*(1);
  lhs[80] = -rhs[30]*(1);
  lhs[81] = -rhs[31]*(1);
  lhs[82] = -rhs[32]*(1);
  lhs[83] = -rhs[33]*(1);
  lhs[84] = -rhs[34]*(1);
  lhs[85] = -rhs[35]*(1);
  lhs[86] = -rhs[36]*(1);
  lhs[87] = -rhs[37]*(1);
  lhs[88] = -rhs[38]*(1);
  lhs[89] = -rhs[39]*(1);
  lhs[90] = -rhs[40]*(1);
  lhs[91] = -rhs[41]*(1);
  lhs[92] = -rhs[42]*(1);
  lhs[93] = -rhs[43]*(1);
  lhs[94] = -rhs[44]*(1);
  lhs[95] = -rhs[45]*(1);
  lhs[96] = -rhs[46]*(1);
  lhs[97] = -rhs[47]*(1);
  lhs[98] = -rhs[48]*(1);
  lhs[99] = -rhs[49]*(1);
}


-(void) multbymGTWithLhs:(double *)lhs andRhs:(double *)rhs {
  lhs[0] = -rhs[0]*(-1)-rhs[25]*(1);
  lhs[1] = -rhs[1]*(-1)-rhs[26]*(1);
  lhs[2] = -rhs[2]*(-1)-rhs[27]*(1);
  lhs[3] = -rhs[3]*(-1)-rhs[28]*(1);
  lhs[4] = -rhs[4]*(-1)-rhs[29]*(1);
  lhs[5] = -rhs[5]*(-1)-rhs[30]*(1);
  lhs[6] = -rhs[6]*(-1)-rhs[31]*(1);
  lhs[7] = -rhs[7]*(-1)-rhs[32]*(1);
  lhs[8] = -rhs[8]*(-1)-rhs[33]*(1);
  lhs[9] = -rhs[9]*(-1)-rhs[34]*(1);
  lhs[10] = -rhs[10]*(-1)-rhs[35]*(1);
  lhs[11] = -rhs[11]*(-1)-rhs[36]*(1);
  lhs[12] = -rhs[12]*(-1)-rhs[37]*(1);
  lhs[13] = -rhs[13]*(-1)-rhs[38]*(1);
  lhs[14] = -rhs[14]*(-1)-rhs[39]*(1);
  lhs[15] = -rhs[15]*(-1)-rhs[40]*(1);
  lhs[16] = -rhs[16]*(-1)-rhs[41]*(1);
  lhs[17] = -rhs[17]*(-1)-rhs[42]*(1);
  lhs[18] = -rhs[18]*(-1)-rhs[43]*(1);
  lhs[19] = -rhs[19]*(-1)-rhs[44]*(1);
  lhs[20] = -rhs[20]*(-1)-rhs[45]*(1);
  lhs[21] = -rhs[21]*(-1)-rhs[46]*(1);
  lhs[22] = -rhs[22]*(-1)-rhs[47]*(1);
  lhs[23] = -rhs[23]*(-1)-rhs[48]*(1);
  lhs[24] = -rhs[24]*(-1)-rhs[49]*(1);
  lhs[25] = -rhs[50]*(-1)-rhs[75]*(1);
  lhs[26] = -rhs[51]*(-1)-rhs[76]*(1);
  lhs[27] = -rhs[52]*(-1)-rhs[77]*(1);
  lhs[28] = -rhs[53]*(-1)-rhs[78]*(1);
  lhs[29] = -rhs[54]*(-1)-rhs[79]*(1);
  lhs[30] = -rhs[55]*(-1)-rhs[80]*(1);
  lhs[31] = -rhs[56]*(-1)-rhs[81]*(1);
  lhs[32] = -rhs[57]*(-1)-rhs[82]*(1);
  lhs[33] = -rhs[58]*(-1)-rhs[83]*(1);
  lhs[34] = -rhs[59]*(-1)-rhs[84]*(1);
  lhs[35] = -rhs[60]*(-1)-rhs[85]*(1);
  lhs[36] = -rhs[61]*(-1)-rhs[86]*(1);
  lhs[37] = -rhs[62]*(-1)-rhs[87]*(1);
  lhs[38] = -rhs[63]*(-1)-rhs[88]*(1);
  lhs[39] = -rhs[64]*(-1)-rhs[89]*(1);
  lhs[40] = -rhs[65]*(-1)-rhs[90]*(1);
  lhs[41] = -rhs[66]*(-1)-rhs[91]*(1);
  lhs[42] = -rhs[67]*(-1)-rhs[92]*(1);
  lhs[43] = -rhs[68]*(-1)-rhs[93]*(1);
  lhs[44] = -rhs[69]*(-1)-rhs[94]*(1);
  lhs[45] = -rhs[70]*(-1)-rhs[95]*(1);
  lhs[46] = -rhs[71]*(-1)-rhs[96]*(1);
  lhs[47] = -rhs[72]*(-1)-rhs[97]*(1);
  lhs[48] = -rhs[73]*(-1)-rhs[98]*(1);
  lhs[49] = -rhs[74]*(-1)-rhs[99]*(1);
}
-(void) multbyPWithLhs:(double *)lhs andRhs:(double *)rhs {
  /* TODO use the fact that P is symmetric? */
  /* TODO check doubling / half factor etc. */
  lhs[0] = rhs[0]*(2*params.E[0])+rhs[1]*(2*params.E[50])+rhs[2]*(2*params.E[100])+rhs[3]*(2*params.E[150])+rhs[4]*(2*params.E[200])+rhs[5]*(2*params.E[250])+rhs[6]*(2*params.E[300])+rhs[7]*(2*params.E[350])+rhs[8]*(2*params.E[400])+rhs[9]*(2*params.E[450])+rhs[10]*(2*params.E[500])+rhs[11]*(2*params.E[550])+rhs[12]*(2*params.E[600])+rhs[13]*(2*params.E[650])+rhs[14]*(2*params.E[700])+rhs[15]*(2*params.E[750])+rhs[16]*(2*params.E[800])+rhs[17]*(2*params.E[850])+rhs[18]*(2*params.E[900])+rhs[19]*(2*params.E[950])+rhs[20]*(2*params.E[1000])+rhs[21]*(2*params.E[1050])+rhs[22]*(2*params.E[1100])+rhs[23]*(2*params.E[1150])+rhs[24]*(2*params.E[1200])+rhs[25]*(2*params.E[1250])+rhs[26]*(2*params.E[1300])+rhs[27]*(2*params.E[1350])+rhs[28]*(2*params.E[1400])+rhs[29]*(2*params.E[1450])+rhs[30]*(2*params.E[1500])+rhs[31]*(2*params.E[1550])+rhs[32]*(2*params.E[1600])+rhs[33]*(2*params.E[1650])+rhs[34]*(2*params.E[1700])+rhs[35]*(2*params.E[1750])+rhs[36]*(2*params.E[1800])+rhs[37]*(2*params.E[1850])+rhs[38]*(2*params.E[1900])+rhs[39]*(2*params.E[1950])+rhs[40]*(2*params.E[2000])+rhs[41]*(2*params.E[2050])+rhs[42]*(2*params.E[2100])+rhs[43]*(2*params.E[2150])+rhs[44]*(2*params.E[2200])+rhs[45]*(2*params.E[2250])+rhs[46]*(2*params.E[2300])+rhs[47]*(2*params.E[2350])+rhs[48]*(2*params.E[2400])+rhs[49]*(2*params.E[2450]);
  lhs[1] = rhs[0]*(2*params.E[1])+rhs[1]*(2*params.E[51])+rhs[2]*(2*params.E[101])+rhs[3]*(2*params.E[151])+rhs[4]*(2*params.E[201])+rhs[5]*(2*params.E[251])+rhs[6]*(2*params.E[301])+rhs[7]*(2*params.E[351])+rhs[8]*(2*params.E[401])+rhs[9]*(2*params.E[451])+rhs[10]*(2*params.E[501])+rhs[11]*(2*params.E[551])+rhs[12]*(2*params.E[601])+rhs[13]*(2*params.E[651])+rhs[14]*(2*params.E[701])+rhs[15]*(2*params.E[751])+rhs[16]*(2*params.E[801])+rhs[17]*(2*params.E[851])+rhs[18]*(2*params.E[901])+rhs[19]*(2*params.E[951])+rhs[20]*(2*params.E[1001])+rhs[21]*(2*params.E[1051])+rhs[22]*(2*params.E[1101])+rhs[23]*(2*params.E[1151])+rhs[24]*(2*params.E[1201])+rhs[25]*(2*params.E[1251])+rhs[26]*(2*params.E[1301])+rhs[27]*(2*params.E[1351])+rhs[28]*(2*params.E[1401])+rhs[29]*(2*params.E[1451])+rhs[30]*(2*params.E[1501])+rhs[31]*(2*params.E[1551])+rhs[32]*(2*params.E[1601])+rhs[33]*(2*params.E[1651])+rhs[34]*(2*params.E[1701])+rhs[35]*(2*params.E[1751])+rhs[36]*(2*params.E[1801])+rhs[37]*(2*params.E[1851])+rhs[38]*(2*params.E[1901])+rhs[39]*(2*params.E[1951])+rhs[40]*(2*params.E[2001])+rhs[41]*(2*params.E[2051])+rhs[42]*(2*params.E[2101])+rhs[43]*(2*params.E[2151])+rhs[44]*(2*params.E[2201])+rhs[45]*(2*params.E[2251])+rhs[46]*(2*params.E[2301])+rhs[47]*(2*params.E[2351])+rhs[48]*(2*params.E[2401])+rhs[49]*(2*params.E[2451]);
  lhs[2] = rhs[0]*(2*params.E[2])+rhs[1]*(2*params.E[52])+rhs[2]*(2*params.E[102])+rhs[3]*(2*params.E[152])+rhs[4]*(2*params.E[202])+rhs[5]*(2*params.E[252])+rhs[6]*(2*params.E[302])+rhs[7]*(2*params.E[352])+rhs[8]*(2*params.E[402])+rhs[9]*(2*params.E[452])+rhs[10]*(2*params.E[502])+rhs[11]*(2*params.E[552])+rhs[12]*(2*params.E[602])+rhs[13]*(2*params.E[652])+rhs[14]*(2*params.E[702])+rhs[15]*(2*params.E[752])+rhs[16]*(2*params.E[802])+rhs[17]*(2*params.E[852])+rhs[18]*(2*params.E[902])+rhs[19]*(2*params.E[952])+rhs[20]*(2*params.E[1002])+rhs[21]*(2*params.E[1052])+rhs[22]*(2*params.E[1102])+rhs[23]*(2*params.E[1152])+rhs[24]*(2*params.E[1202])+rhs[25]*(2*params.E[1252])+rhs[26]*(2*params.E[1302])+rhs[27]*(2*params.E[1352])+rhs[28]*(2*params.E[1402])+rhs[29]*(2*params.E[1452])+rhs[30]*(2*params.E[1502])+rhs[31]*(2*params.E[1552])+rhs[32]*(2*params.E[1602])+rhs[33]*(2*params.E[1652])+rhs[34]*(2*params.E[1702])+rhs[35]*(2*params.E[1752])+rhs[36]*(2*params.E[1802])+rhs[37]*(2*params.E[1852])+rhs[38]*(2*params.E[1902])+rhs[39]*(2*params.E[1952])+rhs[40]*(2*params.E[2002])+rhs[41]*(2*params.E[2052])+rhs[42]*(2*params.E[2102])+rhs[43]*(2*params.E[2152])+rhs[44]*(2*params.E[2202])+rhs[45]*(2*params.E[2252])+rhs[46]*(2*params.E[2302])+rhs[47]*(2*params.E[2352])+rhs[48]*(2*params.E[2402])+rhs[49]*(2*params.E[2452]);
  lhs[3] = rhs[0]*(2*params.E[3])+rhs[1]*(2*params.E[53])+rhs[2]*(2*params.E[103])+rhs[3]*(2*params.E[153])+rhs[4]*(2*params.E[203])+rhs[5]*(2*params.E[253])+rhs[6]*(2*params.E[303])+rhs[7]*(2*params.E[353])+rhs[8]*(2*params.E[403])+rhs[9]*(2*params.E[453])+rhs[10]*(2*params.E[503])+rhs[11]*(2*params.E[553])+rhs[12]*(2*params.E[603])+rhs[13]*(2*params.E[653])+rhs[14]*(2*params.E[703])+rhs[15]*(2*params.E[753])+rhs[16]*(2*params.E[803])+rhs[17]*(2*params.E[853])+rhs[18]*(2*params.E[903])+rhs[19]*(2*params.E[953])+rhs[20]*(2*params.E[1003])+rhs[21]*(2*params.E[1053])+rhs[22]*(2*params.E[1103])+rhs[23]*(2*params.E[1153])+rhs[24]*(2*params.E[1203])+rhs[25]*(2*params.E[1253])+rhs[26]*(2*params.E[1303])+rhs[27]*(2*params.E[1353])+rhs[28]*(2*params.E[1403])+rhs[29]*(2*params.E[1453])+rhs[30]*(2*params.E[1503])+rhs[31]*(2*params.E[1553])+rhs[32]*(2*params.E[1603])+rhs[33]*(2*params.E[1653])+rhs[34]*(2*params.E[1703])+rhs[35]*(2*params.E[1753])+rhs[36]*(2*params.E[1803])+rhs[37]*(2*params.E[1853])+rhs[38]*(2*params.E[1903])+rhs[39]*(2*params.E[1953])+rhs[40]*(2*params.E[2003])+rhs[41]*(2*params.E[2053])+rhs[42]*(2*params.E[2103])+rhs[43]*(2*params.E[2153])+rhs[44]*(2*params.E[2203])+rhs[45]*(2*params.E[2253])+rhs[46]*(2*params.E[2303])+rhs[47]*(2*params.E[2353])+rhs[48]*(2*params.E[2403])+rhs[49]*(2*params.E[2453]);
  lhs[4] = rhs[0]*(2*params.E[4])+rhs[1]*(2*params.E[54])+rhs[2]*(2*params.E[104])+rhs[3]*(2*params.E[154])+rhs[4]*(2*params.E[204])+rhs[5]*(2*params.E[254])+rhs[6]*(2*params.E[304])+rhs[7]*(2*params.E[354])+rhs[8]*(2*params.E[404])+rhs[9]*(2*params.E[454])+rhs[10]*(2*params.E[504])+rhs[11]*(2*params.E[554])+rhs[12]*(2*params.E[604])+rhs[13]*(2*params.E[654])+rhs[14]*(2*params.E[704])+rhs[15]*(2*params.E[754])+rhs[16]*(2*params.E[804])+rhs[17]*(2*params.E[854])+rhs[18]*(2*params.E[904])+rhs[19]*(2*params.E[954])+rhs[20]*(2*params.E[1004])+rhs[21]*(2*params.E[1054])+rhs[22]*(2*params.E[1104])+rhs[23]*(2*params.E[1154])+rhs[24]*(2*params.E[1204])+rhs[25]*(2*params.E[1254])+rhs[26]*(2*params.E[1304])+rhs[27]*(2*params.E[1354])+rhs[28]*(2*params.E[1404])+rhs[29]*(2*params.E[1454])+rhs[30]*(2*params.E[1504])+rhs[31]*(2*params.E[1554])+rhs[32]*(2*params.E[1604])+rhs[33]*(2*params.E[1654])+rhs[34]*(2*params.E[1704])+rhs[35]*(2*params.E[1754])+rhs[36]*(2*params.E[1804])+rhs[37]*(2*params.E[1854])+rhs[38]*(2*params.E[1904])+rhs[39]*(2*params.E[1954])+rhs[40]*(2*params.E[2004])+rhs[41]*(2*params.E[2054])+rhs[42]*(2*params.E[2104])+rhs[43]*(2*params.E[2154])+rhs[44]*(2*params.E[2204])+rhs[45]*(2*params.E[2254])+rhs[46]*(2*params.E[2304])+rhs[47]*(2*params.E[2354])+rhs[48]*(2*params.E[2404])+rhs[49]*(2*params.E[2454]);
  lhs[5] = rhs[0]*(2*params.E[5])+rhs[1]*(2*params.E[55])+rhs[2]*(2*params.E[105])+rhs[3]*(2*params.E[155])+rhs[4]*(2*params.E[205])+rhs[5]*(2*params.E[255])+rhs[6]*(2*params.E[305])+rhs[7]*(2*params.E[355])+rhs[8]*(2*params.E[405])+rhs[9]*(2*params.E[455])+rhs[10]*(2*params.E[505])+rhs[11]*(2*params.E[555])+rhs[12]*(2*params.E[605])+rhs[13]*(2*params.E[655])+rhs[14]*(2*params.E[705])+rhs[15]*(2*params.E[755])+rhs[16]*(2*params.E[805])+rhs[17]*(2*params.E[855])+rhs[18]*(2*params.E[905])+rhs[19]*(2*params.E[955])+rhs[20]*(2*params.E[1005])+rhs[21]*(2*params.E[1055])+rhs[22]*(2*params.E[1105])+rhs[23]*(2*params.E[1155])+rhs[24]*(2*params.E[1205])+rhs[25]*(2*params.E[1255])+rhs[26]*(2*params.E[1305])+rhs[27]*(2*params.E[1355])+rhs[28]*(2*params.E[1405])+rhs[29]*(2*params.E[1455])+rhs[30]*(2*params.E[1505])+rhs[31]*(2*params.E[1555])+rhs[32]*(2*params.E[1605])+rhs[33]*(2*params.E[1655])+rhs[34]*(2*params.E[1705])+rhs[35]*(2*params.E[1755])+rhs[36]*(2*params.E[1805])+rhs[37]*(2*params.E[1855])+rhs[38]*(2*params.E[1905])+rhs[39]*(2*params.E[1955])+rhs[40]*(2*params.E[2005])+rhs[41]*(2*params.E[2055])+rhs[42]*(2*params.E[2105])+rhs[43]*(2*params.E[2155])+rhs[44]*(2*params.E[2205])+rhs[45]*(2*params.E[2255])+rhs[46]*(2*params.E[2305])+rhs[47]*(2*params.E[2355])+rhs[48]*(2*params.E[2405])+rhs[49]*(2*params.E[2455]);
  lhs[6] = rhs[0]*(2*params.E[6])+rhs[1]*(2*params.E[56])+rhs[2]*(2*params.E[106])+rhs[3]*(2*params.E[156])+rhs[4]*(2*params.E[206])+rhs[5]*(2*params.E[256])+rhs[6]*(2*params.E[306])+rhs[7]*(2*params.E[356])+rhs[8]*(2*params.E[406])+rhs[9]*(2*params.E[456])+rhs[10]*(2*params.E[506])+rhs[11]*(2*params.E[556])+rhs[12]*(2*params.E[606])+rhs[13]*(2*params.E[656])+rhs[14]*(2*params.E[706])+rhs[15]*(2*params.E[756])+rhs[16]*(2*params.E[806])+rhs[17]*(2*params.E[856])+rhs[18]*(2*params.E[906])+rhs[19]*(2*params.E[956])+rhs[20]*(2*params.E[1006])+rhs[21]*(2*params.E[1056])+rhs[22]*(2*params.E[1106])+rhs[23]*(2*params.E[1156])+rhs[24]*(2*params.E[1206])+rhs[25]*(2*params.E[1256])+rhs[26]*(2*params.E[1306])+rhs[27]*(2*params.E[1356])+rhs[28]*(2*params.E[1406])+rhs[29]*(2*params.E[1456])+rhs[30]*(2*params.E[1506])+rhs[31]*(2*params.E[1556])+rhs[32]*(2*params.E[1606])+rhs[33]*(2*params.E[1656])+rhs[34]*(2*params.E[1706])+rhs[35]*(2*params.E[1756])+rhs[36]*(2*params.E[1806])+rhs[37]*(2*params.E[1856])+rhs[38]*(2*params.E[1906])+rhs[39]*(2*params.E[1956])+rhs[40]*(2*params.E[2006])+rhs[41]*(2*params.E[2056])+rhs[42]*(2*params.E[2106])+rhs[43]*(2*params.E[2156])+rhs[44]*(2*params.E[2206])+rhs[45]*(2*params.E[2256])+rhs[46]*(2*params.E[2306])+rhs[47]*(2*params.E[2356])+rhs[48]*(2*params.E[2406])+rhs[49]*(2*params.E[2456]);
  lhs[7] = rhs[0]*(2*params.E[7])+rhs[1]*(2*params.E[57])+rhs[2]*(2*params.E[107])+rhs[3]*(2*params.E[157])+rhs[4]*(2*params.E[207])+rhs[5]*(2*params.E[257])+rhs[6]*(2*params.E[307])+rhs[7]*(2*params.E[357])+rhs[8]*(2*params.E[407])+rhs[9]*(2*params.E[457])+rhs[10]*(2*params.E[507])+rhs[11]*(2*params.E[557])+rhs[12]*(2*params.E[607])+rhs[13]*(2*params.E[657])+rhs[14]*(2*params.E[707])+rhs[15]*(2*params.E[757])+rhs[16]*(2*params.E[807])+rhs[17]*(2*params.E[857])+rhs[18]*(2*params.E[907])+rhs[19]*(2*params.E[957])+rhs[20]*(2*params.E[1007])+rhs[21]*(2*params.E[1057])+rhs[22]*(2*params.E[1107])+rhs[23]*(2*params.E[1157])+rhs[24]*(2*params.E[1207])+rhs[25]*(2*params.E[1257])+rhs[26]*(2*params.E[1307])+rhs[27]*(2*params.E[1357])+rhs[28]*(2*params.E[1407])+rhs[29]*(2*params.E[1457])+rhs[30]*(2*params.E[1507])+rhs[31]*(2*params.E[1557])+rhs[32]*(2*params.E[1607])+rhs[33]*(2*params.E[1657])+rhs[34]*(2*params.E[1707])+rhs[35]*(2*params.E[1757])+rhs[36]*(2*params.E[1807])+rhs[37]*(2*params.E[1857])+rhs[38]*(2*params.E[1907])+rhs[39]*(2*params.E[1957])+rhs[40]*(2*params.E[2007])+rhs[41]*(2*params.E[2057])+rhs[42]*(2*params.E[2107])+rhs[43]*(2*params.E[2157])+rhs[44]*(2*params.E[2207])+rhs[45]*(2*params.E[2257])+rhs[46]*(2*params.E[2307])+rhs[47]*(2*params.E[2357])+rhs[48]*(2*params.E[2407])+rhs[49]*(2*params.E[2457]);
  lhs[8] = rhs[0]*(2*params.E[8])+rhs[1]*(2*params.E[58])+rhs[2]*(2*params.E[108])+rhs[3]*(2*params.E[158])+rhs[4]*(2*params.E[208])+rhs[5]*(2*params.E[258])+rhs[6]*(2*params.E[308])+rhs[7]*(2*params.E[358])+rhs[8]*(2*params.E[408])+rhs[9]*(2*params.E[458])+rhs[10]*(2*params.E[508])+rhs[11]*(2*params.E[558])+rhs[12]*(2*params.E[608])+rhs[13]*(2*params.E[658])+rhs[14]*(2*params.E[708])+rhs[15]*(2*params.E[758])+rhs[16]*(2*params.E[808])+rhs[17]*(2*params.E[858])+rhs[18]*(2*params.E[908])+rhs[19]*(2*params.E[958])+rhs[20]*(2*params.E[1008])+rhs[21]*(2*params.E[1058])+rhs[22]*(2*params.E[1108])+rhs[23]*(2*params.E[1158])+rhs[24]*(2*params.E[1208])+rhs[25]*(2*params.E[1258])+rhs[26]*(2*params.E[1308])+rhs[27]*(2*params.E[1358])+rhs[28]*(2*params.E[1408])+rhs[29]*(2*params.E[1458])+rhs[30]*(2*params.E[1508])+rhs[31]*(2*params.E[1558])+rhs[32]*(2*params.E[1608])+rhs[33]*(2*params.E[1658])+rhs[34]*(2*params.E[1708])+rhs[35]*(2*params.E[1758])+rhs[36]*(2*params.E[1808])+rhs[37]*(2*params.E[1858])+rhs[38]*(2*params.E[1908])+rhs[39]*(2*params.E[1958])+rhs[40]*(2*params.E[2008])+rhs[41]*(2*params.E[2058])+rhs[42]*(2*params.E[2108])+rhs[43]*(2*params.E[2158])+rhs[44]*(2*params.E[2208])+rhs[45]*(2*params.E[2258])+rhs[46]*(2*params.E[2308])+rhs[47]*(2*params.E[2358])+rhs[48]*(2*params.E[2408])+rhs[49]*(2*params.E[2458]);
  lhs[9] = rhs[0]*(2*params.E[9])+rhs[1]*(2*params.E[59])+rhs[2]*(2*params.E[109])+rhs[3]*(2*params.E[159])+rhs[4]*(2*params.E[209])+rhs[5]*(2*params.E[259])+rhs[6]*(2*params.E[309])+rhs[7]*(2*params.E[359])+rhs[8]*(2*params.E[409])+rhs[9]*(2*params.E[459])+rhs[10]*(2*params.E[509])+rhs[11]*(2*params.E[559])+rhs[12]*(2*params.E[609])+rhs[13]*(2*params.E[659])+rhs[14]*(2*params.E[709])+rhs[15]*(2*params.E[759])+rhs[16]*(2*params.E[809])+rhs[17]*(2*params.E[859])+rhs[18]*(2*params.E[909])+rhs[19]*(2*params.E[959])+rhs[20]*(2*params.E[1009])+rhs[21]*(2*params.E[1059])+rhs[22]*(2*params.E[1109])+rhs[23]*(2*params.E[1159])+rhs[24]*(2*params.E[1209])+rhs[25]*(2*params.E[1259])+rhs[26]*(2*params.E[1309])+rhs[27]*(2*params.E[1359])+rhs[28]*(2*params.E[1409])+rhs[29]*(2*params.E[1459])+rhs[30]*(2*params.E[1509])+rhs[31]*(2*params.E[1559])+rhs[32]*(2*params.E[1609])+rhs[33]*(2*params.E[1659])+rhs[34]*(2*params.E[1709])+rhs[35]*(2*params.E[1759])+rhs[36]*(2*params.E[1809])+rhs[37]*(2*params.E[1859])+rhs[38]*(2*params.E[1909])+rhs[39]*(2*params.E[1959])+rhs[40]*(2*params.E[2009])+rhs[41]*(2*params.E[2059])+rhs[42]*(2*params.E[2109])+rhs[43]*(2*params.E[2159])+rhs[44]*(2*params.E[2209])+rhs[45]*(2*params.E[2259])+rhs[46]*(2*params.E[2309])+rhs[47]*(2*params.E[2359])+rhs[48]*(2*params.E[2409])+rhs[49]*(2*params.E[2459]);
  lhs[10] = rhs[0]*(2*params.E[10])+rhs[1]*(2*params.E[60])+rhs[2]*(2*params.E[110])+rhs[3]*(2*params.E[160])+rhs[4]*(2*params.E[210])+rhs[5]*(2*params.E[260])+rhs[6]*(2*params.E[310])+rhs[7]*(2*params.E[360])+rhs[8]*(2*params.E[410])+rhs[9]*(2*params.E[460])+rhs[10]*(2*params.E[510])+rhs[11]*(2*params.E[560])+rhs[12]*(2*params.E[610])+rhs[13]*(2*params.E[660])+rhs[14]*(2*params.E[710])+rhs[15]*(2*params.E[760])+rhs[16]*(2*params.E[810])+rhs[17]*(2*params.E[860])+rhs[18]*(2*params.E[910])+rhs[19]*(2*params.E[960])+rhs[20]*(2*params.E[1010])+rhs[21]*(2*params.E[1060])+rhs[22]*(2*params.E[1110])+rhs[23]*(2*params.E[1160])+rhs[24]*(2*params.E[1210])+rhs[25]*(2*params.E[1260])+rhs[26]*(2*params.E[1310])+rhs[27]*(2*params.E[1360])+rhs[28]*(2*params.E[1410])+rhs[29]*(2*params.E[1460])+rhs[30]*(2*params.E[1510])+rhs[31]*(2*params.E[1560])+rhs[32]*(2*params.E[1610])+rhs[33]*(2*params.E[1660])+rhs[34]*(2*params.E[1710])+rhs[35]*(2*params.E[1760])+rhs[36]*(2*params.E[1810])+rhs[37]*(2*params.E[1860])+rhs[38]*(2*params.E[1910])+rhs[39]*(2*params.E[1960])+rhs[40]*(2*params.E[2010])+rhs[41]*(2*params.E[2060])+rhs[42]*(2*params.E[2110])+rhs[43]*(2*params.E[2160])+rhs[44]*(2*params.E[2210])+rhs[45]*(2*params.E[2260])+rhs[46]*(2*params.E[2310])+rhs[47]*(2*params.E[2360])+rhs[48]*(2*params.E[2410])+rhs[49]*(2*params.E[2460]);
  lhs[11] = rhs[0]*(2*params.E[11])+rhs[1]*(2*params.E[61])+rhs[2]*(2*params.E[111])+rhs[3]*(2*params.E[161])+rhs[4]*(2*params.E[211])+rhs[5]*(2*params.E[261])+rhs[6]*(2*params.E[311])+rhs[7]*(2*params.E[361])+rhs[8]*(2*params.E[411])+rhs[9]*(2*params.E[461])+rhs[10]*(2*params.E[511])+rhs[11]*(2*params.E[561])+rhs[12]*(2*params.E[611])+rhs[13]*(2*params.E[661])+rhs[14]*(2*params.E[711])+rhs[15]*(2*params.E[761])+rhs[16]*(2*params.E[811])+rhs[17]*(2*params.E[861])+rhs[18]*(2*params.E[911])+rhs[19]*(2*params.E[961])+rhs[20]*(2*params.E[1011])+rhs[21]*(2*params.E[1061])+rhs[22]*(2*params.E[1111])+rhs[23]*(2*params.E[1161])+rhs[24]*(2*params.E[1211])+rhs[25]*(2*params.E[1261])+rhs[26]*(2*params.E[1311])+rhs[27]*(2*params.E[1361])+rhs[28]*(2*params.E[1411])+rhs[29]*(2*params.E[1461])+rhs[30]*(2*params.E[1511])+rhs[31]*(2*params.E[1561])+rhs[32]*(2*params.E[1611])+rhs[33]*(2*params.E[1661])+rhs[34]*(2*params.E[1711])+rhs[35]*(2*params.E[1761])+rhs[36]*(2*params.E[1811])+rhs[37]*(2*params.E[1861])+rhs[38]*(2*params.E[1911])+rhs[39]*(2*params.E[1961])+rhs[40]*(2*params.E[2011])+rhs[41]*(2*params.E[2061])+rhs[42]*(2*params.E[2111])+rhs[43]*(2*params.E[2161])+rhs[44]*(2*params.E[2211])+rhs[45]*(2*params.E[2261])+rhs[46]*(2*params.E[2311])+rhs[47]*(2*params.E[2361])+rhs[48]*(2*params.E[2411])+rhs[49]*(2*params.E[2461]);
  lhs[12] = rhs[0]*(2*params.E[12])+rhs[1]*(2*params.E[62])+rhs[2]*(2*params.E[112])+rhs[3]*(2*params.E[162])+rhs[4]*(2*params.E[212])+rhs[5]*(2*params.E[262])+rhs[6]*(2*params.E[312])+rhs[7]*(2*params.E[362])+rhs[8]*(2*params.E[412])+rhs[9]*(2*params.E[462])+rhs[10]*(2*params.E[512])+rhs[11]*(2*params.E[562])+rhs[12]*(2*params.E[612])+rhs[13]*(2*params.E[662])+rhs[14]*(2*params.E[712])+rhs[15]*(2*params.E[762])+rhs[16]*(2*params.E[812])+rhs[17]*(2*params.E[862])+rhs[18]*(2*params.E[912])+rhs[19]*(2*params.E[962])+rhs[20]*(2*params.E[1012])+rhs[21]*(2*params.E[1062])+rhs[22]*(2*params.E[1112])+rhs[23]*(2*params.E[1162])+rhs[24]*(2*params.E[1212])+rhs[25]*(2*params.E[1262])+rhs[26]*(2*params.E[1312])+rhs[27]*(2*params.E[1362])+rhs[28]*(2*params.E[1412])+rhs[29]*(2*params.E[1462])+rhs[30]*(2*params.E[1512])+rhs[31]*(2*params.E[1562])+rhs[32]*(2*params.E[1612])+rhs[33]*(2*params.E[1662])+rhs[34]*(2*params.E[1712])+rhs[35]*(2*params.E[1762])+rhs[36]*(2*params.E[1812])+rhs[37]*(2*params.E[1862])+rhs[38]*(2*params.E[1912])+rhs[39]*(2*params.E[1962])+rhs[40]*(2*params.E[2012])+rhs[41]*(2*params.E[2062])+rhs[42]*(2*params.E[2112])+rhs[43]*(2*params.E[2162])+rhs[44]*(2*params.E[2212])+rhs[45]*(2*params.E[2262])+rhs[46]*(2*params.E[2312])+rhs[47]*(2*params.E[2362])+rhs[48]*(2*params.E[2412])+rhs[49]*(2*params.E[2462]);
  lhs[13] = rhs[0]*(2*params.E[13])+rhs[1]*(2*params.E[63])+rhs[2]*(2*params.E[113])+rhs[3]*(2*params.E[163])+rhs[4]*(2*params.E[213])+rhs[5]*(2*params.E[263])+rhs[6]*(2*params.E[313])+rhs[7]*(2*params.E[363])+rhs[8]*(2*params.E[413])+rhs[9]*(2*params.E[463])+rhs[10]*(2*params.E[513])+rhs[11]*(2*params.E[563])+rhs[12]*(2*params.E[613])+rhs[13]*(2*params.E[663])+rhs[14]*(2*params.E[713])+rhs[15]*(2*params.E[763])+rhs[16]*(2*params.E[813])+rhs[17]*(2*params.E[863])+rhs[18]*(2*params.E[913])+rhs[19]*(2*params.E[963])+rhs[20]*(2*params.E[1013])+rhs[21]*(2*params.E[1063])+rhs[22]*(2*params.E[1113])+rhs[23]*(2*params.E[1163])+rhs[24]*(2*params.E[1213])+rhs[25]*(2*params.E[1263])+rhs[26]*(2*params.E[1313])+rhs[27]*(2*params.E[1363])+rhs[28]*(2*params.E[1413])+rhs[29]*(2*params.E[1463])+rhs[30]*(2*params.E[1513])+rhs[31]*(2*params.E[1563])+rhs[32]*(2*params.E[1613])+rhs[33]*(2*params.E[1663])+rhs[34]*(2*params.E[1713])+rhs[35]*(2*params.E[1763])+rhs[36]*(2*params.E[1813])+rhs[37]*(2*params.E[1863])+rhs[38]*(2*params.E[1913])+rhs[39]*(2*params.E[1963])+rhs[40]*(2*params.E[2013])+rhs[41]*(2*params.E[2063])+rhs[42]*(2*params.E[2113])+rhs[43]*(2*params.E[2163])+rhs[44]*(2*params.E[2213])+rhs[45]*(2*params.E[2263])+rhs[46]*(2*params.E[2313])+rhs[47]*(2*params.E[2363])+rhs[48]*(2*params.E[2413])+rhs[49]*(2*params.E[2463]);
  lhs[14] = rhs[0]*(2*params.E[14])+rhs[1]*(2*params.E[64])+rhs[2]*(2*params.E[114])+rhs[3]*(2*params.E[164])+rhs[4]*(2*params.E[214])+rhs[5]*(2*params.E[264])+rhs[6]*(2*params.E[314])+rhs[7]*(2*params.E[364])+rhs[8]*(2*params.E[414])+rhs[9]*(2*params.E[464])+rhs[10]*(2*params.E[514])+rhs[11]*(2*params.E[564])+rhs[12]*(2*params.E[614])+rhs[13]*(2*params.E[664])+rhs[14]*(2*params.E[714])+rhs[15]*(2*params.E[764])+rhs[16]*(2*params.E[814])+rhs[17]*(2*params.E[864])+rhs[18]*(2*params.E[914])+rhs[19]*(2*params.E[964])+rhs[20]*(2*params.E[1014])+rhs[21]*(2*params.E[1064])+rhs[22]*(2*params.E[1114])+rhs[23]*(2*params.E[1164])+rhs[24]*(2*params.E[1214])+rhs[25]*(2*params.E[1264])+rhs[26]*(2*params.E[1314])+rhs[27]*(2*params.E[1364])+rhs[28]*(2*params.E[1414])+rhs[29]*(2*params.E[1464])+rhs[30]*(2*params.E[1514])+rhs[31]*(2*params.E[1564])+rhs[32]*(2*params.E[1614])+rhs[33]*(2*params.E[1664])+rhs[34]*(2*params.E[1714])+rhs[35]*(2*params.E[1764])+rhs[36]*(2*params.E[1814])+rhs[37]*(2*params.E[1864])+rhs[38]*(2*params.E[1914])+rhs[39]*(2*params.E[1964])+rhs[40]*(2*params.E[2014])+rhs[41]*(2*params.E[2064])+rhs[42]*(2*params.E[2114])+rhs[43]*(2*params.E[2164])+rhs[44]*(2*params.E[2214])+rhs[45]*(2*params.E[2264])+rhs[46]*(2*params.E[2314])+rhs[47]*(2*params.E[2364])+rhs[48]*(2*params.E[2414])+rhs[49]*(2*params.E[2464]);
  lhs[15] = rhs[0]*(2*params.E[15])+rhs[1]*(2*params.E[65])+rhs[2]*(2*params.E[115])+rhs[3]*(2*params.E[165])+rhs[4]*(2*params.E[215])+rhs[5]*(2*params.E[265])+rhs[6]*(2*params.E[315])+rhs[7]*(2*params.E[365])+rhs[8]*(2*params.E[415])+rhs[9]*(2*params.E[465])+rhs[10]*(2*params.E[515])+rhs[11]*(2*params.E[565])+rhs[12]*(2*params.E[615])+rhs[13]*(2*params.E[665])+rhs[14]*(2*params.E[715])+rhs[15]*(2*params.E[765])+rhs[16]*(2*params.E[815])+rhs[17]*(2*params.E[865])+rhs[18]*(2*params.E[915])+rhs[19]*(2*params.E[965])+rhs[20]*(2*params.E[1015])+rhs[21]*(2*params.E[1065])+rhs[22]*(2*params.E[1115])+rhs[23]*(2*params.E[1165])+rhs[24]*(2*params.E[1215])+rhs[25]*(2*params.E[1265])+rhs[26]*(2*params.E[1315])+rhs[27]*(2*params.E[1365])+rhs[28]*(2*params.E[1415])+rhs[29]*(2*params.E[1465])+rhs[30]*(2*params.E[1515])+rhs[31]*(2*params.E[1565])+rhs[32]*(2*params.E[1615])+rhs[33]*(2*params.E[1665])+rhs[34]*(2*params.E[1715])+rhs[35]*(2*params.E[1765])+rhs[36]*(2*params.E[1815])+rhs[37]*(2*params.E[1865])+rhs[38]*(2*params.E[1915])+rhs[39]*(2*params.E[1965])+rhs[40]*(2*params.E[2015])+rhs[41]*(2*params.E[2065])+rhs[42]*(2*params.E[2115])+rhs[43]*(2*params.E[2165])+rhs[44]*(2*params.E[2215])+rhs[45]*(2*params.E[2265])+rhs[46]*(2*params.E[2315])+rhs[47]*(2*params.E[2365])+rhs[48]*(2*params.E[2415])+rhs[49]*(2*params.E[2465]);
  lhs[16] = rhs[0]*(2*params.E[16])+rhs[1]*(2*params.E[66])+rhs[2]*(2*params.E[116])+rhs[3]*(2*params.E[166])+rhs[4]*(2*params.E[216])+rhs[5]*(2*params.E[266])+rhs[6]*(2*params.E[316])+rhs[7]*(2*params.E[366])+rhs[8]*(2*params.E[416])+rhs[9]*(2*params.E[466])+rhs[10]*(2*params.E[516])+rhs[11]*(2*params.E[566])+rhs[12]*(2*params.E[616])+rhs[13]*(2*params.E[666])+rhs[14]*(2*params.E[716])+rhs[15]*(2*params.E[766])+rhs[16]*(2*params.E[816])+rhs[17]*(2*params.E[866])+rhs[18]*(2*params.E[916])+rhs[19]*(2*params.E[966])+rhs[20]*(2*params.E[1016])+rhs[21]*(2*params.E[1066])+rhs[22]*(2*params.E[1116])+rhs[23]*(2*params.E[1166])+rhs[24]*(2*params.E[1216])+rhs[25]*(2*params.E[1266])+rhs[26]*(2*params.E[1316])+rhs[27]*(2*params.E[1366])+rhs[28]*(2*params.E[1416])+rhs[29]*(2*params.E[1466])+rhs[30]*(2*params.E[1516])+rhs[31]*(2*params.E[1566])+rhs[32]*(2*params.E[1616])+rhs[33]*(2*params.E[1666])+rhs[34]*(2*params.E[1716])+rhs[35]*(2*params.E[1766])+rhs[36]*(2*params.E[1816])+rhs[37]*(2*params.E[1866])+rhs[38]*(2*params.E[1916])+rhs[39]*(2*params.E[1966])+rhs[40]*(2*params.E[2016])+rhs[41]*(2*params.E[2066])+rhs[42]*(2*params.E[2116])+rhs[43]*(2*params.E[2166])+rhs[44]*(2*params.E[2216])+rhs[45]*(2*params.E[2266])+rhs[46]*(2*params.E[2316])+rhs[47]*(2*params.E[2366])+rhs[48]*(2*params.E[2416])+rhs[49]*(2*params.E[2466]);
  lhs[17] = rhs[0]*(2*params.E[17])+rhs[1]*(2*params.E[67])+rhs[2]*(2*params.E[117])+rhs[3]*(2*params.E[167])+rhs[4]*(2*params.E[217])+rhs[5]*(2*params.E[267])+rhs[6]*(2*params.E[317])+rhs[7]*(2*params.E[367])+rhs[8]*(2*params.E[417])+rhs[9]*(2*params.E[467])+rhs[10]*(2*params.E[517])+rhs[11]*(2*params.E[567])+rhs[12]*(2*params.E[617])+rhs[13]*(2*params.E[667])+rhs[14]*(2*params.E[717])+rhs[15]*(2*params.E[767])+rhs[16]*(2*params.E[817])+rhs[17]*(2*params.E[867])+rhs[18]*(2*params.E[917])+rhs[19]*(2*params.E[967])+rhs[20]*(2*params.E[1017])+rhs[21]*(2*params.E[1067])+rhs[22]*(2*params.E[1117])+rhs[23]*(2*params.E[1167])+rhs[24]*(2*params.E[1217])+rhs[25]*(2*params.E[1267])+rhs[26]*(2*params.E[1317])+rhs[27]*(2*params.E[1367])+rhs[28]*(2*params.E[1417])+rhs[29]*(2*params.E[1467])+rhs[30]*(2*params.E[1517])+rhs[31]*(2*params.E[1567])+rhs[32]*(2*params.E[1617])+rhs[33]*(2*params.E[1667])+rhs[34]*(2*params.E[1717])+rhs[35]*(2*params.E[1767])+rhs[36]*(2*params.E[1817])+rhs[37]*(2*params.E[1867])+rhs[38]*(2*params.E[1917])+rhs[39]*(2*params.E[1967])+rhs[40]*(2*params.E[2017])+rhs[41]*(2*params.E[2067])+rhs[42]*(2*params.E[2117])+rhs[43]*(2*params.E[2167])+rhs[44]*(2*params.E[2217])+rhs[45]*(2*params.E[2267])+rhs[46]*(2*params.E[2317])+rhs[47]*(2*params.E[2367])+rhs[48]*(2*params.E[2417])+rhs[49]*(2*params.E[2467]);
  lhs[18] = rhs[0]*(2*params.E[18])+rhs[1]*(2*params.E[68])+rhs[2]*(2*params.E[118])+rhs[3]*(2*params.E[168])+rhs[4]*(2*params.E[218])+rhs[5]*(2*params.E[268])+rhs[6]*(2*params.E[318])+rhs[7]*(2*params.E[368])+rhs[8]*(2*params.E[418])+rhs[9]*(2*params.E[468])+rhs[10]*(2*params.E[518])+rhs[11]*(2*params.E[568])+rhs[12]*(2*params.E[618])+rhs[13]*(2*params.E[668])+rhs[14]*(2*params.E[718])+rhs[15]*(2*params.E[768])+rhs[16]*(2*params.E[818])+rhs[17]*(2*params.E[868])+rhs[18]*(2*params.E[918])+rhs[19]*(2*params.E[968])+rhs[20]*(2*params.E[1018])+rhs[21]*(2*params.E[1068])+rhs[22]*(2*params.E[1118])+rhs[23]*(2*params.E[1168])+rhs[24]*(2*params.E[1218])+rhs[25]*(2*params.E[1268])+rhs[26]*(2*params.E[1318])+rhs[27]*(2*params.E[1368])+rhs[28]*(2*params.E[1418])+rhs[29]*(2*params.E[1468])+rhs[30]*(2*params.E[1518])+rhs[31]*(2*params.E[1568])+rhs[32]*(2*params.E[1618])+rhs[33]*(2*params.E[1668])+rhs[34]*(2*params.E[1718])+rhs[35]*(2*params.E[1768])+rhs[36]*(2*params.E[1818])+rhs[37]*(2*params.E[1868])+rhs[38]*(2*params.E[1918])+rhs[39]*(2*params.E[1968])+rhs[40]*(2*params.E[2018])+rhs[41]*(2*params.E[2068])+rhs[42]*(2*params.E[2118])+rhs[43]*(2*params.E[2168])+rhs[44]*(2*params.E[2218])+rhs[45]*(2*params.E[2268])+rhs[46]*(2*params.E[2318])+rhs[47]*(2*params.E[2368])+rhs[48]*(2*params.E[2418])+rhs[49]*(2*params.E[2468]);
  lhs[19] = rhs[0]*(2*params.E[19])+rhs[1]*(2*params.E[69])+rhs[2]*(2*params.E[119])+rhs[3]*(2*params.E[169])+rhs[4]*(2*params.E[219])+rhs[5]*(2*params.E[269])+rhs[6]*(2*params.E[319])+rhs[7]*(2*params.E[369])+rhs[8]*(2*params.E[419])+rhs[9]*(2*params.E[469])+rhs[10]*(2*params.E[519])+rhs[11]*(2*params.E[569])+rhs[12]*(2*params.E[619])+rhs[13]*(2*params.E[669])+rhs[14]*(2*params.E[719])+rhs[15]*(2*params.E[769])+rhs[16]*(2*params.E[819])+rhs[17]*(2*params.E[869])+rhs[18]*(2*params.E[919])+rhs[19]*(2*params.E[969])+rhs[20]*(2*params.E[1019])+rhs[21]*(2*params.E[1069])+rhs[22]*(2*params.E[1119])+rhs[23]*(2*params.E[1169])+rhs[24]*(2*params.E[1219])+rhs[25]*(2*params.E[1269])+rhs[26]*(2*params.E[1319])+rhs[27]*(2*params.E[1369])+rhs[28]*(2*params.E[1419])+rhs[29]*(2*params.E[1469])+rhs[30]*(2*params.E[1519])+rhs[31]*(2*params.E[1569])+rhs[32]*(2*params.E[1619])+rhs[33]*(2*params.E[1669])+rhs[34]*(2*params.E[1719])+rhs[35]*(2*params.E[1769])+rhs[36]*(2*params.E[1819])+rhs[37]*(2*params.E[1869])+rhs[38]*(2*params.E[1919])+rhs[39]*(2*params.E[1969])+rhs[40]*(2*params.E[2019])+rhs[41]*(2*params.E[2069])+rhs[42]*(2*params.E[2119])+rhs[43]*(2*params.E[2169])+rhs[44]*(2*params.E[2219])+rhs[45]*(2*params.E[2269])+rhs[46]*(2*params.E[2319])+rhs[47]*(2*params.E[2369])+rhs[48]*(2*params.E[2419])+rhs[49]*(2*params.E[2469]);
  lhs[20] = rhs[0]*(2*params.E[20])+rhs[1]*(2*params.E[70])+rhs[2]*(2*params.E[120])+rhs[3]*(2*params.E[170])+rhs[4]*(2*params.E[220])+rhs[5]*(2*params.E[270])+rhs[6]*(2*params.E[320])+rhs[7]*(2*params.E[370])+rhs[8]*(2*params.E[420])+rhs[9]*(2*params.E[470])+rhs[10]*(2*params.E[520])+rhs[11]*(2*params.E[570])+rhs[12]*(2*params.E[620])+rhs[13]*(2*params.E[670])+rhs[14]*(2*params.E[720])+rhs[15]*(2*params.E[770])+rhs[16]*(2*params.E[820])+rhs[17]*(2*params.E[870])+rhs[18]*(2*params.E[920])+rhs[19]*(2*params.E[970])+rhs[20]*(2*params.E[1020])+rhs[21]*(2*params.E[1070])+rhs[22]*(2*params.E[1120])+rhs[23]*(2*params.E[1170])+rhs[24]*(2*params.E[1220])+rhs[25]*(2*params.E[1270])+rhs[26]*(2*params.E[1320])+rhs[27]*(2*params.E[1370])+rhs[28]*(2*params.E[1420])+rhs[29]*(2*params.E[1470])+rhs[30]*(2*params.E[1520])+rhs[31]*(2*params.E[1570])+rhs[32]*(2*params.E[1620])+rhs[33]*(2*params.E[1670])+rhs[34]*(2*params.E[1720])+rhs[35]*(2*params.E[1770])+rhs[36]*(2*params.E[1820])+rhs[37]*(2*params.E[1870])+rhs[38]*(2*params.E[1920])+rhs[39]*(2*params.E[1970])+rhs[40]*(2*params.E[2020])+rhs[41]*(2*params.E[2070])+rhs[42]*(2*params.E[2120])+rhs[43]*(2*params.E[2170])+rhs[44]*(2*params.E[2220])+rhs[45]*(2*params.E[2270])+rhs[46]*(2*params.E[2320])+rhs[47]*(2*params.E[2370])+rhs[48]*(2*params.E[2420])+rhs[49]*(2*params.E[2470]);
  lhs[21] = rhs[0]*(2*params.E[21])+rhs[1]*(2*params.E[71])+rhs[2]*(2*params.E[121])+rhs[3]*(2*params.E[171])+rhs[4]*(2*params.E[221])+rhs[5]*(2*params.E[271])+rhs[6]*(2*params.E[321])+rhs[7]*(2*params.E[371])+rhs[8]*(2*params.E[421])+rhs[9]*(2*params.E[471])+rhs[10]*(2*params.E[521])+rhs[11]*(2*params.E[571])+rhs[12]*(2*params.E[621])+rhs[13]*(2*params.E[671])+rhs[14]*(2*params.E[721])+rhs[15]*(2*params.E[771])+rhs[16]*(2*params.E[821])+rhs[17]*(2*params.E[871])+rhs[18]*(2*params.E[921])+rhs[19]*(2*params.E[971])+rhs[20]*(2*params.E[1021])+rhs[21]*(2*params.E[1071])+rhs[22]*(2*params.E[1121])+rhs[23]*(2*params.E[1171])+rhs[24]*(2*params.E[1221])+rhs[25]*(2*params.E[1271])+rhs[26]*(2*params.E[1321])+rhs[27]*(2*params.E[1371])+rhs[28]*(2*params.E[1421])+rhs[29]*(2*params.E[1471])+rhs[30]*(2*params.E[1521])+rhs[31]*(2*params.E[1571])+rhs[32]*(2*params.E[1621])+rhs[33]*(2*params.E[1671])+rhs[34]*(2*params.E[1721])+rhs[35]*(2*params.E[1771])+rhs[36]*(2*params.E[1821])+rhs[37]*(2*params.E[1871])+rhs[38]*(2*params.E[1921])+rhs[39]*(2*params.E[1971])+rhs[40]*(2*params.E[2021])+rhs[41]*(2*params.E[2071])+rhs[42]*(2*params.E[2121])+rhs[43]*(2*params.E[2171])+rhs[44]*(2*params.E[2221])+rhs[45]*(2*params.E[2271])+rhs[46]*(2*params.E[2321])+rhs[47]*(2*params.E[2371])+rhs[48]*(2*params.E[2421])+rhs[49]*(2*params.E[2471]);
  lhs[22] = rhs[0]*(2*params.E[22])+rhs[1]*(2*params.E[72])+rhs[2]*(2*params.E[122])+rhs[3]*(2*params.E[172])+rhs[4]*(2*params.E[222])+rhs[5]*(2*params.E[272])+rhs[6]*(2*params.E[322])+rhs[7]*(2*params.E[372])+rhs[8]*(2*params.E[422])+rhs[9]*(2*params.E[472])+rhs[10]*(2*params.E[522])+rhs[11]*(2*params.E[572])+rhs[12]*(2*params.E[622])+rhs[13]*(2*params.E[672])+rhs[14]*(2*params.E[722])+rhs[15]*(2*params.E[772])+rhs[16]*(2*params.E[822])+rhs[17]*(2*params.E[872])+rhs[18]*(2*params.E[922])+rhs[19]*(2*params.E[972])+rhs[20]*(2*params.E[1022])+rhs[21]*(2*params.E[1072])+rhs[22]*(2*params.E[1122])+rhs[23]*(2*params.E[1172])+rhs[24]*(2*params.E[1222])+rhs[25]*(2*params.E[1272])+rhs[26]*(2*params.E[1322])+rhs[27]*(2*params.E[1372])+rhs[28]*(2*params.E[1422])+rhs[29]*(2*params.E[1472])+rhs[30]*(2*params.E[1522])+rhs[31]*(2*params.E[1572])+rhs[32]*(2*params.E[1622])+rhs[33]*(2*params.E[1672])+rhs[34]*(2*params.E[1722])+rhs[35]*(2*params.E[1772])+rhs[36]*(2*params.E[1822])+rhs[37]*(2*params.E[1872])+rhs[38]*(2*params.E[1922])+rhs[39]*(2*params.E[1972])+rhs[40]*(2*params.E[2022])+rhs[41]*(2*params.E[2072])+rhs[42]*(2*params.E[2122])+rhs[43]*(2*params.E[2172])+rhs[44]*(2*params.E[2222])+rhs[45]*(2*params.E[2272])+rhs[46]*(2*params.E[2322])+rhs[47]*(2*params.E[2372])+rhs[48]*(2*params.E[2422])+rhs[49]*(2*params.E[2472]);
  lhs[23] = rhs[0]*(2*params.E[23])+rhs[1]*(2*params.E[73])+rhs[2]*(2*params.E[123])+rhs[3]*(2*params.E[173])+rhs[4]*(2*params.E[223])+rhs[5]*(2*params.E[273])+rhs[6]*(2*params.E[323])+rhs[7]*(2*params.E[373])+rhs[8]*(2*params.E[423])+rhs[9]*(2*params.E[473])+rhs[10]*(2*params.E[523])+rhs[11]*(2*params.E[573])+rhs[12]*(2*params.E[623])+rhs[13]*(2*params.E[673])+rhs[14]*(2*params.E[723])+rhs[15]*(2*params.E[773])+rhs[16]*(2*params.E[823])+rhs[17]*(2*params.E[873])+rhs[18]*(2*params.E[923])+rhs[19]*(2*params.E[973])+rhs[20]*(2*params.E[1023])+rhs[21]*(2*params.E[1073])+rhs[22]*(2*params.E[1123])+rhs[23]*(2*params.E[1173])+rhs[24]*(2*params.E[1223])+rhs[25]*(2*params.E[1273])+rhs[26]*(2*params.E[1323])+rhs[27]*(2*params.E[1373])+rhs[28]*(2*params.E[1423])+rhs[29]*(2*params.E[1473])+rhs[30]*(2*params.E[1523])+rhs[31]*(2*params.E[1573])+rhs[32]*(2*params.E[1623])+rhs[33]*(2*params.E[1673])+rhs[34]*(2*params.E[1723])+rhs[35]*(2*params.E[1773])+rhs[36]*(2*params.E[1823])+rhs[37]*(2*params.E[1873])+rhs[38]*(2*params.E[1923])+rhs[39]*(2*params.E[1973])+rhs[40]*(2*params.E[2023])+rhs[41]*(2*params.E[2073])+rhs[42]*(2*params.E[2123])+rhs[43]*(2*params.E[2173])+rhs[44]*(2*params.E[2223])+rhs[45]*(2*params.E[2273])+rhs[46]*(2*params.E[2323])+rhs[47]*(2*params.E[2373])+rhs[48]*(2*params.E[2423])+rhs[49]*(2*params.E[2473]);
  lhs[24] = rhs[0]*(2*params.E[24])+rhs[1]*(2*params.E[74])+rhs[2]*(2*params.E[124])+rhs[3]*(2*params.E[174])+rhs[4]*(2*params.E[224])+rhs[5]*(2*params.E[274])+rhs[6]*(2*params.E[324])+rhs[7]*(2*params.E[374])+rhs[8]*(2*params.E[424])+rhs[9]*(2*params.E[474])+rhs[10]*(2*params.E[524])+rhs[11]*(2*params.E[574])+rhs[12]*(2*params.E[624])+rhs[13]*(2*params.E[674])+rhs[14]*(2*params.E[724])+rhs[15]*(2*params.E[774])+rhs[16]*(2*params.E[824])+rhs[17]*(2*params.E[874])+rhs[18]*(2*params.E[924])+rhs[19]*(2*params.E[974])+rhs[20]*(2*params.E[1024])+rhs[21]*(2*params.E[1074])+rhs[22]*(2*params.E[1124])+rhs[23]*(2*params.E[1174])+rhs[24]*(2*params.E[1224])+rhs[25]*(2*params.E[1274])+rhs[26]*(2*params.E[1324])+rhs[27]*(2*params.E[1374])+rhs[28]*(2*params.E[1424])+rhs[29]*(2*params.E[1474])+rhs[30]*(2*params.E[1524])+rhs[31]*(2*params.E[1574])+rhs[32]*(2*params.E[1624])+rhs[33]*(2*params.E[1674])+rhs[34]*(2*params.E[1724])+rhs[35]*(2*params.E[1774])+rhs[36]*(2*params.E[1824])+rhs[37]*(2*params.E[1874])+rhs[38]*(2*params.E[1924])+rhs[39]*(2*params.E[1974])+rhs[40]*(2*params.E[2024])+rhs[41]*(2*params.E[2074])+rhs[42]*(2*params.E[2124])+rhs[43]*(2*params.E[2174])+rhs[44]*(2*params.E[2224])+rhs[45]*(2*params.E[2274])+rhs[46]*(2*params.E[2324])+rhs[47]*(2*params.E[2374])+rhs[48]*(2*params.E[2424])+rhs[49]*(2*params.E[2474]);
  lhs[25] = rhs[0]*(2*params.E[25])+rhs[1]*(2*params.E[75])+rhs[2]*(2*params.E[125])+rhs[3]*(2*params.E[175])+rhs[4]*(2*params.E[225])+rhs[5]*(2*params.E[275])+rhs[6]*(2*params.E[325])+rhs[7]*(2*params.E[375])+rhs[8]*(2*params.E[425])+rhs[9]*(2*params.E[475])+rhs[10]*(2*params.E[525])+rhs[11]*(2*params.E[575])+rhs[12]*(2*params.E[625])+rhs[13]*(2*params.E[675])+rhs[14]*(2*params.E[725])+rhs[15]*(2*params.E[775])+rhs[16]*(2*params.E[825])+rhs[17]*(2*params.E[875])+rhs[18]*(2*params.E[925])+rhs[19]*(2*params.E[975])+rhs[20]*(2*params.E[1025])+rhs[21]*(2*params.E[1075])+rhs[22]*(2*params.E[1125])+rhs[23]*(2*params.E[1175])+rhs[24]*(2*params.E[1225])+rhs[25]*(2*params.E[1275])+rhs[26]*(2*params.E[1325])+rhs[27]*(2*params.E[1375])+rhs[28]*(2*params.E[1425])+rhs[29]*(2*params.E[1475])+rhs[30]*(2*params.E[1525])+rhs[31]*(2*params.E[1575])+rhs[32]*(2*params.E[1625])+rhs[33]*(2*params.E[1675])+rhs[34]*(2*params.E[1725])+rhs[35]*(2*params.E[1775])+rhs[36]*(2*params.E[1825])+rhs[37]*(2*params.E[1875])+rhs[38]*(2*params.E[1925])+rhs[39]*(2*params.E[1975])+rhs[40]*(2*params.E[2025])+rhs[41]*(2*params.E[2075])+rhs[42]*(2*params.E[2125])+rhs[43]*(2*params.E[2175])+rhs[44]*(2*params.E[2225])+rhs[45]*(2*params.E[2275])+rhs[46]*(2*params.E[2325])+rhs[47]*(2*params.E[2375])+rhs[48]*(2*params.E[2425])+rhs[49]*(2*params.E[2475]);
  lhs[26] = rhs[0]*(2*params.E[26])+rhs[1]*(2*params.E[76])+rhs[2]*(2*params.E[126])+rhs[3]*(2*params.E[176])+rhs[4]*(2*params.E[226])+rhs[5]*(2*params.E[276])+rhs[6]*(2*params.E[326])+rhs[7]*(2*params.E[376])+rhs[8]*(2*params.E[426])+rhs[9]*(2*params.E[476])+rhs[10]*(2*params.E[526])+rhs[11]*(2*params.E[576])+rhs[12]*(2*params.E[626])+rhs[13]*(2*params.E[676])+rhs[14]*(2*params.E[726])+rhs[15]*(2*params.E[776])+rhs[16]*(2*params.E[826])+rhs[17]*(2*params.E[876])+rhs[18]*(2*params.E[926])+rhs[19]*(2*params.E[976])+rhs[20]*(2*params.E[1026])+rhs[21]*(2*params.E[1076])+rhs[22]*(2*params.E[1126])+rhs[23]*(2*params.E[1176])+rhs[24]*(2*params.E[1226])+rhs[25]*(2*params.E[1276])+rhs[26]*(2*params.E[1326])+rhs[27]*(2*params.E[1376])+rhs[28]*(2*params.E[1426])+rhs[29]*(2*params.E[1476])+rhs[30]*(2*params.E[1526])+rhs[31]*(2*params.E[1576])+rhs[32]*(2*params.E[1626])+rhs[33]*(2*params.E[1676])+rhs[34]*(2*params.E[1726])+rhs[35]*(2*params.E[1776])+rhs[36]*(2*params.E[1826])+rhs[37]*(2*params.E[1876])+rhs[38]*(2*params.E[1926])+rhs[39]*(2*params.E[1976])+rhs[40]*(2*params.E[2026])+rhs[41]*(2*params.E[2076])+rhs[42]*(2*params.E[2126])+rhs[43]*(2*params.E[2176])+rhs[44]*(2*params.E[2226])+rhs[45]*(2*params.E[2276])+rhs[46]*(2*params.E[2326])+rhs[47]*(2*params.E[2376])+rhs[48]*(2*params.E[2426])+rhs[49]*(2*params.E[2476]);
  lhs[27] = rhs[0]*(2*params.E[27])+rhs[1]*(2*params.E[77])+rhs[2]*(2*params.E[127])+rhs[3]*(2*params.E[177])+rhs[4]*(2*params.E[227])+rhs[5]*(2*params.E[277])+rhs[6]*(2*params.E[327])+rhs[7]*(2*params.E[377])+rhs[8]*(2*params.E[427])+rhs[9]*(2*params.E[477])+rhs[10]*(2*params.E[527])+rhs[11]*(2*params.E[577])+rhs[12]*(2*params.E[627])+rhs[13]*(2*params.E[677])+rhs[14]*(2*params.E[727])+rhs[15]*(2*params.E[777])+rhs[16]*(2*params.E[827])+rhs[17]*(2*params.E[877])+rhs[18]*(2*params.E[927])+rhs[19]*(2*params.E[977])+rhs[20]*(2*params.E[1027])+rhs[21]*(2*params.E[1077])+rhs[22]*(2*params.E[1127])+rhs[23]*(2*params.E[1177])+rhs[24]*(2*params.E[1227])+rhs[25]*(2*params.E[1277])+rhs[26]*(2*params.E[1327])+rhs[27]*(2*params.E[1377])+rhs[28]*(2*params.E[1427])+rhs[29]*(2*params.E[1477])+rhs[30]*(2*params.E[1527])+rhs[31]*(2*params.E[1577])+rhs[32]*(2*params.E[1627])+rhs[33]*(2*params.E[1677])+rhs[34]*(2*params.E[1727])+rhs[35]*(2*params.E[1777])+rhs[36]*(2*params.E[1827])+rhs[37]*(2*params.E[1877])+rhs[38]*(2*params.E[1927])+rhs[39]*(2*params.E[1977])+rhs[40]*(2*params.E[2027])+rhs[41]*(2*params.E[2077])+rhs[42]*(2*params.E[2127])+rhs[43]*(2*params.E[2177])+rhs[44]*(2*params.E[2227])+rhs[45]*(2*params.E[2277])+rhs[46]*(2*params.E[2327])+rhs[47]*(2*params.E[2377])+rhs[48]*(2*params.E[2427])+rhs[49]*(2*params.E[2477]);
  lhs[28] = rhs[0]*(2*params.E[28])+rhs[1]*(2*params.E[78])+rhs[2]*(2*params.E[128])+rhs[3]*(2*params.E[178])+rhs[4]*(2*params.E[228])+rhs[5]*(2*params.E[278])+rhs[6]*(2*params.E[328])+rhs[7]*(2*params.E[378])+rhs[8]*(2*params.E[428])+rhs[9]*(2*params.E[478])+rhs[10]*(2*params.E[528])+rhs[11]*(2*params.E[578])+rhs[12]*(2*params.E[628])+rhs[13]*(2*params.E[678])+rhs[14]*(2*params.E[728])+rhs[15]*(2*params.E[778])+rhs[16]*(2*params.E[828])+rhs[17]*(2*params.E[878])+rhs[18]*(2*params.E[928])+rhs[19]*(2*params.E[978])+rhs[20]*(2*params.E[1028])+rhs[21]*(2*params.E[1078])+rhs[22]*(2*params.E[1128])+rhs[23]*(2*params.E[1178])+rhs[24]*(2*params.E[1228])+rhs[25]*(2*params.E[1278])+rhs[26]*(2*params.E[1328])+rhs[27]*(2*params.E[1378])+rhs[28]*(2*params.E[1428])+rhs[29]*(2*params.E[1478])+rhs[30]*(2*params.E[1528])+rhs[31]*(2*params.E[1578])+rhs[32]*(2*params.E[1628])+rhs[33]*(2*params.E[1678])+rhs[34]*(2*params.E[1728])+rhs[35]*(2*params.E[1778])+rhs[36]*(2*params.E[1828])+rhs[37]*(2*params.E[1878])+rhs[38]*(2*params.E[1928])+rhs[39]*(2*params.E[1978])+rhs[40]*(2*params.E[2028])+rhs[41]*(2*params.E[2078])+rhs[42]*(2*params.E[2128])+rhs[43]*(2*params.E[2178])+rhs[44]*(2*params.E[2228])+rhs[45]*(2*params.E[2278])+rhs[46]*(2*params.E[2328])+rhs[47]*(2*params.E[2378])+rhs[48]*(2*params.E[2428])+rhs[49]*(2*params.E[2478]);
  lhs[29] = rhs[0]*(2*params.E[29])+rhs[1]*(2*params.E[79])+rhs[2]*(2*params.E[129])+rhs[3]*(2*params.E[179])+rhs[4]*(2*params.E[229])+rhs[5]*(2*params.E[279])+rhs[6]*(2*params.E[329])+rhs[7]*(2*params.E[379])+rhs[8]*(2*params.E[429])+rhs[9]*(2*params.E[479])+rhs[10]*(2*params.E[529])+rhs[11]*(2*params.E[579])+rhs[12]*(2*params.E[629])+rhs[13]*(2*params.E[679])+rhs[14]*(2*params.E[729])+rhs[15]*(2*params.E[779])+rhs[16]*(2*params.E[829])+rhs[17]*(2*params.E[879])+rhs[18]*(2*params.E[929])+rhs[19]*(2*params.E[979])+rhs[20]*(2*params.E[1029])+rhs[21]*(2*params.E[1079])+rhs[22]*(2*params.E[1129])+rhs[23]*(2*params.E[1179])+rhs[24]*(2*params.E[1229])+rhs[25]*(2*params.E[1279])+rhs[26]*(2*params.E[1329])+rhs[27]*(2*params.E[1379])+rhs[28]*(2*params.E[1429])+rhs[29]*(2*params.E[1479])+rhs[30]*(2*params.E[1529])+rhs[31]*(2*params.E[1579])+rhs[32]*(2*params.E[1629])+rhs[33]*(2*params.E[1679])+rhs[34]*(2*params.E[1729])+rhs[35]*(2*params.E[1779])+rhs[36]*(2*params.E[1829])+rhs[37]*(2*params.E[1879])+rhs[38]*(2*params.E[1929])+rhs[39]*(2*params.E[1979])+rhs[40]*(2*params.E[2029])+rhs[41]*(2*params.E[2079])+rhs[42]*(2*params.E[2129])+rhs[43]*(2*params.E[2179])+rhs[44]*(2*params.E[2229])+rhs[45]*(2*params.E[2279])+rhs[46]*(2*params.E[2329])+rhs[47]*(2*params.E[2379])+rhs[48]*(2*params.E[2429])+rhs[49]*(2*params.E[2479]);
  lhs[30] = rhs[0]*(2*params.E[30])+rhs[1]*(2*params.E[80])+rhs[2]*(2*params.E[130])+rhs[3]*(2*params.E[180])+rhs[4]*(2*params.E[230])+rhs[5]*(2*params.E[280])+rhs[6]*(2*params.E[330])+rhs[7]*(2*params.E[380])+rhs[8]*(2*params.E[430])+rhs[9]*(2*params.E[480])+rhs[10]*(2*params.E[530])+rhs[11]*(2*params.E[580])+rhs[12]*(2*params.E[630])+rhs[13]*(2*params.E[680])+rhs[14]*(2*params.E[730])+rhs[15]*(2*params.E[780])+rhs[16]*(2*params.E[830])+rhs[17]*(2*params.E[880])+rhs[18]*(2*params.E[930])+rhs[19]*(2*params.E[980])+rhs[20]*(2*params.E[1030])+rhs[21]*(2*params.E[1080])+rhs[22]*(2*params.E[1130])+rhs[23]*(2*params.E[1180])+rhs[24]*(2*params.E[1230])+rhs[25]*(2*params.E[1280])+rhs[26]*(2*params.E[1330])+rhs[27]*(2*params.E[1380])+rhs[28]*(2*params.E[1430])+rhs[29]*(2*params.E[1480])+rhs[30]*(2*params.E[1530])+rhs[31]*(2*params.E[1580])+rhs[32]*(2*params.E[1630])+rhs[33]*(2*params.E[1680])+rhs[34]*(2*params.E[1730])+rhs[35]*(2*params.E[1780])+rhs[36]*(2*params.E[1830])+rhs[37]*(2*params.E[1880])+rhs[38]*(2*params.E[1930])+rhs[39]*(2*params.E[1980])+rhs[40]*(2*params.E[2030])+rhs[41]*(2*params.E[2080])+rhs[42]*(2*params.E[2130])+rhs[43]*(2*params.E[2180])+rhs[44]*(2*params.E[2230])+rhs[45]*(2*params.E[2280])+rhs[46]*(2*params.E[2330])+rhs[47]*(2*params.E[2380])+rhs[48]*(2*params.E[2430])+rhs[49]*(2*params.E[2480]);
  lhs[31] = rhs[0]*(2*params.E[31])+rhs[1]*(2*params.E[81])+rhs[2]*(2*params.E[131])+rhs[3]*(2*params.E[181])+rhs[4]*(2*params.E[231])+rhs[5]*(2*params.E[281])+rhs[6]*(2*params.E[331])+rhs[7]*(2*params.E[381])+rhs[8]*(2*params.E[431])+rhs[9]*(2*params.E[481])+rhs[10]*(2*params.E[531])+rhs[11]*(2*params.E[581])+rhs[12]*(2*params.E[631])+rhs[13]*(2*params.E[681])+rhs[14]*(2*params.E[731])+rhs[15]*(2*params.E[781])+rhs[16]*(2*params.E[831])+rhs[17]*(2*params.E[881])+rhs[18]*(2*params.E[931])+rhs[19]*(2*params.E[981])+rhs[20]*(2*params.E[1031])+rhs[21]*(2*params.E[1081])+rhs[22]*(2*params.E[1131])+rhs[23]*(2*params.E[1181])+rhs[24]*(2*params.E[1231])+rhs[25]*(2*params.E[1281])+rhs[26]*(2*params.E[1331])+rhs[27]*(2*params.E[1381])+rhs[28]*(2*params.E[1431])+rhs[29]*(2*params.E[1481])+rhs[30]*(2*params.E[1531])+rhs[31]*(2*params.E[1581])+rhs[32]*(2*params.E[1631])+rhs[33]*(2*params.E[1681])+rhs[34]*(2*params.E[1731])+rhs[35]*(2*params.E[1781])+rhs[36]*(2*params.E[1831])+rhs[37]*(2*params.E[1881])+rhs[38]*(2*params.E[1931])+rhs[39]*(2*params.E[1981])+rhs[40]*(2*params.E[2031])+rhs[41]*(2*params.E[2081])+rhs[42]*(2*params.E[2131])+rhs[43]*(2*params.E[2181])+rhs[44]*(2*params.E[2231])+rhs[45]*(2*params.E[2281])+rhs[46]*(2*params.E[2331])+rhs[47]*(2*params.E[2381])+rhs[48]*(2*params.E[2431])+rhs[49]*(2*params.E[2481]);
  lhs[32] = rhs[0]*(2*params.E[32])+rhs[1]*(2*params.E[82])+rhs[2]*(2*params.E[132])+rhs[3]*(2*params.E[182])+rhs[4]*(2*params.E[232])+rhs[5]*(2*params.E[282])+rhs[6]*(2*params.E[332])+rhs[7]*(2*params.E[382])+rhs[8]*(2*params.E[432])+rhs[9]*(2*params.E[482])+rhs[10]*(2*params.E[532])+rhs[11]*(2*params.E[582])+rhs[12]*(2*params.E[632])+rhs[13]*(2*params.E[682])+rhs[14]*(2*params.E[732])+rhs[15]*(2*params.E[782])+rhs[16]*(2*params.E[832])+rhs[17]*(2*params.E[882])+rhs[18]*(2*params.E[932])+rhs[19]*(2*params.E[982])+rhs[20]*(2*params.E[1032])+rhs[21]*(2*params.E[1082])+rhs[22]*(2*params.E[1132])+rhs[23]*(2*params.E[1182])+rhs[24]*(2*params.E[1232])+rhs[25]*(2*params.E[1282])+rhs[26]*(2*params.E[1332])+rhs[27]*(2*params.E[1382])+rhs[28]*(2*params.E[1432])+rhs[29]*(2*params.E[1482])+rhs[30]*(2*params.E[1532])+rhs[31]*(2*params.E[1582])+rhs[32]*(2*params.E[1632])+rhs[33]*(2*params.E[1682])+rhs[34]*(2*params.E[1732])+rhs[35]*(2*params.E[1782])+rhs[36]*(2*params.E[1832])+rhs[37]*(2*params.E[1882])+rhs[38]*(2*params.E[1932])+rhs[39]*(2*params.E[1982])+rhs[40]*(2*params.E[2032])+rhs[41]*(2*params.E[2082])+rhs[42]*(2*params.E[2132])+rhs[43]*(2*params.E[2182])+rhs[44]*(2*params.E[2232])+rhs[45]*(2*params.E[2282])+rhs[46]*(2*params.E[2332])+rhs[47]*(2*params.E[2382])+rhs[48]*(2*params.E[2432])+rhs[49]*(2*params.E[2482]);
  lhs[33] = rhs[0]*(2*params.E[33])+rhs[1]*(2*params.E[83])+rhs[2]*(2*params.E[133])+rhs[3]*(2*params.E[183])+rhs[4]*(2*params.E[233])+rhs[5]*(2*params.E[283])+rhs[6]*(2*params.E[333])+rhs[7]*(2*params.E[383])+rhs[8]*(2*params.E[433])+rhs[9]*(2*params.E[483])+rhs[10]*(2*params.E[533])+rhs[11]*(2*params.E[583])+rhs[12]*(2*params.E[633])+rhs[13]*(2*params.E[683])+rhs[14]*(2*params.E[733])+rhs[15]*(2*params.E[783])+rhs[16]*(2*params.E[833])+rhs[17]*(2*params.E[883])+rhs[18]*(2*params.E[933])+rhs[19]*(2*params.E[983])+rhs[20]*(2*params.E[1033])+rhs[21]*(2*params.E[1083])+rhs[22]*(2*params.E[1133])+rhs[23]*(2*params.E[1183])+rhs[24]*(2*params.E[1233])+rhs[25]*(2*params.E[1283])+rhs[26]*(2*params.E[1333])+rhs[27]*(2*params.E[1383])+rhs[28]*(2*params.E[1433])+rhs[29]*(2*params.E[1483])+rhs[30]*(2*params.E[1533])+rhs[31]*(2*params.E[1583])+rhs[32]*(2*params.E[1633])+rhs[33]*(2*params.E[1683])+rhs[34]*(2*params.E[1733])+rhs[35]*(2*params.E[1783])+rhs[36]*(2*params.E[1833])+rhs[37]*(2*params.E[1883])+rhs[38]*(2*params.E[1933])+rhs[39]*(2*params.E[1983])+rhs[40]*(2*params.E[2033])+rhs[41]*(2*params.E[2083])+rhs[42]*(2*params.E[2133])+rhs[43]*(2*params.E[2183])+rhs[44]*(2*params.E[2233])+rhs[45]*(2*params.E[2283])+rhs[46]*(2*params.E[2333])+rhs[47]*(2*params.E[2383])+rhs[48]*(2*params.E[2433])+rhs[49]*(2*params.E[2483]);
  lhs[34] = rhs[0]*(2*params.E[34])+rhs[1]*(2*params.E[84])+rhs[2]*(2*params.E[134])+rhs[3]*(2*params.E[184])+rhs[4]*(2*params.E[234])+rhs[5]*(2*params.E[284])+rhs[6]*(2*params.E[334])+rhs[7]*(2*params.E[384])+rhs[8]*(2*params.E[434])+rhs[9]*(2*params.E[484])+rhs[10]*(2*params.E[534])+rhs[11]*(2*params.E[584])+rhs[12]*(2*params.E[634])+rhs[13]*(2*params.E[684])+rhs[14]*(2*params.E[734])+rhs[15]*(2*params.E[784])+rhs[16]*(2*params.E[834])+rhs[17]*(2*params.E[884])+rhs[18]*(2*params.E[934])+rhs[19]*(2*params.E[984])+rhs[20]*(2*params.E[1034])+rhs[21]*(2*params.E[1084])+rhs[22]*(2*params.E[1134])+rhs[23]*(2*params.E[1184])+rhs[24]*(2*params.E[1234])+rhs[25]*(2*params.E[1284])+rhs[26]*(2*params.E[1334])+rhs[27]*(2*params.E[1384])+rhs[28]*(2*params.E[1434])+rhs[29]*(2*params.E[1484])+rhs[30]*(2*params.E[1534])+rhs[31]*(2*params.E[1584])+rhs[32]*(2*params.E[1634])+rhs[33]*(2*params.E[1684])+rhs[34]*(2*params.E[1734])+rhs[35]*(2*params.E[1784])+rhs[36]*(2*params.E[1834])+rhs[37]*(2*params.E[1884])+rhs[38]*(2*params.E[1934])+rhs[39]*(2*params.E[1984])+rhs[40]*(2*params.E[2034])+rhs[41]*(2*params.E[2084])+rhs[42]*(2*params.E[2134])+rhs[43]*(2*params.E[2184])+rhs[44]*(2*params.E[2234])+rhs[45]*(2*params.E[2284])+rhs[46]*(2*params.E[2334])+rhs[47]*(2*params.E[2384])+rhs[48]*(2*params.E[2434])+rhs[49]*(2*params.E[2484]);
  lhs[35] = rhs[0]*(2*params.E[35])+rhs[1]*(2*params.E[85])+rhs[2]*(2*params.E[135])+rhs[3]*(2*params.E[185])+rhs[4]*(2*params.E[235])+rhs[5]*(2*params.E[285])+rhs[6]*(2*params.E[335])+rhs[7]*(2*params.E[385])+rhs[8]*(2*params.E[435])+rhs[9]*(2*params.E[485])+rhs[10]*(2*params.E[535])+rhs[11]*(2*params.E[585])+rhs[12]*(2*params.E[635])+rhs[13]*(2*params.E[685])+rhs[14]*(2*params.E[735])+rhs[15]*(2*params.E[785])+rhs[16]*(2*params.E[835])+rhs[17]*(2*params.E[885])+rhs[18]*(2*params.E[935])+rhs[19]*(2*params.E[985])+rhs[20]*(2*params.E[1035])+rhs[21]*(2*params.E[1085])+rhs[22]*(2*params.E[1135])+rhs[23]*(2*params.E[1185])+rhs[24]*(2*params.E[1235])+rhs[25]*(2*params.E[1285])+rhs[26]*(2*params.E[1335])+rhs[27]*(2*params.E[1385])+rhs[28]*(2*params.E[1435])+rhs[29]*(2*params.E[1485])+rhs[30]*(2*params.E[1535])+rhs[31]*(2*params.E[1585])+rhs[32]*(2*params.E[1635])+rhs[33]*(2*params.E[1685])+rhs[34]*(2*params.E[1735])+rhs[35]*(2*params.E[1785])+rhs[36]*(2*params.E[1835])+rhs[37]*(2*params.E[1885])+rhs[38]*(2*params.E[1935])+rhs[39]*(2*params.E[1985])+rhs[40]*(2*params.E[2035])+rhs[41]*(2*params.E[2085])+rhs[42]*(2*params.E[2135])+rhs[43]*(2*params.E[2185])+rhs[44]*(2*params.E[2235])+rhs[45]*(2*params.E[2285])+rhs[46]*(2*params.E[2335])+rhs[47]*(2*params.E[2385])+rhs[48]*(2*params.E[2435])+rhs[49]*(2*params.E[2485]);
  lhs[36] = rhs[0]*(2*params.E[36])+rhs[1]*(2*params.E[86])+rhs[2]*(2*params.E[136])+rhs[3]*(2*params.E[186])+rhs[4]*(2*params.E[236])+rhs[5]*(2*params.E[286])+rhs[6]*(2*params.E[336])+rhs[7]*(2*params.E[386])+rhs[8]*(2*params.E[436])+rhs[9]*(2*params.E[486])+rhs[10]*(2*params.E[536])+rhs[11]*(2*params.E[586])+rhs[12]*(2*params.E[636])+rhs[13]*(2*params.E[686])+rhs[14]*(2*params.E[736])+rhs[15]*(2*params.E[786])+rhs[16]*(2*params.E[836])+rhs[17]*(2*params.E[886])+rhs[18]*(2*params.E[936])+rhs[19]*(2*params.E[986])+rhs[20]*(2*params.E[1036])+rhs[21]*(2*params.E[1086])+rhs[22]*(2*params.E[1136])+rhs[23]*(2*params.E[1186])+rhs[24]*(2*params.E[1236])+rhs[25]*(2*params.E[1286])+rhs[26]*(2*params.E[1336])+rhs[27]*(2*params.E[1386])+rhs[28]*(2*params.E[1436])+rhs[29]*(2*params.E[1486])+rhs[30]*(2*params.E[1536])+rhs[31]*(2*params.E[1586])+rhs[32]*(2*params.E[1636])+rhs[33]*(2*params.E[1686])+rhs[34]*(2*params.E[1736])+rhs[35]*(2*params.E[1786])+rhs[36]*(2*params.E[1836])+rhs[37]*(2*params.E[1886])+rhs[38]*(2*params.E[1936])+rhs[39]*(2*params.E[1986])+rhs[40]*(2*params.E[2036])+rhs[41]*(2*params.E[2086])+rhs[42]*(2*params.E[2136])+rhs[43]*(2*params.E[2186])+rhs[44]*(2*params.E[2236])+rhs[45]*(2*params.E[2286])+rhs[46]*(2*params.E[2336])+rhs[47]*(2*params.E[2386])+rhs[48]*(2*params.E[2436])+rhs[49]*(2*params.E[2486]);
  lhs[37] = rhs[0]*(2*params.E[37])+rhs[1]*(2*params.E[87])+rhs[2]*(2*params.E[137])+rhs[3]*(2*params.E[187])+rhs[4]*(2*params.E[237])+rhs[5]*(2*params.E[287])+rhs[6]*(2*params.E[337])+rhs[7]*(2*params.E[387])+rhs[8]*(2*params.E[437])+rhs[9]*(2*params.E[487])+rhs[10]*(2*params.E[537])+rhs[11]*(2*params.E[587])+rhs[12]*(2*params.E[637])+rhs[13]*(2*params.E[687])+rhs[14]*(2*params.E[737])+rhs[15]*(2*params.E[787])+rhs[16]*(2*params.E[837])+rhs[17]*(2*params.E[887])+rhs[18]*(2*params.E[937])+rhs[19]*(2*params.E[987])+rhs[20]*(2*params.E[1037])+rhs[21]*(2*params.E[1087])+rhs[22]*(2*params.E[1137])+rhs[23]*(2*params.E[1187])+rhs[24]*(2*params.E[1237])+rhs[25]*(2*params.E[1287])+rhs[26]*(2*params.E[1337])+rhs[27]*(2*params.E[1387])+rhs[28]*(2*params.E[1437])+rhs[29]*(2*params.E[1487])+rhs[30]*(2*params.E[1537])+rhs[31]*(2*params.E[1587])+rhs[32]*(2*params.E[1637])+rhs[33]*(2*params.E[1687])+rhs[34]*(2*params.E[1737])+rhs[35]*(2*params.E[1787])+rhs[36]*(2*params.E[1837])+rhs[37]*(2*params.E[1887])+rhs[38]*(2*params.E[1937])+rhs[39]*(2*params.E[1987])+rhs[40]*(2*params.E[2037])+rhs[41]*(2*params.E[2087])+rhs[42]*(2*params.E[2137])+rhs[43]*(2*params.E[2187])+rhs[44]*(2*params.E[2237])+rhs[45]*(2*params.E[2287])+rhs[46]*(2*params.E[2337])+rhs[47]*(2*params.E[2387])+rhs[48]*(2*params.E[2437])+rhs[49]*(2*params.E[2487]);
  lhs[38] = rhs[0]*(2*params.E[38])+rhs[1]*(2*params.E[88])+rhs[2]*(2*params.E[138])+rhs[3]*(2*params.E[188])+rhs[4]*(2*params.E[238])+rhs[5]*(2*params.E[288])+rhs[6]*(2*params.E[338])+rhs[7]*(2*params.E[388])+rhs[8]*(2*params.E[438])+rhs[9]*(2*params.E[488])+rhs[10]*(2*params.E[538])+rhs[11]*(2*params.E[588])+rhs[12]*(2*params.E[638])+rhs[13]*(2*params.E[688])+rhs[14]*(2*params.E[738])+rhs[15]*(2*params.E[788])+rhs[16]*(2*params.E[838])+rhs[17]*(2*params.E[888])+rhs[18]*(2*params.E[938])+rhs[19]*(2*params.E[988])+rhs[20]*(2*params.E[1038])+rhs[21]*(2*params.E[1088])+rhs[22]*(2*params.E[1138])+rhs[23]*(2*params.E[1188])+rhs[24]*(2*params.E[1238])+rhs[25]*(2*params.E[1288])+rhs[26]*(2*params.E[1338])+rhs[27]*(2*params.E[1388])+rhs[28]*(2*params.E[1438])+rhs[29]*(2*params.E[1488])+rhs[30]*(2*params.E[1538])+rhs[31]*(2*params.E[1588])+rhs[32]*(2*params.E[1638])+rhs[33]*(2*params.E[1688])+rhs[34]*(2*params.E[1738])+rhs[35]*(2*params.E[1788])+rhs[36]*(2*params.E[1838])+rhs[37]*(2*params.E[1888])+rhs[38]*(2*params.E[1938])+rhs[39]*(2*params.E[1988])+rhs[40]*(2*params.E[2038])+rhs[41]*(2*params.E[2088])+rhs[42]*(2*params.E[2138])+rhs[43]*(2*params.E[2188])+rhs[44]*(2*params.E[2238])+rhs[45]*(2*params.E[2288])+rhs[46]*(2*params.E[2338])+rhs[47]*(2*params.E[2388])+rhs[48]*(2*params.E[2438])+rhs[49]*(2*params.E[2488]);
  lhs[39] = rhs[0]*(2*params.E[39])+rhs[1]*(2*params.E[89])+rhs[2]*(2*params.E[139])+rhs[3]*(2*params.E[189])+rhs[4]*(2*params.E[239])+rhs[5]*(2*params.E[289])+rhs[6]*(2*params.E[339])+rhs[7]*(2*params.E[389])+rhs[8]*(2*params.E[439])+rhs[9]*(2*params.E[489])+rhs[10]*(2*params.E[539])+rhs[11]*(2*params.E[589])+rhs[12]*(2*params.E[639])+rhs[13]*(2*params.E[689])+rhs[14]*(2*params.E[739])+rhs[15]*(2*params.E[789])+rhs[16]*(2*params.E[839])+rhs[17]*(2*params.E[889])+rhs[18]*(2*params.E[939])+rhs[19]*(2*params.E[989])+rhs[20]*(2*params.E[1039])+rhs[21]*(2*params.E[1089])+rhs[22]*(2*params.E[1139])+rhs[23]*(2*params.E[1189])+rhs[24]*(2*params.E[1239])+rhs[25]*(2*params.E[1289])+rhs[26]*(2*params.E[1339])+rhs[27]*(2*params.E[1389])+rhs[28]*(2*params.E[1439])+rhs[29]*(2*params.E[1489])+rhs[30]*(2*params.E[1539])+rhs[31]*(2*params.E[1589])+rhs[32]*(2*params.E[1639])+rhs[33]*(2*params.E[1689])+rhs[34]*(2*params.E[1739])+rhs[35]*(2*params.E[1789])+rhs[36]*(2*params.E[1839])+rhs[37]*(2*params.E[1889])+rhs[38]*(2*params.E[1939])+rhs[39]*(2*params.E[1989])+rhs[40]*(2*params.E[2039])+rhs[41]*(2*params.E[2089])+rhs[42]*(2*params.E[2139])+rhs[43]*(2*params.E[2189])+rhs[44]*(2*params.E[2239])+rhs[45]*(2*params.E[2289])+rhs[46]*(2*params.E[2339])+rhs[47]*(2*params.E[2389])+rhs[48]*(2*params.E[2439])+rhs[49]*(2*params.E[2489]);
  lhs[40] = rhs[0]*(2*params.E[40])+rhs[1]*(2*params.E[90])+rhs[2]*(2*params.E[140])+rhs[3]*(2*params.E[190])+rhs[4]*(2*params.E[240])+rhs[5]*(2*params.E[290])+rhs[6]*(2*params.E[340])+rhs[7]*(2*params.E[390])+rhs[8]*(2*params.E[440])+rhs[9]*(2*params.E[490])+rhs[10]*(2*params.E[540])+rhs[11]*(2*params.E[590])+rhs[12]*(2*params.E[640])+rhs[13]*(2*params.E[690])+rhs[14]*(2*params.E[740])+rhs[15]*(2*params.E[790])+rhs[16]*(2*params.E[840])+rhs[17]*(2*params.E[890])+rhs[18]*(2*params.E[940])+rhs[19]*(2*params.E[990])+rhs[20]*(2*params.E[1040])+rhs[21]*(2*params.E[1090])+rhs[22]*(2*params.E[1140])+rhs[23]*(2*params.E[1190])+rhs[24]*(2*params.E[1240])+rhs[25]*(2*params.E[1290])+rhs[26]*(2*params.E[1340])+rhs[27]*(2*params.E[1390])+rhs[28]*(2*params.E[1440])+rhs[29]*(2*params.E[1490])+rhs[30]*(2*params.E[1540])+rhs[31]*(2*params.E[1590])+rhs[32]*(2*params.E[1640])+rhs[33]*(2*params.E[1690])+rhs[34]*(2*params.E[1740])+rhs[35]*(2*params.E[1790])+rhs[36]*(2*params.E[1840])+rhs[37]*(2*params.E[1890])+rhs[38]*(2*params.E[1940])+rhs[39]*(2*params.E[1990])+rhs[40]*(2*params.E[2040])+rhs[41]*(2*params.E[2090])+rhs[42]*(2*params.E[2140])+rhs[43]*(2*params.E[2190])+rhs[44]*(2*params.E[2240])+rhs[45]*(2*params.E[2290])+rhs[46]*(2*params.E[2340])+rhs[47]*(2*params.E[2390])+rhs[48]*(2*params.E[2440])+rhs[49]*(2*params.E[2490]);
  lhs[41] = rhs[0]*(2*params.E[41])+rhs[1]*(2*params.E[91])+rhs[2]*(2*params.E[141])+rhs[3]*(2*params.E[191])+rhs[4]*(2*params.E[241])+rhs[5]*(2*params.E[291])+rhs[6]*(2*params.E[341])+rhs[7]*(2*params.E[391])+rhs[8]*(2*params.E[441])+rhs[9]*(2*params.E[491])+rhs[10]*(2*params.E[541])+rhs[11]*(2*params.E[591])+rhs[12]*(2*params.E[641])+rhs[13]*(2*params.E[691])+rhs[14]*(2*params.E[741])+rhs[15]*(2*params.E[791])+rhs[16]*(2*params.E[841])+rhs[17]*(2*params.E[891])+rhs[18]*(2*params.E[941])+rhs[19]*(2*params.E[991])+rhs[20]*(2*params.E[1041])+rhs[21]*(2*params.E[1091])+rhs[22]*(2*params.E[1141])+rhs[23]*(2*params.E[1191])+rhs[24]*(2*params.E[1241])+rhs[25]*(2*params.E[1291])+rhs[26]*(2*params.E[1341])+rhs[27]*(2*params.E[1391])+rhs[28]*(2*params.E[1441])+rhs[29]*(2*params.E[1491])+rhs[30]*(2*params.E[1541])+rhs[31]*(2*params.E[1591])+rhs[32]*(2*params.E[1641])+rhs[33]*(2*params.E[1691])+rhs[34]*(2*params.E[1741])+rhs[35]*(2*params.E[1791])+rhs[36]*(2*params.E[1841])+rhs[37]*(2*params.E[1891])+rhs[38]*(2*params.E[1941])+rhs[39]*(2*params.E[1991])+rhs[40]*(2*params.E[2041])+rhs[41]*(2*params.E[2091])+rhs[42]*(2*params.E[2141])+rhs[43]*(2*params.E[2191])+rhs[44]*(2*params.E[2241])+rhs[45]*(2*params.E[2291])+rhs[46]*(2*params.E[2341])+rhs[47]*(2*params.E[2391])+rhs[48]*(2*params.E[2441])+rhs[49]*(2*params.E[2491]);
  lhs[42] = rhs[0]*(2*params.E[42])+rhs[1]*(2*params.E[92])+rhs[2]*(2*params.E[142])+rhs[3]*(2*params.E[192])+rhs[4]*(2*params.E[242])+rhs[5]*(2*params.E[292])+rhs[6]*(2*params.E[342])+rhs[7]*(2*params.E[392])+rhs[8]*(2*params.E[442])+rhs[9]*(2*params.E[492])+rhs[10]*(2*params.E[542])+rhs[11]*(2*params.E[592])+rhs[12]*(2*params.E[642])+rhs[13]*(2*params.E[692])+rhs[14]*(2*params.E[742])+rhs[15]*(2*params.E[792])+rhs[16]*(2*params.E[842])+rhs[17]*(2*params.E[892])+rhs[18]*(2*params.E[942])+rhs[19]*(2*params.E[992])+rhs[20]*(2*params.E[1042])+rhs[21]*(2*params.E[1092])+rhs[22]*(2*params.E[1142])+rhs[23]*(2*params.E[1192])+rhs[24]*(2*params.E[1242])+rhs[25]*(2*params.E[1292])+rhs[26]*(2*params.E[1342])+rhs[27]*(2*params.E[1392])+rhs[28]*(2*params.E[1442])+rhs[29]*(2*params.E[1492])+rhs[30]*(2*params.E[1542])+rhs[31]*(2*params.E[1592])+rhs[32]*(2*params.E[1642])+rhs[33]*(2*params.E[1692])+rhs[34]*(2*params.E[1742])+rhs[35]*(2*params.E[1792])+rhs[36]*(2*params.E[1842])+rhs[37]*(2*params.E[1892])+rhs[38]*(2*params.E[1942])+rhs[39]*(2*params.E[1992])+rhs[40]*(2*params.E[2042])+rhs[41]*(2*params.E[2092])+rhs[42]*(2*params.E[2142])+rhs[43]*(2*params.E[2192])+rhs[44]*(2*params.E[2242])+rhs[45]*(2*params.E[2292])+rhs[46]*(2*params.E[2342])+rhs[47]*(2*params.E[2392])+rhs[48]*(2*params.E[2442])+rhs[49]*(2*params.E[2492]);
  lhs[43] = rhs[0]*(2*params.E[43])+rhs[1]*(2*params.E[93])+rhs[2]*(2*params.E[143])+rhs[3]*(2*params.E[193])+rhs[4]*(2*params.E[243])+rhs[5]*(2*params.E[293])+rhs[6]*(2*params.E[343])+rhs[7]*(2*params.E[393])+rhs[8]*(2*params.E[443])+rhs[9]*(2*params.E[493])+rhs[10]*(2*params.E[543])+rhs[11]*(2*params.E[593])+rhs[12]*(2*params.E[643])+rhs[13]*(2*params.E[693])+rhs[14]*(2*params.E[743])+rhs[15]*(2*params.E[793])+rhs[16]*(2*params.E[843])+rhs[17]*(2*params.E[893])+rhs[18]*(2*params.E[943])+rhs[19]*(2*params.E[993])+rhs[20]*(2*params.E[1043])+rhs[21]*(2*params.E[1093])+rhs[22]*(2*params.E[1143])+rhs[23]*(2*params.E[1193])+rhs[24]*(2*params.E[1243])+rhs[25]*(2*params.E[1293])+rhs[26]*(2*params.E[1343])+rhs[27]*(2*params.E[1393])+rhs[28]*(2*params.E[1443])+rhs[29]*(2*params.E[1493])+rhs[30]*(2*params.E[1543])+rhs[31]*(2*params.E[1593])+rhs[32]*(2*params.E[1643])+rhs[33]*(2*params.E[1693])+rhs[34]*(2*params.E[1743])+rhs[35]*(2*params.E[1793])+rhs[36]*(2*params.E[1843])+rhs[37]*(2*params.E[1893])+rhs[38]*(2*params.E[1943])+rhs[39]*(2*params.E[1993])+rhs[40]*(2*params.E[2043])+rhs[41]*(2*params.E[2093])+rhs[42]*(2*params.E[2143])+rhs[43]*(2*params.E[2193])+rhs[44]*(2*params.E[2243])+rhs[45]*(2*params.E[2293])+rhs[46]*(2*params.E[2343])+rhs[47]*(2*params.E[2393])+rhs[48]*(2*params.E[2443])+rhs[49]*(2*params.E[2493]);
  lhs[44] = rhs[0]*(2*params.E[44])+rhs[1]*(2*params.E[94])+rhs[2]*(2*params.E[144])+rhs[3]*(2*params.E[194])+rhs[4]*(2*params.E[244])+rhs[5]*(2*params.E[294])+rhs[6]*(2*params.E[344])+rhs[7]*(2*params.E[394])+rhs[8]*(2*params.E[444])+rhs[9]*(2*params.E[494])+rhs[10]*(2*params.E[544])+rhs[11]*(2*params.E[594])+rhs[12]*(2*params.E[644])+rhs[13]*(2*params.E[694])+rhs[14]*(2*params.E[744])+rhs[15]*(2*params.E[794])+rhs[16]*(2*params.E[844])+rhs[17]*(2*params.E[894])+rhs[18]*(2*params.E[944])+rhs[19]*(2*params.E[994])+rhs[20]*(2*params.E[1044])+rhs[21]*(2*params.E[1094])+rhs[22]*(2*params.E[1144])+rhs[23]*(2*params.E[1194])+rhs[24]*(2*params.E[1244])+rhs[25]*(2*params.E[1294])+rhs[26]*(2*params.E[1344])+rhs[27]*(2*params.E[1394])+rhs[28]*(2*params.E[1444])+rhs[29]*(2*params.E[1494])+rhs[30]*(2*params.E[1544])+rhs[31]*(2*params.E[1594])+rhs[32]*(2*params.E[1644])+rhs[33]*(2*params.E[1694])+rhs[34]*(2*params.E[1744])+rhs[35]*(2*params.E[1794])+rhs[36]*(2*params.E[1844])+rhs[37]*(2*params.E[1894])+rhs[38]*(2*params.E[1944])+rhs[39]*(2*params.E[1994])+rhs[40]*(2*params.E[2044])+rhs[41]*(2*params.E[2094])+rhs[42]*(2*params.E[2144])+rhs[43]*(2*params.E[2194])+rhs[44]*(2*params.E[2244])+rhs[45]*(2*params.E[2294])+rhs[46]*(2*params.E[2344])+rhs[47]*(2*params.E[2394])+rhs[48]*(2*params.E[2444])+rhs[49]*(2*params.E[2494]);
  lhs[45] = rhs[0]*(2*params.E[45])+rhs[1]*(2*params.E[95])+rhs[2]*(2*params.E[145])+rhs[3]*(2*params.E[195])+rhs[4]*(2*params.E[245])+rhs[5]*(2*params.E[295])+rhs[6]*(2*params.E[345])+rhs[7]*(2*params.E[395])+rhs[8]*(2*params.E[445])+rhs[9]*(2*params.E[495])+rhs[10]*(2*params.E[545])+rhs[11]*(2*params.E[595])+rhs[12]*(2*params.E[645])+rhs[13]*(2*params.E[695])+rhs[14]*(2*params.E[745])+rhs[15]*(2*params.E[795])+rhs[16]*(2*params.E[845])+rhs[17]*(2*params.E[895])+rhs[18]*(2*params.E[945])+rhs[19]*(2*params.E[995])+rhs[20]*(2*params.E[1045])+rhs[21]*(2*params.E[1095])+rhs[22]*(2*params.E[1145])+rhs[23]*(2*params.E[1195])+rhs[24]*(2*params.E[1245])+rhs[25]*(2*params.E[1295])+rhs[26]*(2*params.E[1345])+rhs[27]*(2*params.E[1395])+rhs[28]*(2*params.E[1445])+rhs[29]*(2*params.E[1495])+rhs[30]*(2*params.E[1545])+rhs[31]*(2*params.E[1595])+rhs[32]*(2*params.E[1645])+rhs[33]*(2*params.E[1695])+rhs[34]*(2*params.E[1745])+rhs[35]*(2*params.E[1795])+rhs[36]*(2*params.E[1845])+rhs[37]*(2*params.E[1895])+rhs[38]*(2*params.E[1945])+rhs[39]*(2*params.E[1995])+rhs[40]*(2*params.E[2045])+rhs[41]*(2*params.E[2095])+rhs[42]*(2*params.E[2145])+rhs[43]*(2*params.E[2195])+rhs[44]*(2*params.E[2245])+rhs[45]*(2*params.E[2295])+rhs[46]*(2*params.E[2345])+rhs[47]*(2*params.E[2395])+rhs[48]*(2*params.E[2445])+rhs[49]*(2*params.E[2495]);
  lhs[46] = rhs[0]*(2*params.E[46])+rhs[1]*(2*params.E[96])+rhs[2]*(2*params.E[146])+rhs[3]*(2*params.E[196])+rhs[4]*(2*params.E[246])+rhs[5]*(2*params.E[296])+rhs[6]*(2*params.E[346])+rhs[7]*(2*params.E[396])+rhs[8]*(2*params.E[446])+rhs[9]*(2*params.E[496])+rhs[10]*(2*params.E[546])+rhs[11]*(2*params.E[596])+rhs[12]*(2*params.E[646])+rhs[13]*(2*params.E[696])+rhs[14]*(2*params.E[746])+rhs[15]*(2*params.E[796])+rhs[16]*(2*params.E[846])+rhs[17]*(2*params.E[896])+rhs[18]*(2*params.E[946])+rhs[19]*(2*params.E[996])+rhs[20]*(2*params.E[1046])+rhs[21]*(2*params.E[1096])+rhs[22]*(2*params.E[1146])+rhs[23]*(2*params.E[1196])+rhs[24]*(2*params.E[1246])+rhs[25]*(2*params.E[1296])+rhs[26]*(2*params.E[1346])+rhs[27]*(2*params.E[1396])+rhs[28]*(2*params.E[1446])+rhs[29]*(2*params.E[1496])+rhs[30]*(2*params.E[1546])+rhs[31]*(2*params.E[1596])+rhs[32]*(2*params.E[1646])+rhs[33]*(2*params.E[1696])+rhs[34]*(2*params.E[1746])+rhs[35]*(2*params.E[1796])+rhs[36]*(2*params.E[1846])+rhs[37]*(2*params.E[1896])+rhs[38]*(2*params.E[1946])+rhs[39]*(2*params.E[1996])+rhs[40]*(2*params.E[2046])+rhs[41]*(2*params.E[2096])+rhs[42]*(2*params.E[2146])+rhs[43]*(2*params.E[2196])+rhs[44]*(2*params.E[2246])+rhs[45]*(2*params.E[2296])+rhs[46]*(2*params.E[2346])+rhs[47]*(2*params.E[2396])+rhs[48]*(2*params.E[2446])+rhs[49]*(2*params.E[2496]);
  lhs[47] = rhs[0]*(2*params.E[47])+rhs[1]*(2*params.E[97])+rhs[2]*(2*params.E[147])+rhs[3]*(2*params.E[197])+rhs[4]*(2*params.E[247])+rhs[5]*(2*params.E[297])+rhs[6]*(2*params.E[347])+rhs[7]*(2*params.E[397])+rhs[8]*(2*params.E[447])+rhs[9]*(2*params.E[497])+rhs[10]*(2*params.E[547])+rhs[11]*(2*params.E[597])+rhs[12]*(2*params.E[647])+rhs[13]*(2*params.E[697])+rhs[14]*(2*params.E[747])+rhs[15]*(2*params.E[797])+rhs[16]*(2*params.E[847])+rhs[17]*(2*params.E[897])+rhs[18]*(2*params.E[947])+rhs[19]*(2*params.E[997])+rhs[20]*(2*params.E[1047])+rhs[21]*(2*params.E[1097])+rhs[22]*(2*params.E[1147])+rhs[23]*(2*params.E[1197])+rhs[24]*(2*params.E[1247])+rhs[25]*(2*params.E[1297])+rhs[26]*(2*params.E[1347])+rhs[27]*(2*params.E[1397])+rhs[28]*(2*params.E[1447])+rhs[29]*(2*params.E[1497])+rhs[30]*(2*params.E[1547])+rhs[31]*(2*params.E[1597])+rhs[32]*(2*params.E[1647])+rhs[33]*(2*params.E[1697])+rhs[34]*(2*params.E[1747])+rhs[35]*(2*params.E[1797])+rhs[36]*(2*params.E[1847])+rhs[37]*(2*params.E[1897])+rhs[38]*(2*params.E[1947])+rhs[39]*(2*params.E[1997])+rhs[40]*(2*params.E[2047])+rhs[41]*(2*params.E[2097])+rhs[42]*(2*params.E[2147])+rhs[43]*(2*params.E[2197])+rhs[44]*(2*params.E[2247])+rhs[45]*(2*params.E[2297])+rhs[46]*(2*params.E[2347])+rhs[47]*(2*params.E[2397])+rhs[48]*(2*params.E[2447])+rhs[49]*(2*params.E[2497]);
  lhs[48] = rhs[0]*(2*params.E[48])+rhs[1]*(2*params.E[98])+rhs[2]*(2*params.E[148])+rhs[3]*(2*params.E[198])+rhs[4]*(2*params.E[248])+rhs[5]*(2*params.E[298])+rhs[6]*(2*params.E[348])+rhs[7]*(2*params.E[398])+rhs[8]*(2*params.E[448])+rhs[9]*(2*params.E[498])+rhs[10]*(2*params.E[548])+rhs[11]*(2*params.E[598])+rhs[12]*(2*params.E[648])+rhs[13]*(2*params.E[698])+rhs[14]*(2*params.E[748])+rhs[15]*(2*params.E[798])+rhs[16]*(2*params.E[848])+rhs[17]*(2*params.E[898])+rhs[18]*(2*params.E[948])+rhs[19]*(2*params.E[998])+rhs[20]*(2*params.E[1048])+rhs[21]*(2*params.E[1098])+rhs[22]*(2*params.E[1148])+rhs[23]*(2*params.E[1198])+rhs[24]*(2*params.E[1248])+rhs[25]*(2*params.E[1298])+rhs[26]*(2*params.E[1348])+rhs[27]*(2*params.E[1398])+rhs[28]*(2*params.E[1448])+rhs[29]*(2*params.E[1498])+rhs[30]*(2*params.E[1548])+rhs[31]*(2*params.E[1598])+rhs[32]*(2*params.E[1648])+rhs[33]*(2*params.E[1698])+rhs[34]*(2*params.E[1748])+rhs[35]*(2*params.E[1798])+rhs[36]*(2*params.E[1848])+rhs[37]*(2*params.E[1898])+rhs[38]*(2*params.E[1948])+rhs[39]*(2*params.E[1998])+rhs[40]*(2*params.E[2048])+rhs[41]*(2*params.E[2098])+rhs[42]*(2*params.E[2148])+rhs[43]*(2*params.E[2198])+rhs[44]*(2*params.E[2248])+rhs[45]*(2*params.E[2298])+rhs[46]*(2*params.E[2348])+rhs[47]*(2*params.E[2398])+rhs[48]*(2*params.E[2448])+rhs[49]*(2*params.E[2498]);
  lhs[49] = rhs[0]*(2*params.E[49])+rhs[1]*(2*params.E[99])+rhs[2]*(2*params.E[149])+rhs[3]*(2*params.E[199])+rhs[4]*(2*params.E[249])+rhs[5]*(2*params.E[299])+rhs[6]*(2*params.E[349])+rhs[7]*(2*params.E[399])+rhs[8]*(2*params.E[449])+rhs[9]*(2*params.E[499])+rhs[10]*(2*params.E[549])+rhs[11]*(2*params.E[599])+rhs[12]*(2*params.E[649])+rhs[13]*(2*params.E[699])+rhs[14]*(2*params.E[749])+rhs[15]*(2*params.E[799])+rhs[16]*(2*params.E[849])+rhs[17]*(2*params.E[899])+rhs[18]*(2*params.E[949])+rhs[19]*(2*params.E[999])+rhs[20]*(2*params.E[1049])+rhs[21]*(2*params.E[1099])+rhs[22]*(2*params.E[1149])+rhs[23]*(2*params.E[1199])+rhs[24]*(2*params.E[1249])+rhs[25]*(2*params.E[1299])+rhs[26]*(2*params.E[1349])+rhs[27]*(2*params.E[1399])+rhs[28]*(2*params.E[1449])+rhs[29]*(2*params.E[1499])+rhs[30]*(2*params.E[1549])+rhs[31]*(2*params.E[1599])+rhs[32]*(2*params.E[1649])+rhs[33]*(2*params.E[1699])+rhs[34]*(2*params.E[1749])+rhs[35]*(2*params.E[1799])+rhs[36]*(2*params.E[1849])+rhs[37]*(2*params.E[1899])+rhs[38]*(2*params.E[1949])+rhs[39]*(2*params.E[1999])+rhs[40]*(2*params.E[2049])+rhs[41]*(2*params.E[2099])+rhs[42]*(2*params.E[2149])+rhs[43]*(2*params.E[2199])+rhs[44]*(2*params.E[2249])+rhs[45]*(2*params.E[2299])+rhs[46]*(2*params.E[2349])+rhs[47]*(2*params.E[2399])+rhs[48]*(2*params.E[2449])+rhs[49]*(2*params.E[2499]);
}


-(void) fillq {
  work.q[0] = params.B[0];
  work.q[1] = params.B[1];
  work.q[2] = params.B[2];
  work.q[3] = params.B[3];
  work.q[4] = params.B[4];
  work.q[5] = params.B[5];
  work.q[6] = params.B[6];
  work.q[7] = params.B[7];
  work.q[8] = params.B[8];
  work.q[9] = params.B[9];
  work.q[10] = params.B[10];
  work.q[11] = params.B[11];
  work.q[12] = params.B[12];
  work.q[13] = params.B[13];
  work.q[14] = params.B[14];
  work.q[15] = params.B[15];
  work.q[16] = params.B[16];
  work.q[17] = params.B[17];
  work.q[18] = params.B[18];
  work.q[19] = params.B[19];
  work.q[20] = params.B[20];
  work.q[21] = params.B[21];
  work.q[22] = params.B[22];
  work.q[23] = params.B[23];
  work.q[24] = params.B[24];
  work.q[25] = params.B[25];
  work.q[26] = params.B[26];
  work.q[27] = params.B[27];
  work.q[28] = params.B[28];
  work.q[29] = params.B[29];
  work.q[30] = params.B[30];
  work.q[31] = params.B[31];
  work.q[32] = params.B[32];
  work.q[33] = params.B[33];
  work.q[34] = params.B[34];
  work.q[35] = params.B[35];
  work.q[36] = params.B[36];
  work.q[37] = params.B[37];
  work.q[38] = params.B[38];
  work.q[39] = params.B[39];
  work.q[40] = params.B[40];
  work.q[41] = params.B[41];
  work.q[42] = params.B[42];
  work.q[43] = params.B[43];
  work.q[44] = params.B[44];
  work.q[45] = params.B[45];
  work.q[46] = params.B[46];
  work.q[47] = params.B[47];
  work.q[48] = params.B[48];
  work.q[49] = params.B[49];
}

-(void) fillh {
  work.h[0] = -params.minW[0];
  work.h[1] = -params.minW[1];
  work.h[2] = -params.minW[2];
  work.h[3] = -params.minW[3];
  work.h[4] = -params.minW[4];
  work.h[5] = -params.minW[5];
  work.h[6] = -params.minW[6];
  work.h[7] = -params.minW[7];
  work.h[8] = -params.minW[8];
  work.h[9] = -params.minW[9];
  work.h[10] = -params.minW[10];
  work.h[11] = -params.minW[11];
  work.h[12] = -params.minW[12];
  work.h[13] = -params.minW[13];
  work.h[14] = -params.minW[14];
  work.h[15] = -params.minW[15];
  work.h[16] = -params.minW[16];
  work.h[17] = -params.minW[17];
  work.h[18] = -params.minW[18];
  work.h[19] = -params.minW[19];
  work.h[20] = -params.minW[20];
  work.h[21] = -params.minW[21];
  work.h[22] = -params.minW[22];
  work.h[23] = -params.minW[23];
  work.h[24] = -params.minW[24];
  work.h[25] = params.maxW[0];
  work.h[26] = params.maxW[1];
  work.h[27] = params.maxW[2];
  work.h[28] = params.maxW[3];
  work.h[29] = params.maxW[4];
  work.h[30] = params.maxW[5];
  work.h[31] = params.maxW[6];
  work.h[32] = params.maxW[7];
  work.h[33] = params.maxW[8];
  work.h[34] = params.maxW[9];
  work.h[35] = params.maxW[10];
  work.h[36] = params.maxW[11];
  work.h[37] = params.maxW[12];
  work.h[38] = params.maxW[13];
  work.h[39] = params.maxW[14];
  work.h[40] = params.maxW[15];
  work.h[41] = params.maxW[16];
  work.h[42] = params.maxW[17];
  work.h[43] = params.maxW[18];
  work.h[44] = params.maxW[19];
  work.h[45] = params.maxW[20];
  work.h[46] = params.maxW[21];
  work.h[47] = params.maxW[22];
  work.h[48] = params.maxW[23];
  work.h[49] = params.maxW[24];
  work.h[50] = -params.minH[0];
  work.h[51] = -params.minH[1];
  work.h[52] = -params.minH[2];
  work.h[53] = -params.minH[3];
  work.h[54] = -params.minH[4];
  work.h[55] = -params.minH[5];
  work.h[56] = -params.minH[6];
  work.h[57] = -params.minH[7];
  work.h[58] = -params.minH[8];
  work.h[59] = -params.minH[9];
  work.h[60] = -params.minH[10];
  work.h[61] = -params.minH[11];
  work.h[62] = -params.minH[12];
  work.h[63] = -params.minH[13];
  work.h[64] = -params.minH[14];
  work.h[65] = -params.minH[15];
  work.h[66] = -params.minH[16];
  work.h[67] = -params.minH[17];
  work.h[68] = -params.minH[18];
  work.h[69] = -params.minH[19];
  work.h[70] = -params.minH[20];
  work.h[71] = -params.minH[21];
  work.h[72] = -params.minH[22];
  work.h[73] = -params.minH[23];
  work.h[74] = -params.minH[24];
  work.h[75] = params.maxH[0];
  work.h[76] = params.maxH[1];
  work.h[77] = params.maxH[2];
  work.h[78] = params.maxH[3];
  work.h[79] = params.maxH[4];
  work.h[80] = params.maxH[5];
  work.h[81] = params.maxH[6];
  work.h[82] = params.maxH[7];
  work.h[83] = params.maxH[8];
  work.h[84] = params.maxH[9];
  work.h[85] = params.maxH[10];
  work.h[86] = params.maxH[11];
  work.h[87] = params.maxH[12];
  work.h[88] = params.maxH[13];
  work.h[89] = params.maxH[14];
  work.h[90] = params.maxH[15];
  work.h[91] = params.maxH[16];
  work.h[92] = params.maxH[17];
  work.h[93] = params.maxH[18];
  work.h[94] = params.maxH[19];
  work.h[95] = params.maxH[20];
  work.h[96] = params.maxH[21];
  work.h[97] = params.maxH[22];
  work.h[98] = params.maxH[23];
  work.h[99] = params.maxH[24];
}
-(void) fillb {
  work.b[0] = params.imageWidth[0];
  work.b[1] = params.imageHeight[0];
}

-(void) pre_ops {
}

@end
