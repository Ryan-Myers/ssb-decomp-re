.section .text
glabel func_80010918
  /* 011518 80010918 27BDFF78 */     addiu $sp, $sp, -0x88
  /* 01151C 8001091C 3C0E8004 */       lui $t6, %hi(D_80046A58)
  /* 011520 80010920 8DCE6A58 */        lw $t6, %lo(D_80046A58)($t6)
  /* 011524 80010924 AFBF0014 */        sw $ra, 0x14($sp)
  /* 011528 80010928 AFA40088 */        sw $a0, 0x88($sp)
  /* 01152C 8001092C AFA60090 */        sw $a2, 0x90($sp)
  /* 011530 80010930 8DC20074 */        lw $v0, 0x74($t6)
  /* 011534 80010934 C4A4001C */      lwc1 $f4, 0x1c($a1)
  /* 011538 80010938 C4A80020 */      lwc1 $f8, 0x20($a1)
  /* 01153C 8001093C C446003C */      lwc1 $f6, 0x3c($v0)
  /* 011540 80010940 C44A0040 */      lwc1 $f10, 0x40($v0)
  /* 011544 80010944 46062081 */     sub.s $f2, $f4, $f6
  /* 011548 80010948 C4A40024 */      lwc1 $f4, 0x24($a1)
  /* 01154C 8001094C C4460044 */      lwc1 $f6, 0x44($v0)
  /* 011550 80010950 460A4481 */     sub.s $f18, $f8, $f10
  /* 011554 80010954 46021202 */     mul.s $f8, $f2, $f2
  /* 011558 80010958 E7A20044 */      swc1 $f2, 0x44($sp)
  /* 01155C 8001095C 46062381 */     sub.s $f14, $f4, $f6
  /* 011560 80010960 46129282 */     mul.s $f10, $f18, $f18
  /* 011564 80010964 E7B20040 */      swc1 $f18, 0x40($sp)
  /* 011568 80010968 AFA5008C */        sw $a1, 0x8c($sp)
  /* 01156C 8001096C 460E7182 */     mul.s $f6, $f14, $f14
  /* 011570 80010970 E7AE003C */      swc1 $f14, 0x3c($sp)
  /* 011574 80010974 460A4100 */     add.s $f4, $f8, $f10
  /* 011578 80010978 0C00CD44 */       jal sqrtf
  /* 01157C 8001097C 46062300 */     add.s $f12, $f4, $f6
  /* 011580 80010980 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 011584 80010984 44814000 */      mtc1 $at, $f8 # 1.0 to cop1
  /* 011588 80010988 C7A20044 */      lwc1 $f2, 0x44($sp)
  /* 01158C 8001098C C7B20040 */      lwc1 $f18, 0x40($sp)
  /* 011590 80010990 46004403 */     div.s $f16, $f8, $f0
  /* 011594 80010994 C7AE003C */      lwc1 $f14, 0x3c($sp)
  /* 011598 80010998 46101082 */     mul.s $f2, $f2, $f16
  /* 01159C 8001099C 00000000 */       nop 
  /* 0115A0 800109A0 46109482 */     mul.s $f18, $f18, $f16
  /* 0115A4 800109A4 00000000 */       nop 
  /* 0115A8 800109A8 46107382 */     mul.s $f14, $f14, $f16
  /* 0115AC 800109AC E7A20044 */      swc1 $f2, 0x44($sp)
  /* 0115B0 800109B0 46021282 */     mul.s $f10, $f2, $f2
  /* 0115B4 800109B4 E7B20040 */      swc1 $f18, 0x40($sp)
  /* 0115B8 800109B8 460E7102 */     mul.s $f4, $f14, $f14
  /* 0115BC 800109BC E7AE003C */      swc1 $f14, 0x3c($sp)
  /* 0115C0 800109C0 0C00CD44 */       jal sqrtf
  /* 0115C4 800109C4 46045300 */     add.s $f12, $f10, $f4
  /* 0115C8 800109C8 44804000 */      mtc1 $zero, $f8
  /* 0115CC 800109CC 44806000 */      mtc1 $zero, $f12
  /* 0115D0 800109D0 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 0115D4 800109D4 46080032 */    c.eq.s $f0, $f8
  /* 0115D8 800109D8 44813000 */      mtc1 $at, $f6 # 1.0 to cop1
  /* 0115DC 800109DC 8FA5008C */        lw $a1, 0x8c($sp)
  /* 0115E0 800109E0 C7A20044 */      lwc1 $f2, 0x44($sp)
  /* 0115E4 800109E4 C7AE003C */      lwc1 $f14, 0x3c($sp)
  /* 0115E8 800109E8 C7B20040 */      lwc1 $f18, 0x40($sp)
  /* 0115EC 800109EC E7AC0074 */      swc1 $f12, 0x74($sp)
  /* 0115F0 800109F0 E7AC0064 */      swc1 $f12, 0x64($sp)
  /* 0115F4 800109F4 E7AC0054 */      swc1 $f12, 0x54($sp)
  /* 0115F8 800109F8 E7AC004C */      swc1 $f12, 0x4c($sp)
  /* 0115FC 800109FC 45010019 */      bc1t .L80010A64
  /* 011600 80010A00 E7A60084 */      swc1 $f6, 0x84($sp)
  /* 011604 80010A04 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 011608 80010A08 44812000 */      mtc1 $at, $f4 # 1.0 to cop1
  /* 01160C 80010A0C 46007287 */     neg.s $f10, $f14
  /* 011610 80010A10 46009307 */     neg.s $f12, $f18 #-vec.y
  /* 011614 80010A14 46002403 */     div.s $f16, $f4, $f0
  /* 011618 80010A18 E7AA0020 */      swc1 $f10, 0x20($sp) # -vec.x
  /* 01161C 80010A1C C7A60020 */      lwc1 $f6, 0x20($sp)
  /* 011620 80010A20 E7A0005C */      swc1 $f0, 0x5c($sp)
  /* 011624 80010A24 E7AC006C */      swc1 $f12, 0x6c($sp)
  /* 011628 80010A28 E7A60070 */      swc1 $f6, 0x70($sp)
  /* 01162C 80010A2C 46103202 */     mul.s $f8, $f6, $f16
  /* 011630 80010A30 00000000 */       nop 
  /* 011634 80010A34 46026282 */     mul.s $f10, $f12, $f2
  /* 011638 80010A38 E7A80048 */      swc1 $f8, 0x48($sp)
  /* 01163C 80010A3C 46001207 */     neg.s $f8, $f2 #-vec.z
  /* 011640 80010A40 46105102 */     mul.s $f4, $f10, $f16
  /* 011644 80010A44 E7A80068 */      swc1 $f8, 0x68($sp)
  /* 011648 80010A48 46101282 */     mul.s $f10, $f2, $f16
  /* 01164C 80010A4C E7A40058 */      swc1 $f4, 0x58($sp)
  /* 011650 80010A50 460E6102 */     mul.s $f4, $f12, $f14
  /* 011654 80010A54 E7AA0050 */      swc1 $f10, 0x50($sp)
  /* 011658 80010A58 46102202 */     mul.s $f8, $f4, $f16
  /* 01165C 80010A5C 1000000C */         b .L80010A90
  /* 011660 80010A60 E7A80060 */      swc1 $f8, 0x60($sp)
  .L80010A64:
  /* 011664 80010A64 44800000 */      mtc1 $zero, $f0
  /* 011668 80010A68 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 01166C 80010A6C 44811000 */      mtc1 $at, $f2 # 1.0 to cop1
  /* 011670 80010A70 E7A00050 */      swc1 $f0, 0x50($sp)
  /* 011674 80010A74 E7A0006C */      swc1 $f0, 0x6c($sp)
  /* 011678 80010A78 E7A00068 */      swc1 $f0, 0x68($sp)
  /* 01167C 80010A7C E7A00058 */      swc1 $f0, 0x58($sp)
  /* 011680 80010A80 E7A00060 */      swc1 $f0, 0x60($sp)
  /* 011684 80010A84 E7A2005C */      swc1 $f2, 0x5c($sp)
  /* 011688 80010A88 E7A20048 */      swc1 $f2, 0x48($sp)
  /* 01168C 80010A8C E7A20070 */      swc1 $f2, 0x70($sp)
  .L80010A90:
  /* 011690 80010A90 8FAF0090 */        lw $t7, 0x90($sp)
  /* 011694 80010A94 27A40048 */     addiu $a0, $sp, 0x48
  /* 011698 80010A98 51E00009 */      beql $t7, $zero, .L80010AC0
  /* 01169C 80010A9C 44801000 */      mtc1 $zero, $f2
  /* 0116A0 80010AA0 C4AA001C */      lwc1 $f10, 0x1c($a1)
  /* 0116A4 80010AA4 E7AA0078 */      swc1 $f10, 0x78($sp)
  /* 0116A8 80010AA8 C4A40020 */      lwc1 $f4, 0x20($a1)
  /* 0116AC 80010AAC E7A4007C */      swc1 $f4, 0x7c($sp)
  /* 0116B0 80010AB0 C4A80024 */      lwc1 $f8, 0x24($a1)
  /* 0116B4 80010AB4 10000006 */         b .L80010AD0
  /* 0116B8 80010AB8 E7A80080 */      swc1 $f8, 0x80($sp)
  /* 0116BC 80010ABC 44801000 */      mtc1 $zero, $f2
  .L80010AC0:
  /* 0116C0 80010AC0 00000000 */       nop 
  /* 0116C4 80010AC4 E7A2007C */      swc1 $f2, 0x7c($sp)
  /* 0116C8 80010AC8 E7A20078 */      swc1 $f2, 0x78($sp)
  /* 0116CC 80010ACC E7A20080 */      swc1 $f2, 0x80($sp)
  .L80010AD0:
  /* 0116D0 80010AD0 0C0067A8 */       jal hlMtxF2L_fixed_w
  /* 0116D4 80010AD4 8FA50088 */        lw $a1, 0x88($sp)
  /* 0116D8 80010AD8 8FBF0014 */        lw $ra, 0x14($sp)
  /* 0116DC 80010ADC 27BD0088 */     addiu $sp, $sp, 0x88
  /* 0116E0 80010AE0 03E00008 */        jr $ra
  /* 0116E4 80010AE4 00000000 */       nop 

