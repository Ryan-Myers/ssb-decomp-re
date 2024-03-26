.section .text
glabel func_80014CD0
  /* 0158D0 80014CD0 27BDFFB0 */     addiu $sp, $sp, -0x50
  /* 0158D4 80014CD4 AFBF002C */        sw $ra, 0x2c($sp)
  /* 0158D8 80014CD8 AFB40028 */        sw $s4, 0x28($sp)
  /* 0158DC 80014CDC AFB30024 */        sw $s3, 0x24($sp)
  /* 0158E0 80014CE0 AFB20020 */        sw $s2, 0x20($sp)
  /* 0158E4 80014CE4 AFB1001C */        sw $s1, 0x1c($sp)
  /* 0158E8 80014CE8 AFB00018 */        sw $s0, 0x18($sp)
  /* 0158EC 80014CEC 908E0054 */       lbu $t6, 0x54($a0)
  /* 0158F0 80014CF0 00809825 */        or $s3, $a0, $zero
  /* 0158F4 80014CF4 0000A025 */        or $s4, $zero, $zero
  /* 0158F8 80014CF8 31CF0002 */      andi $t7, $t6, 2
  /* 0158FC 80014CFC 15E000AC */      bnez $t7, .L80014FB0
  /* 015900 80014D00 3C018004 */       lui $at, %hi(gSpriteLayerDepth)
  /* 015904 80014D04 C4246FA4 */      lwc1 $f4, %lo(gSpriteLayerDepth)($at)
  /* 015908 80014D08 3C128004 */       lui $s2, %hi(D_800470B0)
  /* 01590C 80014D0C 265270B0 */     addiu $s2, $s2, %lo(D_800470B0)
  /* 015910 80014D10 E7A40030 */      swc1 $f4, 0x30($sp)
  /* 015914 80014D14 8C900050 */        lw $s0, 0x50($a0)
  /* 015918 80014D18 3C188004 */       lui $t8, %hi(D_800472A8)
  /* 01591C 80014D1C 02402025 */        or $a0, $s2, $zero
  /* 015920 80014D20 52000007 */      beql $s0, $zero, .L80014D40
  /* 015924 80014D24 8E4E0000 */        lw $t6, ($s2) # D_800470B0 + 0
  /* 015928 80014D28 8F1872A8 */        lw $t8, %lo(D_800472A8)($t8)
  /* 01592C 80014D2C 0018C880 */       sll $t9, $t8, 2
  /* 015930 80014D30 02196821 */      addu $t5, $s0, $t9
  /* 015934 80014D34 8DA60000 */        lw $a2, ($t5)
  /* 015938 80014D38 AFA60040 */        sw $a2, 0x40($sp)
  /* 01593C 80014D3C 8E4E0000 */        lw $t6, ($s2) # D_800470B0 + 0
  .L80014D40:
  /* 015940 80014D40 02602825 */        or $a1, $s3, $zero
  /* 015944 80014D44 0C00435C */       jal odRenderDObjMain
  /* 015948 80014D48 AFAE003C */        sw $t6, 0x3c($sp)
  /* 01594C 80014D4C 8FA60040 */        lw $a2, 0x40($sp)
  /* 015950 80014D50 12000058 */      beqz $s0, .L80014EB4
  /* 015954 80014D54 00405825 */        or $t3, $v0, $zero
  /* 015958 80014D58 50C00057 */      beql $a2, $zero, .L80014EB8
  /* 01595C 80014D5C 8E640010 */        lw $a0, 0x10($s3)
  /* 015960 80014D60 926F0054 */       lbu $t7, 0x54($s3)
  /* 015964 80014D64 31F80001 */      andi $t8, $t7, 1
  /* 015968 80014D68 57000053 */      bnel $t8, $zero, .L80014EB8
  /* 01596C 80014D6C 8E640010 */        lw $a0, 0x10($s3)
  /* 015970 80014D70 8CC20000 */        lw $v0, ($a2)
  /* 015974 80014D74 24010004 */     addiu $at, $zero, 4
  /* 015978 80014D78 3C118004 */       lui $s1, %hi(gDisplayListHead)
  /* 01597C 80014D7C 1041004D */       beq $v0, $at, .L80014EB4
  /* 015980 80014D80 263165B0 */     addiu $s1, $s1, %lo(gDisplayListHead)
  /* 015984 80014D84 3C078004 */       lui $a3, %hi(D_800470B8)
  /* 015988 80014D88 24E770B8 */     addiu $a3, $a3, %lo(D_800470B8)
  /* 01598C 80014D8C 8CD90004 */        lw $t9, 4($a2)
  .L80014D90:
  /* 015990 80014D90 00028080 */       sll $s0, $v0, 2
  /* 015994 80014D94 00F06821 */      addu $t5, $a3, $s0
  /* 015998 80014D98 53200042 */      beql $t9, $zero, .L80014EA4
  /* 01599C 80014D9C 8CC20008 */        lw $v0, 8($a2)
  /* 0159A0 80014DA0 8DA40000 */        lw $a0, ($t5)
  /* 0159A4 80014DA4 8E4E0000 */        lw $t6, ($s2) # D_800470B0 + 0
  /* 0159A8 80014DA8 11C40019 */       beq $t6, $a0, .L80014E10
  /* 0159AC 80014DAC 02307821 */      addu $t7, $s1, $s0
  .L80014DB0:
  /* 0159B0 80014DB0 8DF80000 */        lw $t8, ($t7)
  /* 0159B4 80014DB4 8C8D0000 */        lw $t5, ($a0)
  /* 0159B8 80014DB8 AF0D0000 */        sw $t5, ($t8)
  /* 0159BC 80014DBC 8C990004 */        lw $t9, 4($a0)
  /* 0159C0 80014DC0 AF190004 */        sw $t9, 4($t8)
  /* 0159C4 80014DC4 8CCE0000 */        lw $t6, ($a2)
  /* 0159C8 80014DC8 000E7880 */       sll $t7, $t6, 2
  /* 0159CC 80014DCC 022F1821 */      addu $v1, $s1, $t7
  /* 0159D0 80014DD0 8C780000 */        lw $t8, ($v1)
  /* 0159D4 80014DD4 27190008 */     addiu $t9, $t8, 8
  /* 0159D8 80014DD8 AC790000 */        sw $t9, ($v1)
  /* 0159DC 80014DDC 8CCD0000 */        lw $t5, ($a2)
  /* 0159E0 80014DE0 000D7080 */       sll $t6, $t5, 2
  /* 0159E4 80014DE4 00EE1021 */      addu $v0, $a3, $t6
  /* 0159E8 80014DE8 8C4F0000 */        lw $t7, ($v0)
  /* 0159EC 80014DEC 8E4D0000 */        lw $t5, ($s2) # D_800470B0 + 0
  /* 0159F0 80014DF0 25F80008 */     addiu $t8, $t7, 8
  /* 0159F4 80014DF4 AC580000 */        sw $t8, ($v0)
  /* 0159F8 80014DF8 8CD00000 */        lw $s0, ($a2)
  /* 0159FC 80014DFC 00108080 */       sll $s0, $s0, 2
  /* 015A00 80014E00 00F0C821 */      addu $t9, $a3, $s0
  /* 015A04 80014E04 8F240000 */        lw $a0, ($t9)
  /* 015A08 80014E08 55A4FFE9 */      bnel $t5, $a0, .L80014DB0
  /* 015A0C 80014E0C 02307821 */      addu $t7, $s1, $s0
  .L80014E10:
  /* 015A10 80014E10 8E6E0080 */        lw $t6, 0x80($s3)
  /* 015A14 80014E14 51C0001B */      beql $t6, $zero, .L80014E84
  /* 015A18 80014E18 02301821 */      addu $v1, $s1, $s0
  /* 015A1C 80014E1C 1680000F */      bnez $s4, .L80014E5C
  /* 015A20 80014E20 02301821 */      addu $v1, $s1, $s0
  /* 015A24 80014E24 3C148004 */       lui $s4, %hi(gGraphicsHeap + 12)
  /* 015A28 80014E28 8E9465E4 */        lw $s4, %lo(gGraphicsHeap + 12)($s4)
  /* 015A2C 80014E2C 02602025 */        or $a0, $s3, $zero
  /* 015A30 80014E30 02302821 */      addu $a1, $s1, $s0
  /* 015A34 80014E34 AFA60040 */        sw $a2, 0x40($sp)
  /* 015A38 80014E38 0C004B64 */       jal odRenderMObjForDObj
  /* 015A3C 80014E3C AFAB0048 */        sw $t3, 0x48($sp)
  /* 015A40 80014E40 8FA60040 */        lw $a2, 0x40($sp)
  /* 015A44 80014E44 3C078004 */       lui $a3, %hi(D_800470B8)
  /* 015A48 80014E48 24E770B8 */     addiu $a3, $a3, %lo(D_800470B8)
  /* 015A4C 80014E4C 8CD00000 */        lw $s0, ($a2)
  /* 015A50 80014E50 8FAB0048 */        lw $t3, 0x48($sp)
  /* 015A54 80014E54 1000000A */         b .L80014E80
  /* 015A58 80014E58 00108080 */       sll $s0, $s0, 2
  .L80014E5C:
  /* 015A5C 80014E5C 8C620000 */        lw $v0, ($v1)
  /* 015A60 80014E60 3C18DB06 */       lui $t8, (0xDB060038 >> 16) # 3674603576
  /* 015A64 80014E64 37180038 */       ori $t8, $t8, (0xDB060038 & 0xFFFF) # 3674603576
  /* 015A68 80014E68 244F0008 */     addiu $t7, $v0, 8
  /* 015A6C 80014E6C AC6F0000 */        sw $t7, ($v1)
  /* 015A70 80014E70 AC540004 */        sw $s4, 4($v0)
  /* 015A74 80014E74 AC580000 */        sw $t8, ($v0)
  /* 015A78 80014E78 8CD00000 */        lw $s0, ($a2)
  /* 015A7C 80014E7C 00108080 */       sll $s0, $s0, 2
  .L80014E80:
  /* 015A80 80014E80 02301821 */      addu $v1, $s1, $s0
  .L80014E84:
  /* 015A84 80014E84 8C620000 */        lw $v0, ($v1)
  /* 015A88 80014E88 3C0DDE00 */       lui $t5, 0xde00
  /* 015A8C 80014E8C 24590008 */     addiu $t9, $v0, 8
  /* 015A90 80014E90 AC790000 */        sw $t9, ($v1)
  /* 015A94 80014E94 AC4D0000 */        sw $t5, ($v0)
  /* 015A98 80014E98 8CCE0004 */        lw $t6, 4($a2)
  /* 015A9C 80014E9C AC4E0004 */        sw $t6, 4($v0)
  /* 015AA0 80014EA0 8CC20008 */        lw $v0, 8($a2)
  .L80014EA4:
  /* 015AA4 80014EA4 24010004 */     addiu $at, $zero, 4
  /* 015AA8 80014EA8 24C60008 */     addiu $a2, $a2, 8
  /* 015AAC 80014EAC 5441FFB8 */      bnel $v0, $at, .L80014D90
  /* 015AB0 80014EB0 8CD90004 */        lw $t9, 4($a2)
  .L80014EB4:
  /* 015AB4 80014EB4 8E640010 */        lw $a0, 0x10($s3)
  .L80014EB8:
  /* 015AB8 80014EB8 3C118004 */       lui $s1, %hi(gDisplayListHead)
  /* 015ABC 80014EBC 263165B0 */     addiu $s1, $s1, %lo(gDisplayListHead)
  /* 015AC0 80014EC0 50800005 */      beql $a0, $zero, .L80014ED8
  /* 015AC4 80014EC4 8FAF003C */        lw $t7, 0x3c($sp)
  /* 015AC8 80014EC8 0C005334 */       jal func_80014CD0
  /* 015ACC 80014ECC AFAB0048 */        sw $t3, 0x48($sp)
  /* 015AD0 80014ED0 8FAB0048 */        lw $t3, 0x48($sp)
  /* 015AD4 80014ED4 8FAF003C */        lw $t7, 0x3c($sp)
  .L80014ED8:
  /* 015AD8 80014ED8 3C068004 */       lui $a2, %hi(D_800470B8)
  /* 015ADC 80014EDC 3C0C8004 */       lui $t4, %hi(D_800470C8)
  /* 015AE0 80014EE0 3C09D838 */       lui $t1, (0xD8380002 >> 16) # 3627548674
  /* 015AE4 80014EE4 35290002 */       ori $t1, $t1, (0xD8380002 & 0xFFFF) # 3627548674
  /* 015AE8 80014EE8 258C70C8 */     addiu $t4, $t4, %lo(D_800470C8)
  /* 015AEC 80014EEC 24C670B8 */     addiu $a2, $a2, %lo(D_800470B8)
  /* 015AF0 80014EF0 00003825 */        or $a3, $zero, $zero
  /* 015AF4 80014EF4 240A0040 */     addiu $t2, $zero, 0x40
  /* 015AF8 80014EF8 24080001 */     addiu $t0, $zero, 1
  /* 015AFC 80014EFC AE4F0000 */        sw $t7, ($s2) # D_800470B0 + 0
  .L80014F00:
  /* 015B00 80014F00 8E450000 */        lw $a1, ($s2) # D_800470B0 + 0
  /* 015B04 80014F04 8CD80000 */        lw $t8, ($a2) # D_800470B8 + 0
  /* 015B08 80014F08 00B8082B */      sltu $at, $a1, $t8
  /* 015B0C 80014F0C 50200011 */      beql $at, $zero, .L80014F54
  /* 015B10 80014F10 8CCF0004 */        lw $t7, 4($a2) # D_800470B8 + 4
  /* 015B14 80014F14 1160000E */      beqz $t3, .L80014F50
  /* 015B18 80014F18 ACC50000 */        sw $a1, ($a2) # D_800470B8 + 0
  /* 015B1C 80014F1C 8E790014 */        lw $t9, 0x14($s3)
  /* 015B20 80014F20 02271821 */      addu $v1, $s1, $a3
  /* 015B24 80014F24 51190005 */      beql $t0, $t9, .L80014F3C
  /* 015B28 80014F28 8C640000 */        lw $a0, ($v1)
  /* 015B2C 80014F2C 8E6D0008 */        lw $t5, 8($s3)
  /* 015B30 80014F30 51A00008 */      beql $t5, $zero, .L80014F54
  /* 015B34 80014F34 8CCF0004 */        lw $t7, 4($a2) # D_800470B8 + 4
  /* 015B38 80014F38 8C640000 */        lw $a0, ($v1)
  .L80014F3C:
  /* 015B3C 80014F3C 248E0008 */     addiu $t6, $a0, 8
  /* 015B40 80014F40 AC6E0000 */        sw $t6, ($v1)
  /* 015B44 80014F44 AC8A0004 */        sw $t2, 4($a0)
  /* 015B48 80014F48 AC890000 */        sw $t1, ($a0)
  /* 015B4C 80014F4C 8E450000 */        lw $a1, ($s2) # D_800470B0 + 0
  .L80014F50:
  /* 015B50 80014F50 8CCF0004 */        lw $t7, 4($a2) # D_800470B8 + 4
  .L80014F54:
  /* 015B54 80014F54 00AF082B */      sltu $at, $a1, $t7
  /* 015B58 80014F58 50200010 */      beql $at, $zero, .L80014F9C
  /* 015B5C 80014F5C 24C60008 */     addiu $a2, $a2, 8
  /* 015B60 80014F60 1160000D */      beqz $t3, .L80014F98
  /* 015B64 80014F64 ACC50004 */        sw $a1, 4($a2) # D_800470B8 + 4
  /* 015B68 80014F68 8E780014 */        lw $t8, 0x14($s3)
  /* 015B6C 80014F6C 02271821 */      addu $v1, $s1, $a3
  /* 015B70 80014F70 51180005 */      beql $t0, $t8, .L80014F88
  /* 015B74 80014F74 8C640004 */        lw $a0, 4($v1)
  /* 015B78 80014F78 8E790008 */        lw $t9, 8($s3)
  /* 015B7C 80014F7C 53200007 */      beql $t9, $zero, .L80014F9C
  /* 015B80 80014F80 24C60008 */     addiu $a2, $a2, 8
  /* 015B84 80014F84 8C640004 */        lw $a0, 4($v1)
  .L80014F88:
  /* 015B88 80014F88 248D0008 */     addiu $t5, $a0, 8
  /* 015B8C 80014F8C AC6D0004 */        sw $t5, 4($v1)
  /* 015B90 80014F90 AC8A0004 */        sw $t2, 4($a0)
  /* 015B94 80014F94 AC890000 */        sw $t1, ($a0)
  .L80014F98:
  /* 015B98 80014F98 24C60008 */     addiu $a2, $a2, 8
  .L80014F9C:
  /* 015B9C 80014F9C 14CCFFD8 */       bne $a2, $t4, .L80014F00
  /* 015BA0 80014FA0 24E70008 */     addiu $a3, $a3, 8
  /* 015BA4 80014FA4 C7A60030 */      lwc1 $f6, 0x30($sp)
  /* 015BA8 80014FA8 3C018004 */       lui $at, %hi(gSpriteLayerDepth)
  /* 015BAC 80014FAC E4266FA4 */      swc1 $f6, %lo(gSpriteLayerDepth)($at)
  .L80014FB0:
  /* 015BB0 80014FB0 8E6E000C */        lw $t6, 0xc($s3)
  /* 015BB4 80014FB4 55C0000A */      bnel $t6, $zero, .L80014FE0
  /* 015BB8 80014FB8 8FBF002C */        lw $ra, 0x2c($sp)
  /* 015BBC 80014FBC 8E700008 */        lw $s0, 8($s3)
  /* 015BC0 80014FC0 52000007 */      beql $s0, $zero, .L80014FE0
  /* 015BC4 80014FC4 8FBF002C */        lw $ra, 0x2c($sp)
  .L80014FC8:
  /* 015BC8 80014FC8 0C005334 */       jal func_80014CD0
  /* 015BCC 80014FCC 02002025 */        or $a0, $s0, $zero
  /* 015BD0 80014FD0 8E100008 */        lw $s0, 8($s0)
  /* 015BD4 80014FD4 1600FFFC */      bnez $s0, .L80014FC8
  /* 015BD8 80014FD8 00000000 */       nop 
  /* 015BDC 80014FDC 8FBF002C */        lw $ra, 0x2c($sp)
  .L80014FE0:
  /* 015BE0 80014FE0 8FB00018 */        lw $s0, 0x18($sp)
  /* 015BE4 80014FE4 8FB1001C */        lw $s1, 0x1c($sp)
  /* 015BE8 80014FE8 8FB20020 */        lw $s2, 0x20($sp)
  /* 015BEC 80014FEC 8FB30024 */        lw $s3, 0x24($sp)
  /* 015BF0 80014FF0 8FB40028 */        lw $s4, 0x28($sp)
  /* 015BF4 80014FF4 03E00008 */        jr $ra
  /* 015BF8 80014FF8 27BD0050 */     addiu $sp, $sp, 0x50

