.include "macros.inc"

# assembler directives
.set noat      # allow manual use of $at
.set noreorder # don't insert nops after branches
.set gp=64     # allow use of 64-bit general purpose registers

.section .text

.align 4

glabel __osContRamWrite
  /* 036FB0 800363B0 27BDFF98 */     addiu $sp, $sp, -0x68
  /* 036FB4 800363B4 8FAF0078 */        lw $t7, 0x78($sp)
  /* 036FB8 800363B8 AFB5002C */        sw $s5, 0x2c($sp)
  /* 036FBC 800363BC AFB40028 */        sw $s4, 0x28($sp)
  /* 036FC0 800363C0 AFB1001C */        sw $s1, 0x1c($sp)
  /* 036FC4 800363C4 AFA60070 */        sw $a2, 0x70($sp)
  /* 036FC8 800363C8 30CEFFFF */      andi $t6, $a2, 0xffff
  /* 036FCC 800363CC 24010001 */     addiu $at, $zero, 1
  /* 036FD0 800363D0 01C03025 */        or $a2, $t6, $zero
  /* 036FD4 800363D4 00A08825 */        or $s1, $a1, $zero
  /* 036FD8 800363D8 0080A825 */        or $s5, $a0, $zero
  /* 036FDC 800363DC AFBF003C */        sw $ra, 0x3c($sp)
  /* 036FE0 800363E0 AFBE0038 */        sw $fp, 0x38($sp)
  /* 036FE4 800363E4 AFB70034 */        sw $s7, 0x34($sp)
  /* 036FE8 800363E8 AFB60030 */        sw $s6, 0x30($sp)
  /* 036FEC 800363EC AFB30024 */        sw $s3, 0x24($sp)
  /* 036FF0 800363F0 AFB20020 */        sw $s2, 0x20($sp)
  /* 036FF4 800363F4 AFB00018 */        sw $s0, 0x18($sp)
  /* 036FF8 800363F8 AFA70074 */        sw $a3, 0x74($sp)
  /* 036FFC 800363FC 11E10008 */       beq $t7, $at, .L80036420
  /* 037000 80036400 24140002 */     addiu $s4, $zero, 2
  /* 037004 80036404 29C10007 */      slti $at, $t6, 7
  /* 037008 80036408 50200006 */      beql $at, $zero, .L80036424
  /* 03700C 8003640C 00C08025 */        or $s0, $a2, $zero
  /* 037010 80036410 51C00004 */      beql $t6, $zero, .L80036424
  /* 037014 80036414 00C08025 */        or $s0, $a2, $zero
  /* 037018 80036418 1000006C */         b .L800365CC
  /* 03701C 8003641C 00001025 */        or $v0, $zero, $zero
  .L80036420:
  /* 037020 80036420 00C08025 */        or $s0, $a2, $zero
  .L80036424:
  /* 037024 80036424 0C00C69C */       jal __osSiGetAccess
  /* 037028 80036428 A7A60072 */        sh $a2, 0x72($sp)
  /* 03702C 8003642C 0010C0C3 */       sra $t8, $s0, 3
  /* 037030 80036430 0010C940 */       sll $t9, $s0, 5
  /* 037034 80036434 3C178004 */       lui $s7, %hi(D_8003D5E0)
  /* 037038 80036438 3C16800A */       lui $s6, %hi(__osContLastCmd)
  /* 03703C 8003643C 3C13800A */       lui $s3, %hi(__osPfsPifRam)
  /* 037040 80036440 26730710 */     addiu $s3, $s3, %lo(__osPfsPifRam)
  /* 037044 80036444 26D6EFE0 */     addiu $s6, $s6, %lo(__osContLastCmd)
  /* 037048 80036448 26F7D5E0 */     addiu $s7, $s7, %lo(D_8003D5E0)
  /* 03704C 8003644C AFB90040 */        sw $t9, 0x40($sp)
  /* 037050 80036450 AFB80044 */        sw $t8, 0x44($sp)
  /* 037054 80036454 241E0003 */     addiu $fp, $zero, 3
  .L80036458:
  /* 037058 80036458 92C80000 */       lbu $t0, ($s6) # __osContLastCmd + 0
  /* 03705C 8003645C 24010003 */     addiu $at, $zero, 3
  /* 037060 80036460 02608025 */        or $s0, $s3, $zero
  /* 037064 80036464 15010004 */       bne $t0, $at, .L80036478
  /* 037068 80036468 00001025 */        or $v0, $zero, $zero
  /* 03706C 8003646C 8EE90000 */        lw $t1, ($s7) # D_8003D5E0 + 0
  /* 037070 80036470 52290022 */      beql $s1, $t1, .L800364FC
  /* 037074 80036474 02718021 */      addu $s0, $s3, $s1
  .L80036478:
  /* 037078 80036478 A2DE0000 */        sb $fp, ($s6) # __osContLastCmd + 0
  /* 03707C 8003647C 1A200010 */      blez $s1, .L800364C0
  /* 037080 80036480 AEF10000 */        sw $s1, ($s7) # D_8003D5E0 + 0
  /* 037084 80036484 32240003 */      andi $a0, $s1, 3
  /* 037088 80036488 10800006 */      beqz $a0, .L800364A4
  /* 03708C 8003648C 00801825 */        or $v1, $a0, $zero
  .L80036490:
  /* 037090 80036490 24420001 */     addiu $v0, $v0, 1
  /* 037094 80036494 A2000000 */        sb $zero, ($s0)
  /* 037098 80036498 1462FFFD */       bne $v1, $v0, .L80036490
  /* 03709C 8003649C 26100001 */     addiu $s0, $s0, 1
  /* 0370A0 800364A0 10510007 */       beq $v0, $s1, .L800364C0
  .L800364A4:
  /* 0370A4 800364A4 24420004 */     addiu $v0, $v0, 4
  /* 0370A8 800364A8 A2000000 */        sb $zero, ($s0)
  /* 0370AC 800364AC A2000001 */        sb $zero, 1($s0)
  /* 0370B0 800364B0 A2000002 */        sb $zero, 2($s0)
  /* 0370B4 800364B4 A2000003 */        sb $zero, 3($s0)
  /* 0370B8 800364B8 1451FFFA */       bne $v0, $s1, .L800364A4
  /* 0370BC 800364BC 26100004 */     addiu $s0, $s0, 4
  .L800364C0:
  /* 0370C0 800364C0 240A0001 */     addiu $t2, $zero, 1
  /* 0370C4 800364C4 AE6A003C */        sw $t2, 0x3c($s3) # __osPfsPifRam + 60
  /* 0370C8 800364C8 240B00FF */     addiu $t3, $zero, 0xff
  /* 0370CC 800364CC 240C0023 */     addiu $t4, $zero, 0x23
  /* 0370D0 800364D0 240D0001 */     addiu $t5, $zero, 1
  /* 0370D4 800364D4 240E00FF */     addiu $t6, $zero, 0xff
  /* 0370D8 800364D8 240F00FE */     addiu $t7, $zero, 0xfe
  /* 0370DC 800364DC A20B0000 */        sb $t3, ($s0)
  /* 0370E0 800364E0 A20C0001 */        sb $t4, 1($s0)
  /* 0370E4 800364E4 A20D0002 */        sb $t5, 2($s0)
  /* 0370E8 800364E8 A21E0003 */        sb $fp, 3($s0)
  /* 0370EC 800364EC A20E0026 */        sb $t6, 0x26($s0)
  /* 0370F0 800364F0 10000002 */         b .L800364FC
  /* 0370F4 800364F4 A20F0027 */        sb $t7, 0x27($s0)
  /* 0370F8 800364F8 02718021 */      addu $s0, $s3, $s1
  .L800364FC:
  /* 0370FC 800364FC 8FB80044 */        lw $t8, 0x44($sp)
  /* 037100 80036500 A2180004 */        sb $t8, 4($s0)
  /* 037104 80036504 0C00DDC0 */       jal __osContAddressCrc
  /* 037108 80036508 97A40072 */       lhu $a0, 0x72($sp)
  /* 03710C 8003650C 8FB90040 */        lw $t9, 0x40($sp)
  /* 037110 80036510 26050006 */     addiu $a1, $s0, 6
  /* 037114 80036514 24060020 */     addiu $a2, $zero, 0x20
  /* 037118 80036518 00594025 */        or $t0, $v0, $t9
  /* 03711C 8003651C A2080005 */        sb $t0, 5($s0)
  /* 037120 80036520 0C00D50C */       jal _bcopy
  /* 037124 80036524 8FA40074 */        lw $a0, 0x74($sp)
  /* 037128 80036528 24040001 */     addiu $a0, $zero, 1
  /* 03712C 8003652C 0C00C9D8 */       jal __osSiRawStartDma
  /* 037130 80036530 02602825 */        or $a1, $s3, $zero
  /* 037134 80036534 0C00DDF4 */       jal __osContDataCrc
  /* 037138 80036538 8FA40074 */        lw $a0, 0x74($sp)
  /* 03713C 8003653C 305200FF */      andi $s2, $v0, 0xff
  /* 037140 80036540 02A02025 */        or $a0, $s5, $zero
  /* 037144 80036544 00002825 */        or $a1, $zero, $zero
  /* 037148 80036548 0C00C084 */       jal osRecvMesg
  /* 03714C 8003654C 24060001 */     addiu $a2, $zero, 1
  /* 037150 80036550 00002025 */        or $a0, $zero, $zero
  /* 037154 80036554 0C00C9D8 */       jal __osSiRawStartDma
  /* 037158 80036558 02602825 */        or $a1, $s3, $zero
  /* 03715C 8003655C 02A02025 */        or $a0, $s5, $zero
  /* 037160 80036560 00002825 */        or $a1, $zero, $zero
  /* 037164 80036564 0C00C084 */       jal osRecvMesg
  /* 037168 80036568 24060001 */     addiu $a2, $zero, 1
  /* 03716C 8003656C 92030002 */       lbu $v1, 2($s0)
  /* 037170 80036570 306900C0 */      andi $t1, $v1, 0xc0
  /* 037174 80036574 00091903 */       sra $v1, $t1, 4
  /* 037178 80036578 5460000C */      bnel $v1, $zero, .L800365AC
  /* 03717C 8003657C 24030001 */     addiu $v1, $zero, 1
  /* 037180 80036580 920B0026 */       lbu $t3, 0x26($s0)
  /* 037184 80036584 02A02025 */        or $a0, $s5, $zero
  /* 037188 80036588 51720009 */      beql $t3, $s2, .L800365B0
  /* 03718C 8003658C 24010004 */     addiu $at, $zero, 4
  /* 037190 80036590 0C00D980 */       jal __osPfsGetStatus
  /* 037194 80036594 02202825 */        or $a1, $s1, $zero
  /* 037198 80036598 14400009 */      bnez $v0, .L800365C0
  /* 03719C 8003659C 00401825 */        or $v1, $v0, $zero
  /* 0371A0 800365A0 10000002 */         b .L800365AC
  /* 0371A4 800365A4 24030004 */     addiu $v1, $zero, 4
  /* 0371A8 800365A8 24030001 */     addiu $v1, $zero, 1
  .L800365AC:
  /* 0371AC 800365AC 24010004 */     addiu $at, $zero, 4
  .L800365B0:
  /* 0371B0 800365B0 14610003 */       bne $v1, $at, .L800365C0
  /* 0371B4 800365B4 2A820000 */      slti $v0, $s4, 0
  /* 0371B8 800365B8 1040FFA7 */      beqz $v0, .L80036458
  /* 0371BC 800365BC 2694FFFF */     addiu $s4, $s4, -1
  .L800365C0:
  /* 0371C0 800365C0 0C00C6AD */       jal __osSiRelAccess
  /* 0371C4 800365C4 AFA30064 */        sw $v1, 0x64($sp)
  /* 0371C8 800365C8 8FA20064 */        lw $v0, 0x64($sp)
  .L800365CC:
  /* 0371CC 800365CC 8FBF003C */        lw $ra, 0x3c($sp)
  /* 0371D0 800365D0 8FB00018 */        lw $s0, 0x18($sp)
  /* 0371D4 800365D4 8FB1001C */        lw $s1, 0x1c($sp)
  /* 0371D8 800365D8 8FB20020 */        lw $s2, 0x20($sp)
  /* 0371DC 800365DC 8FB30024 */        lw $s3, 0x24($sp)
  /* 0371E0 800365E0 8FB40028 */        lw $s4, 0x28($sp)
  /* 0371E4 800365E4 8FB5002C */        lw $s5, 0x2c($sp)
  /* 0371E8 800365E8 8FB60030 */        lw $s6, 0x30($sp)
  /* 0371EC 800365EC 8FB70034 */        lw $s7, 0x34($sp)
  /* 0371F0 800365F0 8FBE0038 */        lw $fp, 0x38($sp)
  /* 0371F4 800365F4 03E00008 */        jr $ra
  /* 0371F8 800365F8 27BD0068 */     addiu $sp, $sp, 0x68

  /* 0371FC 800365FC 00000000 */       nop 