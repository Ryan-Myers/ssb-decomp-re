.section .text
glabel func_ovl0_800C8A58
  /* 044438 800C8A58 27BDFFE0 */     addiu $sp, $sp, -0x20
  /* 04443C 800C8A5C AFA50024 */        sw $a1, 0x24($sp)
  /* 044440 800C8A60 30A500FF */      andi $a1, $a1, 0xff
  /* 044444 800C8A64 AFB00018 */        sw $s0, 0x18($sp)
  /* 044448 800C8A68 00808025 */        or $s0, $a0, $zero
  /* 04444C 800C8A6C AFBF001C */        sw $ra, 0x1c($sp)
  /* 044450 800C8A70 AFA60028 */        sw $a2, 0x28($sp)
  /* 044454 800C8A74 10A00003 */      beqz $a1, .L800C8A84
  /* 044458 800C8A78 AFA7002C */        sw $a3, 0x2c($sp)
  /* 04445C 800C8A7C 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 044460 800C8A80 93A60033 */       lbu $a2, 0x33($sp)
  .L800C8A84:
  /* 044464 800C8A84 93AE002B */       lbu $t6, 0x2b($sp)
  /* 044468 800C8A88 02002025 */        or $a0, $s0, $zero
  /* 04446C 800C8A8C 11C00003 */      beqz $t6, .L800C8A9C
  /* 044470 800C8A90 01C02825 */        or $a1, $t6, $zero
  /* 044474 800C8A94 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 044478 800C8A98 93A60033 */       lbu $a2, 0x33($sp)
  .L800C8A9C:
  /* 04447C 800C8A9C 93AF002F */       lbu $t7, 0x2f($sp)
  /* 044480 800C8AA0 02002025 */        or $a0, $s0, $zero
  /* 044484 800C8AA4 11E00003 */      beqz $t7, .L800C8AB4
  /* 044488 800C8AA8 01E02825 */        or $a1, $t7, $zero
  /* 04448C 800C8AAC 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 044490 800C8AB0 93A60033 */       lbu $a2, 0x33($sp)
  .L800C8AB4:
  /* 044494 800C8AB4 3C188004 */       lui $t8, %hi(dOMTranslateDefault + 4)
  /* 044498 800C8AB8 2718B8E0 */     addiu $t8, $t8, %lo(dOMTranslateDefault + 4)
  /* 04449C 800C8ABC 8F080000 */        lw $t0, ($t8) # dOMTranslateDefault + 4 + 0
  /* 0444A0 800C8AC0 3C098004 */       lui $t1, %hi(dOMRotateDefaultRPY + 8)
  /* 0444A4 800C8AC4 2529B908 */     addiu $t1, $t1, %lo(dOMRotateDefaultRPY + 8)
  /* 0444A8 800C8AC8 AE08001C */        sw $t0, 0x1c($s0)
  /* 0444AC 800C8ACC 8F190004 */        lw $t9, 4($t8) # dOMTranslateDefault + 4 + 4
  /* 0444B0 800C8AD0 3C0C8004 */       lui $t4, %hi(dOMScaleDefault + 4)
  /* 0444B4 800C8AD4 258CB918 */     addiu $t4, $t4, %lo(dOMScaleDefault + 4)
  /* 0444B8 800C8AD8 AE190020 */        sw $t9, 0x20($s0)
  /* 0444BC 800C8ADC 8F080008 */        lw $t0, 8($t8) # dOMTranslateDefault + 4 + 8
  /* 0444C0 800C8AE0 AE080024 */        sw $t0, 0x24($s0)
  /* 0444C4 800C8AE4 8D2B0000 */        lw $t3, ($t1) # dOMRotateDefaultRPY + 8 + 0
  /* 0444C8 800C8AE8 AE0B0030 */        sw $t3, 0x30($s0)
  /* 0444CC 800C8AEC 8D2A0004 */        lw $t2, 4($t1) # dOMRotateDefaultRPY + 8 + 4
  /* 0444D0 800C8AF0 AE0A0034 */        sw $t2, 0x34($s0)
  /* 0444D4 800C8AF4 8D2B0008 */        lw $t3, 8($t1) # dOMRotateDefaultRPY + 8 + 8
  /* 0444D8 800C8AF8 AE0B0038 */        sw $t3, 0x38($s0)
  /* 0444DC 800C8AFC 8D8E0000 */        lw $t6, ($t4) # dOMScaleDefault + 4 + 0
  /* 0444E0 800C8B00 AE0E0040 */        sw $t6, 0x40($s0)
  /* 0444E4 800C8B04 8D8D0004 */        lw $t5, 4($t4) # dOMScaleDefault + 4 + 4
  /* 0444E8 800C8B08 AE0D0044 */        sw $t5, 0x44($s0)
  /* 0444EC 800C8B0C 8D8E0008 */        lw $t6, 8($t4) # dOMScaleDefault + 4 + 8
  /* 0444F0 800C8B10 AE0E0048 */        sw $t6, 0x48($s0)
  /* 0444F4 800C8B14 8FBF001C */        lw $ra, 0x1c($sp)
  /* 0444F8 800C8B18 8FB00018 */        lw $s0, 0x18($sp)
  /* 0444FC 800C8B1C 27BD0020 */     addiu $sp, $sp, 0x20
  /* 044500 800C8B20 03E00008 */        jr $ra
  /* 044504 800C8B24 00000000 */       nop 

