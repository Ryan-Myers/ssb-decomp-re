.section .text
glabel func_80003C00
  /* 004800 80003C00 3C048004 */       lui $a0, %hi(sContInfo)
  /* 004804 80003C04 3C058004 */       lui $a1, %hi(gPlayerControllerPortStatuses)
  /* 004808 80003C08 00001025 */        or $v0, $zero, $zero
  /* 00480C 80003C0C 24A551A4 */     addiu $a1, $a1, %lo(gPlayerControllerPortStatuses)
  /* 004810 80003C10 248451A8 */     addiu $a0, $a0, %lo(sContInfo)
  /* 004814 80003C14 00001825 */        or $v1, $zero, $zero
  .L80003C18:
  /* 004818 80003C18 908E001C */       lbu $t6, 0x1c($a0) # sContInfo + 28
  /* 00481C 80003C1C 00A27821 */      addu $t7, $a1, $v0
  /* 004820 80003C20 55C00004 */      bnel $t6, $zero, .L80003C34
  /* 004824 80003C24 24630001 */     addiu $v1, $v1, 1
  /* 004828 80003C28 A1E30000 */        sb $v1, ($t7)
  /* 00482C 80003C2C 24420001 */     addiu $v0, $v0, 1
  /* 004830 80003C30 24630001 */     addiu $v1, $v1, 1
  .L80003C34:
  /* 004834 80003C34 28610004 */      slti $at, $v1, 4
  /* 004838 80003C38 1420FFF7 */      bnez $at, .L80003C18
  /* 00483C 80003C3C 24840020 */     addiu $a0, $a0, 0x20

  /* 004840 80003C40 3C018004 */       lui $at, %hi(D_800451A0)
  /* 004844 80003C44 AC2251A0 */        sw $v0, %lo(D_800451A0)($at)

  /* 004848 80003C48 28410004 */      slti $at, $v0, 4
  /* 00484C 80003C4C 1020001B */      beqz $at, .L80003CBC
  
  /* 004850 80003C50 00401825 */        or $v1, $v0, $zero
  /* 004854 80003C54 24070004 */     addiu $a3, $zero, 4
  /* 004858 80003C58 00E23023 */      subu $a2, $a3, $v0
  /* 00485C 80003C5C 30C60003 */      andi $a2, $a2, 3
  /* 004860 80003C60 10C0000A */      beqz $a2, .L80003C8C
  /* 004864 80003C64 00C22821 */      addu $a1, $a2, $v0
  /* 004868 80003C68 3C188004 */       lui $t8, %hi(gPlayerControllerPortStatuses)
  /* 00486C 80003C6C 271851A4 */     addiu $t8, $t8, %lo(gPlayerControllerPortStatuses)
  /* 004870 80003C70 00582021 */      addu $a0, $v0, $t8
  /* 004874 80003C74 2402FFFF */     addiu $v0, $zero, -1
  .L80003C78:
  /* 004878 80003C78 24630001 */     addiu $v1, $v1, 1
  /* 00487C 80003C7C A0820000 */        sb $v0, ($a0) # sContInfo + 0
  /* 004880 80003C80 14A3FFFD */       bne $a1, $v1, .L80003C78
  /* 004884 80003C84 24840001 */     addiu $a0, $a0, 1
  
  /* 004888 80003C88 1067000C */       beq $v1, $a3, .L80003CBC
  .L80003C8C:
  /* 00488C 80003C8C 3C198004 */       lui $t9, %hi(gPlayerControllerPortStatuses)
  /* 004890 80003C90 273951A4 */     addiu $t9, $t9, %lo(gPlayerControllerPortStatuses)
  /* 004894 80003C94 00792021 */      addu $a0, $v1, $t9
  /* 004898 80003C98 3C038004 */       lui $v1, %hi(sContInfo)
  /* 00489C 80003C9C 246351A8 */     addiu $v1, $v1, %lo(sContInfo)
  /* 0048A0 80003CA0 2402FFFF */     addiu $v0, $zero, -1
  .L80003CA4:
  /* 0048A4 80003CA4 24840004 */     addiu $a0, $a0, 4
  /* 0048A8 80003CA8 A082FFFD */        sb $v0, -3($a0) # sContInfo + -3
  /* 0048AC 80003CAC A082FFFE */        sb $v0, -2($a0) # sContInfo + -2
  /* 0048B0 80003CB0 A082FFFF */        sb $v0, -1($a0) # sContInfo + -1
  /* 0048B4 80003CB4 1483FFFB */       bne $a0, $v1, .L80003CA4
  /* 0048B8 80003CB8 A082FFFC */        sb $v0, -4($a0) # sContInfo + -4
  .L80003CBC:
  /* 0048BC 80003CBC 03E00008 */        jr $ra
  /* 0048C0 80003CC0 00000000 */       nop 

