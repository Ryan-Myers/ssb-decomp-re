.section .text
glabel func_ovl0_800C89BC
  /* 04439C 800C89BC 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 0443A0 800C89C0 AFBF0014 */        sw $ra, 0x14($sp)
  /* 0443A4 800C89C4 AFA5001C */        sw $a1, 0x1c($sp)
  /* 0443A8 800C89C8 AFA60020 */        sw $a2, 0x20($sp)
  /* 0443AC 800C89CC AFA70024 */        sw $a3, 0x24($sp)
  /* 0443B0 800C89D0 30E700FF */      andi $a3, $a3, 0xff
  /* 0443B4 800C89D4 30C600FF */      andi $a2, $a2, 0xff
  /* 0443B8 800C89D8 30A500FF */      andi $a1, $a1, 0xff
  /* 0443BC 800C89DC 0C003CBF */       jal func_8000F2FC
  /* 0443C0 800C89E0 AFA40018 */        sw $a0, 0x18($sp)
  /* 0443C4 800C89E4 3C0E8004 */       lui $t6, %hi(dOMTranslateDefault + 4)
  /* 0443C8 800C89E8 25CEB8E0 */     addiu $t6, $t6, %lo(dOMTranslateDefault + 4)
  /* 0443CC 800C89EC 8FA40018 */        lw $a0, 0x18($sp)
  /* 0443D0 800C89F0 8DD80000 */        lw $t8, ($t6) # dOMTranslateDefault + 4 + 0
  /* 0443D4 800C89F4 3C198004 */       lui $t9, %hi(dOMRotateDefaultRPY + 8)
  /* 0443D8 800C89F8 2739B908 */     addiu $t9, $t9, %lo(dOMRotateDefaultRPY + 8)
  /* 0443DC 800C89FC AC98001C */        sw $t8, 0x1c($a0)
  /* 0443E0 800C8A00 8DCF0004 */        lw $t7, 4($t6) # dOMTranslateDefault + 4 + 4
  /* 0443E4 800C8A04 3C0A8004 */       lui $t2, %hi(dOMScaleDefault + 4)
  /* 0443E8 800C8A08 254AB918 */     addiu $t2, $t2, %lo(dOMScaleDefault + 4)
  /* 0443EC 800C8A0C AC8F0020 */        sw $t7, 0x20($a0)
  /* 0443F0 800C8A10 8DD80008 */        lw $t8, 8($t6) # dOMTranslateDefault + 4 + 8
  /* 0443F4 800C8A14 AC980024 */        sw $t8, 0x24($a0)
  /* 0443F8 800C8A18 8F290000 */        lw $t1, ($t9) # dOMRotateDefaultRPY + 8 + 0
  /* 0443FC 800C8A1C AC890030 */        sw $t1, 0x30($a0)
  /* 044400 800C8A20 8F280004 */        lw $t0, 4($t9) # dOMRotateDefaultRPY + 8 + 4
  /* 044404 800C8A24 AC880034 */        sw $t0, 0x34($a0)
  /* 044408 800C8A28 8F290008 */        lw $t1, 8($t9) # dOMRotateDefaultRPY + 8 + 8
  /* 04440C 800C8A2C AC890038 */        sw $t1, 0x38($a0)
  /* 044410 800C8A30 8D4C0000 */        lw $t4, ($t2) # dOMScaleDefault + 4 + 0
  /* 044414 800C8A34 AC8C0040 */        sw $t4, 0x40($a0)
  /* 044418 800C8A38 8D4B0004 */        lw $t3, 4($t2) # dOMScaleDefault + 4 + 4
  /* 04441C 800C8A3C AC8B0044 */        sw $t3, 0x44($a0)
  /* 044420 800C8A40 8D4C0008 */        lw $t4, 8($t2) # dOMScaleDefault + 4 + 8
  /* 044424 800C8A44 AC8C0048 */        sw $t4, 0x48($a0)
  /* 044428 800C8A48 8FBF0014 */        lw $ra, 0x14($sp)
  /* 04442C 800C8A4C 27BD0018 */     addiu $sp, $sp, 0x18
  /* 044430 800C8A50 03E00008 */        jr $ra
  /* 044434 800C8A54 00000000 */       nop 

