INCLUDE "hUGE.inc"

SECTION "SONG DATA", ROM0

dwellings_bgm::
db 9
dw order_cnt
dw order1, order2, order3, order4
dw duty_instruments, wave_instruments, noise_instruments
dw routines
dw waves

order_cnt: db 8
order1: dw P1,P5,P1,P9
order2: dw P0,P0,P0,P2
order3: dw P3,P3,P3,P3
order4: dw P4,P4,P4,P4

P0:
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000

P1:
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn G#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn C#5,1,$C08
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn G#4,1,$C08
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn C#5,1,$C08
 dn ___,0,$000
 dn D#5,1,$C08
 dn ___,0,$000
 dn F_5,1,$C08
 dn ___,0,$000
 dn G#5,1,$C08
 dn ___,0,$000
 dn G_5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn F_5,1,$C08
 dn ___,0,$000
 dn D#5,1,$C08
 dn ___,0,$000
 dn F_5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000

P2:
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn D#5,1,$C08
 dn ___,0,$000
 dn ___,0,$E08
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08

P3:
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn F_3,6,$000
 dn ___,0,$E00
 dn A#3,4,$000
 dn A#3,6,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn A#3,6,$000
 dn ___,0,$E00

P4:
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000
 dn C_7,2,$C04
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn C#8,1,$C02
 dn ___,0,$000
 dn D_8,1,$C02
 dn ___,0,$000

P5:
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn C#5,1,$C08
 dn G#4,1,$C08
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn G#4,1,$C08
 dn ___,0,$000
 dn F_4,1,$C08
 dn ___,0,$000
 dn E_4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn D#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E00
 dn ___,0,$000
 dn ___,0,$000
 dn B_3,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn ___,0,$000
 dn ___,0,$000
 dn A#3,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08

P9:
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn C#5,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn A#4,1,$C08
 dn ___,0,$000
 dn C#5,1,$C08
 dn G#4,1,$C08
 dn A#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn G#4,1,$C08
 dn ___,0,$000
 dn F_4,1,$C08
 dn ___,0,$000
 dn D#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn D#4,1,$C08
 dn ___,0,$000
 dn ___,0,$E08
 dn C#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08
 dn C#4,1,$C08
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$000
 dn ___,0,$E08

duty_instruments:
itSquareinst1: db 8,0,240,128
itSquareinst2: db 8,64,240,128
itSquareinst3: db 0,128,240,128
itSquareinst4: db 8,192,240,128
itSquareinst5: db 8,0,241,128
itSquareinst6: db 8,64,241,128
itSquareinst7: db 8,128,241,128
itSquareinst8: db 8,192,241,128
itSquareinst9: db 9,0,240,128
itSquareinst10: db 8,128,240,128
itSquareinst11: db 8,128,240,128
itSquareinst12: db 8,128,240,128
itSquareinst13: db 8,128,240,128
itSquareinst14: db 8,128,240,128
itSquareinst15: db 8,128,240,128


wave_instruments:
itWaveinst1: db 0,32,0,128
itWaveinst2: db 0,32,1,128
itWaveinst3: db 0,32,2,128
itWaveinst4: db 0,64,6,192
itWaveinst5: db 0,32,4,128
itWaveinst6: db 0,32,5,128
itWaveinst7: db 0,32,6,128
itWaveinst8: db 0,32,7,128
itWaveinst9: db 0,32,8,128
itWaveinst10: db 0,32,9,128
itWaveinst11: db 0,32,10,128
itWaveinst12: db 0,32,11,128
itWaveinst13: db 0,32,12,128
itWaveinst14: db 0,32,13,128
itWaveinst15: db 0,32,14,128


noise_instruments:
itNoiseinst1: db 146,64,0,0,0,0,0,0
itNoiseinst2: db 241,92,0,0,0,0,0,0
itNoiseinst3: db 240,0,0,0,0,0,0,0
itNoiseinst4: db 240,0,0,0,0,0,0,0
itNoiseinst5: db 240,0,0,0,0,0,0,0
itNoiseinst6: db 240,0,0,0,0,0,0,0
itNoiseinst7: db 240,0,0,0,0,0,0,0
itNoiseinst8: db 240,0,0,0,0,0,0,0
itNoiseinst9: db 240,0,0,0,0,0,0,0
itNoiseinst10: db 240,0,0,0,0,0,0,0
itNoiseinst11: db 240,0,0,0,0,0,0,0
itNoiseinst12: db 240,0,0,0,0,0,0,0
itNoiseinst13: db 240,0,0,0,0,0,0,0
itNoiseinst14: db 240,0,0,0,0,0,0,0
itNoiseinst15: db 240,0,0,0,0,0,0,0


routines:
__hUGE_Routine_0:

__end_hUGE_Routine_0:
ret

__hUGE_Routine_1:

__end_hUGE_Routine_1:
ret

__hUGE_Routine_2:

__end_hUGE_Routine_2:
ret

__hUGE_Routine_3:

__end_hUGE_Routine_3:
ret

__hUGE_Routine_4:

__end_hUGE_Routine_4:
ret

__hUGE_Routine_5:

__end_hUGE_Routine_5:
ret

__hUGE_Routine_6:

__end_hUGE_Routine_6:
ret

__hUGE_Routine_7:

__end_hUGE_Routine_7:
ret

__hUGE_Routine_8:

__end_hUGE_Routine_8:
ret

__hUGE_Routine_9:

__end_hUGE_Routine_9:
ret

__hUGE_Routine_10:

__end_hUGE_Routine_10:
ret

__hUGE_Routine_11:

__end_hUGE_Routine_11:
ret

__hUGE_Routine_12:

__end_hUGE_Routine_12:
ret

__hUGE_Routine_13:

__end_hUGE_Routine_13:
ret

__hUGE_Routine_14:

__end_hUGE_Routine_14:
ret

__hUGE_Routine_15:

__end_hUGE_Routine_15:
ret

waves:
wave0: db 0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255
wave1: db 0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255
wave2: db 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255
wave3: db 51,212,68,69,121,154,187,75,187,170,152,187,188,201,233,159
wave4: db 0,1,18,35,52,69,86,103,120,137,154,171,188,205,222,239
wave5: db 254,220,186,152,118,84,50,16,18,52,86,120,154,188,222,255
wave6: db 122,205,219,117,33,19,104,189,220,151,65,1,71,156,221,184
wave7: db 15,15,15,15,15,15,15,15,15,15,15,15,15,15,15,15
wave8: db 254,252,250,248,246,244,242,240,242,244,246,248,250,252,254,255
wave9: db 254,221,204,187,170,153,136,119,138,189,241,36,87,138,189,238
wave10: db 132,17,97,237,87,71,90,173,206,163,23,121,221,32,3,71
wave11: db 153,202,53,105,186,234,213,224,144,226,114,126,50,129,170,104
wave12: db 8,76,170,172,92,210,136,69,113,179,60,11,160,137,10,107
wave13: db 130,167,129,133,113,62,76,92,26,147,161,141,53,224,73,176
wave14: db 172,198,107,70,128,60,160,86,11,227,187,46,230,237,151,87
wave15: db 165,187,83,211,76,151,146,57,226,130,150,41,32,170,202,39

