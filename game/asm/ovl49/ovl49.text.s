.include "macros.inc"

# assembler directives
.set noat      # allow manual use of $at
.set noreorder # don't insert nops after branches
.set gp=64     # allow use of 64-bit general purpose registers

.section .text

.align 4

# Text Sections
#  0x80131B00 -> 0x801328D0

glabel func_ovl49_80131B00
  /* 172B60 80131B00 27BDFFD8 */     addiu $sp, $sp, -0x28
  /* 172B64 80131B04 AFBF0014 */        sw $ra, 0x14($sp)
  /* 172B68 80131B08 8C830000 */        lw $v1, ($a0)
  /* 172B6C 80131B0C 3C0FD9FF */       lui $t7, (0xD9FFFFFF >> 16) # 3657433087
  /* 172B70 80131B10 35EFFFFF */       ori $t7, $t7, (0xD9FFFFFF & 0xFFFF) # 3657433087
  /* 172B74 80131B14 246E0008 */     addiu $t6, $v1, 8
  /* 172B78 80131B18 AC8E0000 */        sw $t6, ($a0)
  /* 172B7C 80131B1C 3C180002 */       lui $t8, 2
  /* 172B80 80131B20 AC780004 */        sw $t8, 4($v1)
  /* 172B84 80131B24 AC6F0000 */        sw $t7, ($v1)
  /* 172B88 80131B28 0C0E4147 */       jal func_ovl1_8039051C
  /* 172B8C 80131B2C AFA40028 */        sw $a0, 0x28($sp)
  /* 172B90 80131B30 0C0E414A */       jal func_ovl1_80390528
  /* 172B94 80131B34 E7A0001C */      swc1 $f0, 0x1c($sp)
  /* 172B98 80131B38 44060000 */      mfc1 $a2, $f0
  /* 172B9C 80131B3C 8FA40028 */        lw $a0, 0x28($sp)
  /* 172BA0 80131B40 0C03F2DC */       jal ftRender_Lights_DisplayLightReflect
  /* 172BA4 80131B44 8FA5001C */        lw $a1, 0x1c($sp)
  /* 172BA8 80131B48 8FBF0014 */        lw $ra, 0x14($sp)
  /* 172BAC 80131B4C 27BD0028 */     addiu $sp, $sp, 0x28
  /* 172BB0 80131B50 03E00008 */        jr $ra
  /* 172BB4 80131B54 00000000 */       nop 

  /* 172BB8 80131B58 03E00008 */        jr $ra
  /* 172BBC 80131B5C 00000000 */       nop 

glabel func_ovl49_80131B60
  /* 172BC0 80131B60 27BDFF50 */     addiu $sp, $sp, -0xb0
  /* 172BC4 80131B64 3C0F8013 */       lui $t7, %hi(D_ovl49_80132908)
  /* 172BC8 80131B68 AFBF003C */        sw $ra, 0x3c($sp)
  /* 172BCC 80131B6C AFB50038 */        sw $s5, 0x38($sp)
  /* 172BD0 80131B70 AFB40034 */        sw $s4, 0x34($sp)
  /* 172BD4 80131B74 AFB30030 */        sw $s3, 0x30($sp)
  /* 172BD8 80131B78 AFB2002C */        sw $s2, 0x2c($sp)
  /* 172BDC 80131B7C AFB10028 */        sw $s1, 0x28($sp)
  /* 172BE0 80131B80 AFB00024 */        sw $s0, 0x24($sp)
  /* 172BE4 80131B84 F7B60018 */      sdc1 $f22, 0x18($sp)
  /* 172BE8 80131B88 F7B40010 */      sdc1 $f20, 0x10($sp)
  /* 172BEC 80131B8C 25EF2908 */     addiu $t7, $t7, %lo(D_ovl49_80132908)
  /* 172BF0 80131B90 8DF90000 */        lw $t9, ($t7) # D_ovl49_80132908 + 0
  /* 172BF4 80131B94 8DF80004 */        lw $t8, 4($t7) # D_ovl49_80132908 + 4
  /* 172BF8 80131B98 27AE008C */     addiu $t6, $sp, 0x8c
  /* 172BFC 80131B9C ADD90000 */        sw $t9, ($t6)
  /* 172C00 80131BA0 ADD80004 */        sw $t8, 4($t6)
  /* 172C04 80131BA4 8DF8000C */        lw $t8, 0xc($t7) # D_ovl49_80132908 + 12
  /* 172C08 80131BA8 8DF90008 */        lw $t9, 8($t7) # D_ovl49_80132908 + 8
  /* 172C0C 80131BAC 3C088011 */       lui $t0, %hi(dFighterDefaultSpawn)
  /* 172C10 80131BB0 ADD8000C */        sw $t8, 0xc($t6)
  /* 172C14 80131BB4 ADD90008 */        sw $t9, 8($t6)
  /* 172C18 80131BB8 8DF90010 */        lw $t9, 0x10($t7) # D_ovl49_80132908 + 16
  /* 172C1C 80131BBC 8DF80014 */        lw $t8, 0x14($t7) # D_ovl49_80132908 + 20
  /* 172C20 80131BC0 27B30048 */     addiu $s3, $sp, 0x48
  /* 172C24 80131BC4 ADD90010 */        sw $t9, 0x10($t6)
  /* 172C28 80131BC8 ADD80014 */        sw $t8, 0x14($t6)
  /* 172C2C 80131BCC 8DF8001C */        lw $t8, 0x1c($t7) # D_ovl49_80132908 + 28
  /* 172C30 80131BD0 8DF90018 */        lw $t9, 0x18($t7) # D_ovl49_80132908 + 24
  /* 172C34 80131BD4 25086DD0 */     addiu $t0, $t0, %lo(dFighterDefaultSpawn)
  /* 172C38 80131BD8 250C003C */     addiu $t4, $t0, 0x3c
  /* 172C3C 80131BDC 02605825 */        or $t3, $s3, $zero
  /* 172C40 80131BE0 ADD8001C */        sw $t8, 0x1c($t6)
  /* 172C44 80131BE4 ADD90018 */        sw $t9, 0x18($t6)
  .L80131BE8:
  /* 172C48 80131BE8 8D0A0000 */        lw $t2, ($t0) # dFighterDefaultSpawn + 0
  /* 172C4C 80131BEC 2508000C */     addiu $t0, $t0, 0xc
  /* 172C50 80131BF0 256B000C */     addiu $t3, $t3, 0xc
  /* 172C54 80131BF4 AD6AFFF4 */        sw $t2, -0xc($t3)
  /* 172C58 80131BF8 8D09FFF8 */        lw $t1, -8($t0) # dFighterDefaultSpawn + -8
  /* 172C5C 80131BFC AD69FFF8 */        sw $t1, -8($t3)
  /* 172C60 80131C00 8D0AFFFC */        lw $t2, -4($t0) # dFighterDefaultSpawn + -4
  /* 172C64 80131C04 150CFFF8 */       bne $t0, $t4, .L80131BE8
  /* 172C68 80131C08 AD6AFFFC */        sw $t2, -4($t3)
  /* 172C6C 80131C0C 8D0A0000 */        lw $t2, ($t0) # dFighterDefaultSpawn + 0
  /* 172C70 80131C10 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 172C74 80131C14 3C108013 */       lui $s0, %hi(D_ovl49_801329D8)
  /* 172C78 80131C18 3C158013 */       lui $s5, %hi(D_ovl49_801329F8)
  /* 172C7C 80131C1C 3C140001 */       lui $s4, (0x1000B >> 16) # 65547
  /* 172C80 80131C20 4481B000 */      mtc1 $at, $f22 # 1.0 to cop1
  /* 172C84 80131C24 4480A000 */      mtc1 $zero, $f20
  /* 172C88 80131C28 3694000B */       ori $s4, $s4, (0x1000B & 0xFFFF) # 65547
  /* 172C8C 80131C2C 26B529F8 */     addiu $s5, $s5, %lo(D_ovl49_801329F8)
  /* 172C90 80131C30 261029D8 */     addiu $s0, $s0, %lo(D_ovl49_801329D8)
  /* 172C94 80131C34 27B2008C */     addiu $s2, $sp, 0x8c
  /* 172C98 80131C38 AD6A0000 */        sw $t2, ($t3)
  .L80131C3C:
  /* 172C9C 80131C3C 8E440000 */        lw $a0, ($s2)
  /* 172CA0 80131C40 00002825 */        or $a1, $zero, $zero
  /* 172CA4 80131C44 0C03B03B */       jal ftCostume_GetIndexFFA
  /* 172CA8 80131C48 AFA40048 */        sw $a0, 0x48($sp)
  /* 172CAC 80131C4C 8E0D0000 */        lw $t5, ($s0) # D_ovl49_801329D8 + 0
  /* 172CB0 80131C50 A3A2005F */        sb $v0, 0x5f($sp)
  /* 172CB4 80131C54 E7B4004C */      swc1 $f20, 0x4c($sp)
  /* 172CB8 80131C58 E7B40050 */      swc1 $f20, 0x50($sp)
  /* 172CBC 80131C5C E7B40054 */      swc1 $f20, 0x54($sp)
  /* 172CC0 80131C60 02602025 */        or $a0, $s3, $zero
  /* 172CC4 80131C64 0C035FCF */       jal ftManager_MakeFighter
  /* 172CC8 80131C68 AFAD0080 */        sw $t5, 0x80($sp)
  /* 172CCC 80131C6C 00408825 */        or $s1, $v0, $zero
  /* 172CD0 80131C70 00402025 */        or $a0, $v0, $zero
  /* 172CD4 80131C74 0C0E4173 */       jal func_ovl1_803905CC
  /* 172CD8 80131C78 02802825 */        or $a1, $s4, $zero
  /* 172CDC 80131C7C 8E2E0074 */        lw $t6, 0x74($s1)
  /* 172CE0 80131C80 26100004 */     addiu $s0, $s0, 4
  /* 172CE4 80131C84 26520004 */     addiu $s2, $s2, 4
  /* 172CE8 80131C88 E5D60040 */      swc1 $f22, 0x40($t6)
  /* 172CEC 80131C8C 8E2F0074 */        lw $t7, 0x74($s1)
  /* 172CF0 80131C90 E5F60044 */      swc1 $f22, 0x44($t7)
  /* 172CF4 80131C94 8E380074 */        lw $t8, 0x74($s1)
  /* 172CF8 80131C98 1615FFE8 */       bne $s0, $s5, .L80131C3C
  /* 172CFC 80131C9C E7160048 */      swc1 $f22, 0x48($t8)
  /* 172D00 80131CA0 8FBF003C */        lw $ra, 0x3c($sp)
  /* 172D04 80131CA4 D7B40010 */      ldc1 $f20, 0x10($sp)
  /* 172D08 80131CA8 D7B60018 */      ldc1 $f22, 0x18($sp)
  /* 172D0C 80131CAC 8FB00024 */        lw $s0, 0x24($sp)
  /* 172D10 80131CB0 8FB10028 */        lw $s1, 0x28($sp)
  /* 172D14 80131CB4 8FB2002C */        lw $s2, 0x2c($sp)
  /* 172D18 80131CB8 8FB30030 */        lw $s3, 0x30($sp)
  /* 172D1C 80131CBC 8FB40034 */        lw $s4, 0x34($sp)
  /* 172D20 80131CC0 8FB50038 */        lw $s5, 0x38($sp)
  /* 172D24 80131CC4 03E00008 */        jr $ra
  /* 172D28 80131CC8 27BD00B0 */     addiu $sp, $sp, 0xb0

glabel func_ovl49_80131CCC
  /* 172D2C 80131CCC 3C028013 */       lui $v0, %hi(D_ovl49_80132A0C)
  /* 172D30 80131CD0 24422A0C */     addiu $v0, $v0, %lo(D_ovl49_80132A0C)
  /* 172D34 80131CD4 8C430000 */        lw $v1, ($v0) # D_ovl49_80132A0C + 0
  /* 172D38 80131CD8 3C0C8004 */       lui $t4, %hi(gDisplayListHead)
  /* 172D3C 80131CDC AFA40000 */        sw $a0, ($sp)
  /* 172D40 80131CE0 286100FF */      slti $at, $v1, 0xff
  /* 172D44 80131CE4 10200007 */      beqz $at, .L80131D04
  /* 172D48 80131CE8 258C65B0 */     addiu $t4, $t4, %lo(gDisplayListHead)
  /* 172D4C 80131CEC 246E001E */     addiu $t6, $v1, 0x1e
  /* 172D50 80131CF0 29C10100 */      slti $at, $t6, 0x100
  /* 172D54 80131CF4 14200003 */      bnez $at, .L80131D04
  /* 172D58 80131CF8 AC4E0000 */        sw $t6, ($v0) # D_ovl49_80132A0C + 0
  /* 172D5C 80131CFC 241800FF */     addiu $t8, $zero, 0xff
  /* 172D60 80131D00 AC580000 */        sw $t8, ($v0) # D_ovl49_80132A0C + 0
  .L80131D04:
  /* 172D64 80131D04 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172D68 80131D08 3C0DE700 */       lui $t5, 0xe700
  /* 172D6C 80131D0C 3C0FE300 */       lui $t7, (0xE3000A01 >> 16) # 3808430593
  /* 172D70 80131D10 24990008 */     addiu $t9, $a0, 8
  /* 172D74 80131D14 AD990000 */        sw $t9, ($t4) # gDisplayListHead + 0
  /* 172D78 80131D18 AC800004 */        sw $zero, 4($a0)
  /* 172D7C 80131D1C AC8D0000 */        sw $t5, ($a0)
  /* 172D80 80131D20 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172D84 80131D24 35EF0A01 */       ori $t7, $t7, (0xE3000A01 & 0xFFFF) # 3808430593
  /* 172D88 80131D28 3C19FA00 */       lui $t9, 0xfa00
  /* 172D8C 80131D2C 248E0008 */     addiu $t6, $a0, 8
  /* 172D90 80131D30 AD8E0000 */        sw $t6, ($t4) # gDisplayListHead + 0
  /* 172D94 80131D34 AC800004 */        sw $zero, 4($a0)
  /* 172D98 80131D38 AC8F0000 */        sw $t7, ($a0)
  /* 172D9C 80131D3C 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172DA0 80131D40 2401FF00 */     addiu $at, $zero, -0x100
  /* 172DA4 80131D44 24980008 */     addiu $t8, $a0, 8
  /* 172DA8 80131D48 AD980000 */        sw $t8, ($t4) # gDisplayListHead + 0
  /* 172DAC 80131D4C AC990000 */        sw $t9, ($a0)
  /* 172DB0 80131D50 8C4E0000 */        lw $t6, ($v0) # D_ovl49_80132A0C + 0
  /* 172DB4 80131D54 31CF00FF */      andi $t7, $t6, 0xff
  /* 172DB8 80131D58 01E1C025 */        or $t8, $t7, $at
  /* 172DBC 80131D5C AC980004 */        sw $t8, 4($a0)
  /* 172DC0 80131D60 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172DC4 80131D64 3C0FFFFD */       lui $t7, (0xFFFDF6FB >> 16) # 4294833915
  /* 172DC8 80131D68 3C0EFCFF */       lui $t6, (0xFCFFFFFF >> 16) # 4244635647
  /* 172DCC 80131D6C 24990008 */     addiu $t9, $a0, 8
  /* 172DD0 80131D70 AD990000 */        sw $t9, ($t4) # gDisplayListHead + 0
  /* 172DD4 80131D74 35CEFFFF */       ori $t6, $t6, (0xFCFFFFFF & 0xFFFF) # 4244635647
  /* 172DD8 80131D78 35EFF6FB */       ori $t7, $t7, (0xFFFDF6FB & 0xFFFF) # 4294833915
  /* 172DDC 80131D7C AC8F0004 */        sw $t7, 4($a0)
  /* 172DE0 80131D80 AC8E0000 */        sw $t6, ($a0)
  /* 172DE4 80131D84 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172DE8 80131D88 3C0E0050 */       lui $t6, (0x5041C8 >> 16) # 5259720
  /* 172DEC 80131D8C 3C19E200 */       lui $t9, (0xE200001C >> 16) # 3791650844
  /* 172DF0 80131D90 24980008 */     addiu $t8, $a0, 8
  /* 172DF4 80131D94 AD980000 */        sw $t8, ($t4) # gDisplayListHead + 0
  /* 172DF8 80131D98 3739001C */       ori $t9, $t9, (0xE200001C & 0xFFFF) # 3791650844
  /* 172DFC 80131D9C 35CE41C8 */       ori $t6, $t6, (0x5041C8 & 0xFFFF) # 5259720
  /* 172E00 80131DA0 AC8E0004 */        sw $t6, 4($a0)
  /* 172E04 80131DA4 AC990000 */        sw $t9, ($a0)
  /* 172E08 80131DA8 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172E0C 80131DAC 3C190002 */       lui $t9, (0x28028 >> 16) # 163880
  /* 172E10 80131DB0 3C18F64D */       lui $t8, (0xF64D8398 >> 16) # 4132275096
  /* 172E14 80131DB4 248F0008 */     addiu $t7, $a0, 8
  /* 172E18 80131DB8 AD8F0000 */        sw $t7, ($t4) # gDisplayListHead + 0
  /* 172E1C 80131DBC 37188398 */       ori $t8, $t8, (0xF64D8398 & 0xFFFF) # 4132275096
  /* 172E20 80131DC0 37398028 */       ori $t9, $t9, (0x28028 & 0xFFFF) # 163880
  /* 172E24 80131DC4 AC990004 */        sw $t9, 4($a0)
  /* 172E28 80131DC8 AC980000 */        sw $t8, ($a0)
  /* 172E2C 80131DCC 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172E30 80131DD0 3C18E200 */       lui $t8, (0xE200001C >> 16) # 3791650844
  /* 172E34 80131DD4 3C190055 */       lui $t9, (0x552078 >> 16) # 5578872
  /* 172E38 80131DD8 248E0008 */     addiu $t6, $a0, 8
  /* 172E3C 80131DDC AD8E0000 */        sw $t6, ($t4) # gDisplayListHead + 0
  /* 172E40 80131DE0 AC800004 */        sw $zero, 4($a0)
  /* 172E44 80131DE4 AC8D0000 */        sw $t5, ($a0)
  /* 172E48 80131DE8 8D840000 */        lw $a0, ($t4) # gDisplayListHead + 0
  /* 172E4C 80131DEC 37392078 */       ori $t9, $t9, (0x552078 & 0xFFFF) # 5578872
  /* 172E50 80131DF0 3718001C */       ori $t8, $t8, (0xE200001C & 0xFFFF) # 3791650844
  /* 172E54 80131DF4 248F0008 */     addiu $t7, $a0, 8
  /* 172E58 80131DF8 AD8F0000 */        sw $t7, ($t4) # gDisplayListHead + 0
  /* 172E5C 80131DFC AC990004 */        sw $t9, 4($a0)
  /* 172E60 80131E00 03E00008 */        jr $ra
  /* 172E64 80131E04 AC980000 */        sw $t8, ($a0)

glabel func_ovl49_80131E08
  /* 172E68 80131E08 27BDFFE0 */     addiu $sp, $sp, -0x20
  /* 172E6C 80131E0C AFBF001C */        sw $ra, 0x1c($sp)
  /* 172E70 80131E10 3C018013 */       lui $at, %hi(D_ovl49_80132A0C)
  /* 172E74 80131E14 AC202A0C */        sw $zero, %lo(D_ovl49_80132A0C)($at)
  /* 172E78 80131E18 00002025 */        or $a0, $zero, $zero
  /* 172E7C 80131E1C 00002825 */        or $a1, $zero, $zero
  /* 172E80 80131E20 24060012 */     addiu $a2, $zero, 0x12
  /* 172E84 80131E24 0C00265A */       jal omMakeGObjCommon
  /* 172E88 80131E28 3C078000 */       lui $a3, 0x8000
  /* 172E8C 80131E2C 3C058013 */       lui $a1, %hi(func_ovl49_80131CCC)
  /* 172E90 80131E30 240EFFFF */     addiu $t6, $zero, -1
  /* 172E94 80131E34 AFAE0010 */        sw $t6, 0x10($sp)
  /* 172E98 80131E38 24A51CCC */     addiu $a1, $a1, %lo(func_ovl49_80131CCC)
  /* 172E9C 80131E3C 00402025 */        or $a0, $v0, $zero
  /* 172EA0 80131E40 2406001A */     addiu $a2, $zero, 0x1a
  /* 172EA4 80131E44 0C00277D */       jal omAddGObjRenderProc
  /* 172EA8 80131E48 3C078000 */       lui $a3, 0x8000
  /* 172EAC 80131E4C 8FBF001C */        lw $ra, 0x1c($sp)
  /* 172EB0 80131E50 27BD0020 */     addiu $sp, $sp, 0x20
  /* 172EB4 80131E54 03E00008 */        jr $ra
  /* 172EB8 80131E58 00000000 */       nop 

glabel func_ovl49_80131E5C
  /* 172EBC 80131E5C 27BDFFC0 */     addiu $sp, $sp, -0x40
  /* 172EC0 80131E60 AFBF002C */        sw $ra, 0x2c($sp)
  /* 172EC4 80131E64 AFB10028 */        sw $s1, 0x28($sp)
  /* 172EC8 80131E68 AFB00024 */        sw $s0, 0x24($sp)
  /* 172ECC 80131E6C F7B40018 */      sdc1 $f20, 0x18($sp)
  /* 172ED0 80131E70 00002025 */        or $a0, $zero, $zero
  /* 172ED4 80131E74 00002825 */        or $a1, $zero, $zero
  /* 172ED8 80131E78 24060014 */     addiu $a2, $zero, 0x14
  /* 172EDC 80131E7C 0C00265A */       jal omMakeGObjCommon
  /* 172EE0 80131E80 3C078000 */       lui $a3, 0x8000
  /* 172EE4 80131E84 3C058001 */       lui $a1, %hi(func_80013E68)
  /* 172EE8 80131E88 24A53E68 */     addiu $a1, $a1, %lo(func_80013E68)
  /* 172EEC 80131E8C 240EFFFF */     addiu $t6, $zero, -1
  /* 172EF0 80131E90 00408025 */        or $s0, $v0, $zero
  /* 172EF4 80131E94 AFAE0010 */        sw $t6, 0x10($sp)
  /* 172EF8 80131E98 AFA50034 */        sw $a1, 0x34($sp)
  /* 172EFC 80131E9C 00402025 */        or $a0, $v0, $zero
  /* 172F00 80131EA0 2406001D */     addiu $a2, $zero, 0x1d
  /* 172F04 80131EA4 0C00277D */       jal omAddGObjRenderProc
  /* 172F08 80131EA8 3C078000 */       lui $a3, 0x8000
  /* 172F0C 80131EAC 3C118013 */       lui $s1, %hi(D_ovl49_80132D70)
  /* 172F10 80131EB0 26312D70 */     addiu $s1, $s1, %lo(D_ovl49_80132D70)
  /* 172F14 80131EB4 8E2F0004 */        lw $t7, 4($s1) # D_ovl49_80132D70 + 4
  /* 172F18 80131EB8 3C180000 */       lui $t8, %hi(D_NF_000032A8)
  /* 172F1C 80131EBC 271832A8 */     addiu $t8, $t8, %lo(D_NF_000032A8)
  /* 172F20 80131EC0 02002025 */        or $a0, $s0, $zero
  /* 172F24 80131EC4 0C0024B4 */       jal omAddDObjForGObj
  /* 172F28 80131EC8 01F82821 */      addu $a1, $t7, $t8
  /* 172F2C 80131ECC 00402025 */        or $a0, $v0, $zero
  /* 172F30 80131ED0 2405001C */     addiu $a1, $zero, 0x1c
  /* 172F34 80131ED4 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 172F38 80131ED8 00003025 */        or $a2, $zero, $zero
  /* 172F3C 80131EDC 8E390004 */        lw $t9, 4($s1) # D_ovl49_80132D70 + 4
  /* 172F40 80131EE0 3C080000 */       lui $t0, %hi(D_NF_00003050)
  /* 172F44 80131EE4 25083050 */     addiu $t0, $t0, %lo(D_NF_00003050)
  /* 172F48 80131EE8 02002025 */        or $a0, $s0, $zero
  /* 172F4C 80131EEC 0C003E3D */       jal func_8000F8F4
  /* 172F50 80131EF0 03282821 */      addu $a1, $t9, $t0
  /* 172F54 80131EF4 4480A000 */      mtc1 $zero, $f20
  /* 172F58 80131EF8 8E290004 */        lw $t1, 4($s1) # D_ovl49_80132D70 + 4
  /* 172F5C 80131EFC 3C0A0000 */       lui $t2, %hi(D_NF_00003458)
  /* 172F60 80131F00 254A3458 */     addiu $t2, $t2, %lo(D_NF_00003458)
  /* 172F64 80131F04 4406A000 */      mfc1 $a2, $f20
  /* 172F68 80131F08 02002025 */        or $a0, $s0, $zero
  /* 172F6C 80131F0C 0C002F8A */       jal func_8000BE28
  /* 172F70 80131F10 012A2821 */      addu $a1, $t1, $t2
  /* 172F74 80131F14 8E0B0074 */        lw $t3, 0x74($s0)
  /* 172F78 80131F18 3C0F0000 */       lui $t7, %hi(D_NF_000036D0)
  /* 172F7C 80131F1C 25EF36D0 */     addiu $t7, $t7, %lo(D_NF_000036D0)
  /* 172F80 80131F20 E574001C */      swc1 $f20, 0x1c($t3)
  /* 172F84 80131F24 8E0C0074 */        lw $t4, 0x74($s0)
  /* 172F88 80131F28 4406A000 */      mfc1 $a2, $f20
  /* 172F8C 80131F2C 02002025 */        or $a0, $s0, $zero
  /* 172F90 80131F30 E5940020 */      swc1 $f20, 0x20($t4)
  /* 172F94 80131F34 8E0D0074 */        lw $t5, 0x74($s0)
  /* 172F98 80131F38 E5B40024 */      swc1 $f20, 0x24($t5)
  /* 172F9C 80131F3C 8E2E0004 */        lw $t6, 4($s1) # D_ovl49_80132D70 + 4
  /* 172FA0 80131F40 0C002F63 */       jal func_8000BD8C
  /* 172FA4 80131F44 01CF2821 */      addu $a1, $t6, $t7
  /* 172FA8 80131F48 3C058001 */       lui $a1, %hi(func_8000DF34)
  /* 172FAC 80131F4C 24A5DF34 */     addiu $a1, $a1, %lo(func_8000DF34)
  /* 172FB0 80131F50 AFA50030 */        sw $a1, 0x30($sp)
  /* 172FB4 80131F54 02002025 */        or $a0, $s0, $zero
  /* 172FB8 80131F58 24060001 */     addiu $a2, $zero, 1
  /* 172FBC 80131F5C 0C002062 */       jal omAddGObjCommonProc
  /* 172FC0 80131F60 24070001 */     addiu $a3, $zero, 1
  /* 172FC4 80131F64 00002025 */        or $a0, $zero, $zero
  /* 172FC8 80131F68 00002825 */        or $a1, $zero, $zero
  /* 172FCC 80131F6C 24060014 */     addiu $a2, $zero, 0x14
  /* 172FD0 80131F70 0C00265A */       jal omMakeGObjCommon
  /* 172FD4 80131F74 3C078000 */       lui $a3, 0x8000
  /* 172FD8 80131F78 2418FFFF */     addiu $t8, $zero, -1
  /* 172FDC 80131F7C 00408025 */        or $s0, $v0, $zero
  /* 172FE0 80131F80 AFB80010 */        sw $t8, 0x10($sp)
  /* 172FE4 80131F84 00402025 */        or $a0, $v0, $zero
  /* 172FE8 80131F88 8FA50034 */        lw $a1, 0x34($sp)
  /* 172FEC 80131F8C 2406001D */     addiu $a2, $zero, 0x1d
  /* 172FF0 80131F90 0C00277D */       jal omAddGObjRenderProc
  /* 172FF4 80131F94 3C078000 */       lui $a3, 0x8000
  /* 172FF8 80131F98 8E390004 */        lw $t9, 4($s1) # D_ovl49_80132D70 + 4
  /* 172FFC 80131F9C 3C080000 */       lui $t0, %hi(D_NF_00003938)
  /* 173000 80131FA0 25083938 */     addiu $t0, $t0, %lo(D_NF_00003938)
  /* 173004 80131FA4 02002025 */        or $a0, $s0, $zero
  /* 173008 80131FA8 0C0024B4 */       jal omAddDObjForGObj
  /* 17300C 80131FAC 03282821 */      addu $a1, $t9, $t0
  /* 173010 80131FB0 00402025 */        or $a0, $v0, $zero
  /* 173014 80131FB4 2405001C */     addiu $a1, $zero, 0x1c
  /* 173018 80131FB8 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 17301C 80131FBC 00003025 */        or $a2, $zero, $zero
  /* 173020 80131FC0 8E290004 */        lw $t1, 4($s1) # D_ovl49_80132D70 + 4
  /* 173024 80131FC4 3C0A0000 */       lui $t2, %hi(D_NF_000036E0)
  /* 173028 80131FC8 254A36E0 */     addiu $t2, $t2, %lo(D_NF_000036E0)
  /* 17302C 80131FCC 02002025 */        or $a0, $s0, $zero
  /* 173030 80131FD0 0C003E3D */       jal func_8000F8F4
  /* 173034 80131FD4 012A2821 */      addu $a1, $t1, $t2
  /* 173038 80131FD8 8E2B0004 */        lw $t3, 4($s1) # D_ovl49_80132D70 + 4
  /* 17303C 80131FDC 3C0C0000 */       lui $t4, %hi(D_NF_00003AE8)
  /* 173040 80131FE0 258C3AE8 */     addiu $t4, $t4, %lo(D_NF_00003AE8)
  /* 173044 80131FE4 4406A000 */      mfc1 $a2, $f20
  /* 173048 80131FE8 02002025 */        or $a0, $s0, $zero
  /* 17304C 80131FEC 0C002F8A */       jal func_8000BE28
  /* 173050 80131FF0 016C2821 */      addu $a1, $t3, $t4
  /* 173054 80131FF4 8E0D0074 */        lw $t5, 0x74($s0)
  /* 173058 80131FF8 3C190000 */       lui $t9, %hi(D_NF_00003D60)
  /* 17305C 80131FFC 27393D60 */     addiu $t9, $t9, %lo(D_NF_00003D60)
  /* 173060 80132000 E5B4001C */      swc1 $f20, 0x1c($t5)
  /* 173064 80132004 8E0E0074 */        lw $t6, 0x74($s0)
  /* 173068 80132008 4406A000 */      mfc1 $a2, $f20
  /* 17306C 8013200C 02002025 */        or $a0, $s0, $zero
  /* 173070 80132010 E5D40020 */      swc1 $f20, 0x20($t6)
  /* 173074 80132014 8E0F0074 */        lw $t7, 0x74($s0)
  /* 173078 80132018 E5F40024 */      swc1 $f20, 0x24($t7)
  /* 17307C 8013201C 8E380004 */        lw $t8, 4($s1) # D_ovl49_80132D70 + 4
  /* 173080 80132020 0C002F63 */       jal func_8000BD8C
  /* 173084 80132024 03192821 */      addu $a1, $t8, $t9
  /* 173088 80132028 02002025 */        or $a0, $s0, $zero
  /* 17308C 8013202C 8FA50030 */        lw $a1, 0x30($sp)
  /* 173090 80132030 24060001 */     addiu $a2, $zero, 1
  /* 173094 80132034 0C002062 */       jal omAddGObjCommonProc
  /* 173098 80132038 24070001 */     addiu $a3, $zero, 1
  /* 17309C 8013203C 00002025 */        or $a0, $zero, $zero
  /* 1730A0 80132040 00002825 */        or $a1, $zero, $zero
  /* 1730A4 80132044 24060014 */     addiu $a2, $zero, 0x14
  /* 1730A8 80132048 0C00265A */       jal omMakeGObjCommon
  /* 1730AC 8013204C 3C078000 */       lui $a3, 0x8000
  /* 1730B0 80132050 2408FFFF */     addiu $t0, $zero, -1
  /* 1730B4 80132054 00408025 */        or $s0, $v0, $zero
  /* 1730B8 80132058 AFA80010 */        sw $t0, 0x10($sp)
  /* 1730BC 8013205C 00402025 */        or $a0, $v0, $zero
  /* 1730C0 80132060 8FA50034 */        lw $a1, 0x34($sp)
  /* 1730C4 80132064 2406001D */     addiu $a2, $zero, 0x1d
  /* 1730C8 80132068 0C00277D */       jal omAddGObjRenderProc
  /* 1730CC 8013206C 3C078000 */       lui $a3, 0x8000
  /* 1730D0 80132070 8E290004 */        lw $t1, 4($s1) # D_ovl49_80132D70 + 4
  /* 1730D4 80132074 3C0A0000 */       lui $t2, %hi(D_NF_00003FC8)
  /* 1730D8 80132078 254A3FC8 */     addiu $t2, $t2, %lo(D_NF_00003FC8)
  /* 1730DC 8013207C 02002025 */        or $a0, $s0, $zero
  /* 1730E0 80132080 0C0024B4 */       jal omAddDObjForGObj
  /* 1730E4 80132084 012A2821 */      addu $a1, $t1, $t2
  /* 1730E8 80132088 00402025 */        or $a0, $v0, $zero
  /* 1730EC 8013208C 2405001C */     addiu $a1, $zero, 0x1c
  /* 1730F0 80132090 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 1730F4 80132094 00003025 */        or $a2, $zero, $zero
  /* 1730F8 80132098 8E2B0004 */        lw $t3, 4($s1) # D_ovl49_80132D70 + 4
  /* 1730FC 8013209C 3C0C0000 */       lui $t4, %hi(D_NF_00003D70)
  /* 173100 801320A0 258C3D70 */     addiu $t4, $t4, %lo(D_NF_00003D70)
  /* 173104 801320A4 02002025 */        or $a0, $s0, $zero
  /* 173108 801320A8 0C003E3D */       jal func_8000F8F4
  /* 17310C 801320AC 016C2821 */      addu $a1, $t3, $t4
  /* 173110 801320B0 8E2D0004 */        lw $t5, 4($s1) # D_ovl49_80132D70 + 4
  /* 173114 801320B4 3C0E0000 */       lui $t6, %hi(D_NF_00004180)
  /* 173118 801320B8 25CE4180 */     addiu $t6, $t6, %lo(D_NF_00004180)
  /* 17311C 801320BC 4406A000 */      mfc1 $a2, $f20
  /* 173120 801320C0 02002025 */        or $a0, $s0, $zero
  /* 173124 801320C4 0C002F8A */       jal func_8000BE28
  /* 173128 801320C8 01AE2821 */      addu $a1, $t5, $t6
  /* 17312C 801320CC 8E0F0074 */        lw $t7, 0x74($s0)
  /* 173130 801320D0 3C090000 */       lui $t1, %hi(D_NF_00004400)
  /* 173134 801320D4 25294400 */     addiu $t1, $t1, %lo(D_NF_00004400)
  /* 173138 801320D8 E5F4001C */      swc1 $f20, 0x1c($t7)
  /* 17313C 801320DC 8E180074 */        lw $t8, 0x74($s0)
  /* 173140 801320E0 4406A000 */      mfc1 $a2, $f20
  /* 173144 801320E4 02002025 */        or $a0, $s0, $zero
  /* 173148 801320E8 E7140020 */      swc1 $f20, 0x20($t8)
  /* 17314C 801320EC 8E190074 */        lw $t9, 0x74($s0)
  /* 173150 801320F0 E7340024 */      swc1 $f20, 0x24($t9)
  /* 173154 801320F4 8E280004 */        lw $t0, 4($s1) # D_ovl49_80132D70 + 4
  /* 173158 801320F8 0C002F63 */       jal func_8000BD8C
  /* 17315C 801320FC 01092821 */      addu $a1, $t0, $t1
  /* 173160 80132100 02002025 */        or $a0, $s0, $zero
  /* 173164 80132104 8FA50030 */        lw $a1, 0x30($sp)
  /* 173168 80132108 24060001 */     addiu $a2, $zero, 1
  /* 17316C 8013210C 0C002062 */       jal omAddGObjCommonProc
  /* 173170 80132110 24070001 */     addiu $a3, $zero, 1
  /* 173174 80132114 00002025 */        or $a0, $zero, $zero
  /* 173178 80132118 00002825 */        or $a1, $zero, $zero
  /* 17317C 8013211C 24060014 */     addiu $a2, $zero, 0x14
  /* 173180 80132120 0C00265A */       jal omMakeGObjCommon
  /* 173184 80132124 3C078000 */       lui $a3, 0x8000
  /* 173188 80132128 240AFFFF */     addiu $t2, $zero, -1
  /* 17318C 8013212C 00408025 */        or $s0, $v0, $zero
  /* 173190 80132130 AFAA0010 */        sw $t2, 0x10($sp)
  /* 173194 80132134 00402025 */        or $a0, $v0, $zero
  /* 173198 80132138 8FA50034 */        lw $a1, 0x34($sp)
  /* 17319C 8013213C 2406001D */     addiu $a2, $zero, 0x1d
  /* 1731A0 80132140 0C00277D */       jal omAddGObjRenderProc
  /* 1731A4 80132144 3C078000 */       lui $a3, 0x8000
  /* 1731A8 80132148 8E2B0004 */        lw $t3, 4($s1) # D_ovl49_80132D70 + 4
  /* 1731AC 8013214C 3C0C0000 */       lui $t4, %hi(D_NF_00004668)
  /* 1731B0 80132150 258C4668 */     addiu $t4, $t4, %lo(D_NF_00004668)
  /* 1731B4 80132154 02002025 */        or $a0, $s0, $zero
  /* 1731B8 80132158 0C0024B4 */       jal omAddDObjForGObj
  /* 1731BC 8013215C 016C2821 */      addu $a1, $t3, $t4
  /* 1731C0 80132160 00402025 */        or $a0, $v0, $zero
  /* 1731C4 80132164 2405001C */     addiu $a1, $zero, 0x1c
  /* 1731C8 80132168 0C002330 */       jal omAddOMMtxForDObjFixed
  /* 1731CC 8013216C 00003025 */        or $a2, $zero, $zero
  /* 1731D0 80132170 8E2D0004 */        lw $t5, 4($s1) # D_ovl49_80132D70 + 4
  /* 1731D4 80132174 3C0E0000 */       lui $t6, %hi(D_NF_00004410)
  /* 1731D8 80132178 25CE4410 */     addiu $t6, $t6, %lo(D_NF_00004410)
  /* 1731DC 8013217C 02002025 */        or $a0, $s0, $zero
  /* 1731E0 80132180 0C003E3D */       jal func_8000F8F4
  /* 1731E4 80132184 01AE2821 */      addu $a1, $t5, $t6
  /* 1731E8 80132188 8E2F0004 */        lw $t7, 4($s1) # D_ovl49_80132D70 + 4
  /* 1731EC 8013218C 3C180000 */       lui $t8, %hi(D_NF_00004820)
  /* 1731F0 80132190 27184820 */     addiu $t8, $t8, %lo(D_NF_00004820)
  /* 1731F4 80132194 4406A000 */      mfc1 $a2, $f20
  /* 1731F8 80132198 02002025 */        or $a0, $s0, $zero
  /* 1731FC 8013219C 0C002F8A */       jal func_8000BE28
  /* 173200 801321A0 01F82821 */      addu $a1, $t7, $t8
  /* 173204 801321A4 8E190074 */        lw $t9, 0x74($s0)
  /* 173208 801321A8 3C0B0000 */       lui $t3, %hi(D_NF_00004AA0)
  /* 17320C 801321AC 256B4AA0 */     addiu $t3, $t3, %lo(D_NF_00004AA0)
  /* 173210 801321B0 E734001C */      swc1 $f20, 0x1c($t9)
  /* 173214 801321B4 8E080074 */        lw $t0, 0x74($s0)
  /* 173218 801321B8 4406A000 */      mfc1 $a2, $f20
  /* 17321C 801321BC 02002025 */        or $a0, $s0, $zero
  /* 173220 801321C0 E5140020 */      swc1 $f20, 0x20($t0)
  /* 173224 801321C4 8E090074 */        lw $t1, 0x74($s0)
  /* 173228 801321C8 E5340024 */      swc1 $f20, 0x24($t1)
  /* 17322C 801321CC 8E2A0004 */        lw $t2, 4($s1) # D_ovl49_80132D70 + 4
  /* 173230 801321D0 0C002F63 */       jal func_8000BD8C
  /* 173234 801321D4 014B2821 */      addu $a1, $t2, $t3
  /* 173238 801321D8 02002025 */        or $a0, $s0, $zero
  /* 17323C 801321DC 8FA50030 */        lw $a1, 0x30($sp)
  /* 173240 801321E0 24060001 */     addiu $a2, $zero, 1
  /* 173244 801321E4 0C002062 */       jal omAddGObjCommonProc
  /* 173248 801321E8 24070001 */     addiu $a3, $zero, 1
  /* 17324C 801321EC 8FBF002C */        lw $ra, 0x2c($sp)
  /* 173250 801321F0 D7B40018 */      ldc1 $f20, 0x18($sp)
  /* 173254 801321F4 8FB00024 */        lw $s0, 0x24($sp)
  /* 173258 801321F8 8FB10028 */        lw $s1, 0x28($sp)
  /* 17325C 801321FC 03E00008 */        jr $ra
  /* 173260 80132200 27BD0040 */     addiu $sp, $sp, 0x40

glabel func_ovl49_80132204
  /* 173264 80132204 27BDFFB0 */     addiu $sp, $sp, -0x50
  /* 173268 80132208 3C0E8001 */       lui $t6, %hi(func_80017EC0)
  /* 17326C 8013220C 3C190800 */       lui $t9, (0x8000200 >> 16) # 134218240
  /* 173270 80132210 AFBF0044 */        sw $ra, 0x44($sp)
  /* 173274 80132214 37390200 */       ori $t9, $t9, (0x8000200 & 0xFFFF) # 134218240
  /* 173278 80132218 25CE7EC0 */     addiu $t6, $t6, %lo(func_80017EC0)
  /* 17327C 8013221C 240F003C */     addiu $t7, $zero, 0x3c
  /* 173280 80132220 24180000 */     addiu $t8, $zero, 0
  /* 173284 80132224 2408FFFF */     addiu $t0, $zero, -1
  /* 173288 80132228 24090001 */     addiu $t1, $zero, 1
  /* 17328C 8013222C 240A0001 */     addiu $t2, $zero, 1
  /* 173290 80132230 240B0001 */     addiu $t3, $zero, 1
  /* 173294 80132234 AFB00040 */        sw $s0, 0x40($sp)
  /* 173298 80132238 AFAB0030 */        sw $t3, 0x30($sp)
  /* 17329C 8013223C AFAA0028 */        sw $t2, 0x28($sp)
  /* 1732A0 80132240 AFA90024 */        sw $t1, 0x24($sp)
  /* 1732A4 80132244 AFA80020 */        sw $t0, 0x20($sp)
  /* 1732A8 80132248 AFB80018 */        sw $t8, 0x18($sp)
  /* 1732AC 8013224C AFAF0014 */        sw $t7, 0x14($sp)
  /* 1732B0 80132250 AFAE0010 */        sw $t6, 0x10($sp)
  /* 1732B4 80132254 AFB9001C */        sw $t9, 0x1c($sp)
  /* 1732B8 80132258 AFA0002C */        sw $zero, 0x2c($sp)
  /* 1732BC 8013225C AFA00034 */        sw $zero, 0x34($sp)
  /* 1732C0 80132260 24040401 */     addiu $a0, $zero, 0x401
  /* 1732C4 80132264 00002825 */        or $a1, $zero, $zero
  /* 1732C8 80132268 24060010 */     addiu $a2, $zero, 0x10
  /* 1732CC 8013226C 0C002E4F */       jal func_8000B93C
  /* 1732D0 80132270 3C078000 */       lui $a3, 0x8000
  /* 1732D4 80132274 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 1732D8 80132278 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 1732DC 8013227C AFA2004C */        sw $v0, 0x4c($sp)
  /* 1732E0 80132280 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 1732E4 80132284 8C500074 */        lw $s0, 0x74($v0)
  /* 1732E8 80132288 44812000 */      mtc1 $at, $f4 # 230.0 to cop1
  /* 1732EC 8013228C 44050000 */      mfc1 $a1, $f0
  /* 1732F0 80132290 44060000 */      mfc1 $a2, $f0
  /* 1732F4 80132294 3C07439B */       lui $a3, 0x439b
  /* 1732F8 80132298 26040008 */     addiu $a0, $s0, 8
  /* 1732FC 8013229C 0C001C20 */       jal func_80007080
  /* 173300 801322A0 E7A40010 */      swc1 $f4, 0x10($sp)
  /* 173304 801322A4 3C014300 */       lui $at, (0x43000000 >> 16) # 128.0
  /* 173308 801322A8 44813000 */      mtc1 $at, $f6 # 128.0 to cop1
  /* 17330C 801322AC 8E0C0080 */        lw $t4, 0x80($s0)
  /* 173310 801322B0 3C014680 */       lui $at, (0x46800000 >> 16) # 16384.0
  /* 173314 801322B4 44814000 */      mtc1 $at, $f8 # 16384.0 to cop1
  /* 173318 801322B8 358D0001 */       ori $t5, $t4, 1
  /* 17331C 801322BC AE0D0080 */        sw $t5, 0x80($s0)
  /* 173320 801322C0 3C0E8013 */       lui $t6, %hi(D_ovl49_80132D70)
  /* 173324 801322C4 E6060028 */      swc1 $f6, 0x28($s0)
  /* 173328 801322C8 E608002C */      swc1 $f8, 0x2c($s0)
  /* 17332C 801322CC 8DCE2D70 */        lw $t6, %lo(D_ovl49_80132D70)($t6)
  /* 173330 801322D0 3C0F0000 */       lui $t7, %hi(D_NF_00001440)
  /* 173334 801322D4 25EF1440 */     addiu $t7, $t7, %lo(D_NF_00001440)
  /* 173338 801322D8 02002025 */        or $a0, $s0, $zero
  /* 17333C 801322DC 24060000 */     addiu $a2, $zero, 0
  /* 173340 801322E0 0C003E8F */       jal func_8000FA3C
  /* 173344 801322E4 01CF2821 */      addu $a1, $t6, $t7
  /* 173348 801322E8 3C058001 */       lui $a1, %hi(func_80010580)
  /* 17334C 801322EC 24A50580 */     addiu $a1, $a1, %lo(func_80010580)
  /* 173350 801322F0 8FA4004C */        lw $a0, 0x4c($sp)
  /* 173354 801322F4 24060001 */     addiu $a2, $zero, 1
  /* 173358 801322F8 0C002062 */       jal omAddGObjCommonProc
  /* 17335C 801322FC 24070001 */     addiu $a3, $zero, 1
  /* 173360 80132300 8FBF0044 */        lw $ra, 0x44($sp)
  /* 173364 80132304 8FB00040 */        lw $s0, 0x40($sp)
  /* 173368 80132308 27BD0050 */     addiu $sp, $sp, 0x50
  /* 17336C 8013230C 03E00008 */        jr $ra
  /* 173370 80132310 00000000 */       nop 

glabel func_ovl49_80132314
  /* 173374 80132314 27BDFFB8 */     addiu $sp, $sp, -0x48
  /* 173378 80132318 3C0E800D */       lui $t6, %hi(func_ovl0_800CD2CC)
  /* 17337C 8013231C AFBF003C */        sw $ra, 0x3c($sp)
  /* 173380 80132320 25CED2CC */     addiu $t6, $t6, %lo(func_ovl0_800CD2CC)
  /* 173384 80132324 240F0028 */     addiu $t7, $zero, 0x28
  /* 173388 80132328 24180000 */     addiu $t8, $zero, 0
  /* 17338C 8013232C 3C190400 */       lui $t9, 0x400
  /* 173390 80132330 2408FFFF */     addiu $t0, $zero, -1
  /* 173394 80132334 24090001 */     addiu $t1, $zero, 1
  /* 173398 80132338 240A0001 */     addiu $t2, $zero, 1
  /* 17339C 8013233C AFAA0030 */        sw $t2, 0x30($sp)
  /* 1733A0 80132340 AFA90028 */        sw $t1, 0x28($sp)
  /* 1733A4 80132344 AFA80020 */        sw $t0, 0x20($sp)
  /* 1733A8 80132348 AFB9001C */        sw $t9, 0x1c($sp)
  /* 1733AC 8013234C AFB80018 */        sw $t8, 0x18($sp)
  /* 1733B0 80132350 AFAF0014 */        sw $t7, 0x14($sp)
  /* 1733B4 80132354 AFAE0010 */        sw $t6, 0x10($sp)
  /* 1733B8 80132358 AFA00024 */        sw $zero, 0x24($sp)
  /* 1733BC 8013235C AFA0002C */        sw $zero, 0x2c($sp)
  /* 1733C0 80132360 AFA00034 */        sw $zero, 0x34($sp)
  /* 1733C4 80132364 24040401 */     addiu $a0, $zero, 0x401
  /* 1733C8 80132368 00002825 */        or $a1, $zero, $zero
  /* 1733CC 8013236C 24060010 */     addiu $a2, $zero, 0x10
  /* 1733D0 80132370 0C002E4F */       jal func_8000B93C
  /* 1733D4 80132374 3C078000 */       lui $a3, 0x8000
  /* 1733D8 80132378 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 1733DC 8013237C 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 1733E0 80132380 8C430074 */        lw $v1, 0x74($v0)
  /* 1733E4 80132384 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 1733E8 80132388 44812000 */      mtc1 $at, $f4 # 230.0 to cop1
  /* 1733EC 8013238C 44050000 */      mfc1 $a1, $f0
  /* 1733F0 80132390 44060000 */      mfc1 $a2, $f0
  /* 1733F4 80132394 3C07439B */       lui $a3, 0x439b
  /* 1733F8 80132398 24640008 */     addiu $a0, $v1, 8
  /* 1733FC 8013239C AFA30044 */        sw $v1, 0x44($sp)
  /* 173400 801323A0 0C001C20 */       jal func_80007080
  /* 173404 801323A4 E7A40010 */      swc1 $f4, 0x10($sp)
  /* 173408 801323A8 8FA30044 */        lw $v1, 0x44($sp)
  /* 17340C 801323AC 8C6B0080 */        lw $t3, 0x80($v1)
  /* 173410 801323B0 356C0001 */       ori $t4, $t3, 1
  /* 173414 801323B4 AC6C0080 */        sw $t4, 0x80($v1)
  /* 173418 801323B8 8FBF003C */        lw $ra, 0x3c($sp)
  /* 17341C 801323BC 27BD0048 */     addiu $sp, $sp, 0x48
  /* 173420 801323C0 03E00008 */        jr $ra
  /* 173424 801323C4 00000000 */       nop 

glabel func_ovl49_801323C8
  /* 173428 801323C8 3C038004 */       lui $v1, %hi(gDisplayListHead)
  /* 17342C 801323CC 246365B0 */     addiu $v1, $v1, %lo(gDisplayListHead)
  /* 173430 801323D0 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 173434 801323D4 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 173438 801323D8 AFBF0014 */        sw $ra, 0x14($sp)
  /* 17343C 801323DC 244E0008 */     addiu $t6, $v0, 8
  /* 173440 801323E0 AC6E0000 */        sw $t6, ($v1) # gDisplayListHead + 0
  /* 173444 801323E4 3C0FE700 */       lui $t7, 0xe700
  /* 173448 801323E8 AC4F0000 */        sw $t7, ($v0)
  /* 17344C 801323EC AC400004 */        sw $zero, 4($v0)
  /* 173450 801323F0 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 173454 801323F4 3C19E200 */       lui $t9, (0xE200001C >> 16) # 3791650844
  /* 173458 801323F8 3C080055 */       lui $t0, (0x552048 >> 16) # 5578824
  /* 17345C 801323FC 24580008 */     addiu $t8, $v0, 8
  /* 173460 80132400 AC780000 */        sw $t8, ($v1) # gDisplayListHead + 0
  /* 173464 80132404 35082048 */       ori $t0, $t0, (0x552048 & 0xFFFF) # 5578824
  /* 173468 80132408 3739001C */       ori $t9, $t9, (0xE200001C & 0xFFFF) # 3791650844
  /* 17346C 8013240C AC590000 */        sw $t9, ($v0)
  /* 173470 80132410 0C005F6F */       jal func_80017DBC
  /* 173474 80132414 AC480004 */        sw $t0, 4($v0)
  /* 173478 80132418 3C038004 */       lui $v1, %hi(gDisplayListHead)
  /* 17347C 8013241C 246365B0 */     addiu $v1, $v1, %lo(gDisplayListHead)
  /* 173480 80132420 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 173484 80132424 3C0AE700 */       lui $t2, 0xe700
  /* 173488 80132428 3C0CE200 */       lui $t4, (0xE200001C >> 16) # 3791650844
  /* 17348C 8013242C 24490008 */     addiu $t1, $v0, 8
  /* 173490 80132430 AC690000 */        sw $t1, ($v1) # gDisplayListHead + 0
  /* 173494 80132434 AC400004 */        sw $zero, 4($v0)
  /* 173498 80132438 AC4A0000 */        sw $t2, ($v0)
  /* 17349C 8013243C 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 1734A0 80132440 3C0D0055 */       lui $t5, (0x552078 >> 16) # 5578872
  /* 1734A4 80132444 35AD2078 */       ori $t5, $t5, (0x552078 & 0xFFFF) # 5578872
  /* 1734A8 80132448 244B0008 */     addiu $t3, $v0, 8
  /* 1734AC 8013244C AC6B0000 */        sw $t3, ($v1) # gDisplayListHead + 0
  /* 1734B0 80132450 358C001C */       ori $t4, $t4, (0xE200001C & 0xFFFF) # 3791650844
  /* 1734B4 80132454 AC4C0000 */        sw $t4, ($v0)
  /* 1734B8 80132458 AC4D0004 */        sw $t5, 4($v0)
  /* 1734BC 8013245C 8FBF0014 */        lw $ra, 0x14($sp)
  /* 1734C0 80132460 27BD0018 */     addiu $sp, $sp, 0x18
  /* 1734C4 80132464 03E00008 */        jr $ra
  /* 1734C8 80132468 00000000 */       nop 

glabel func_ovl49_8013246C
  /* 1734CC 8013246C 27BDFFB8 */     addiu $sp, $sp, -0x48
  /* 1734D0 80132470 3C0E8013 */       lui $t6, %hi(func_ovl49_801323C8)
  /* 1734D4 80132474 AFBF003C */        sw $ra, 0x3c($sp)
  /* 1734D8 80132478 25CE23C8 */     addiu $t6, $t6, %lo(func_ovl49_801323C8)
  /* 1734DC 8013247C 240F005A */     addiu $t7, $zero, 0x5a
  /* 1734E0 80132480 24180000 */     addiu $t8, $zero, 0
  /* 1734E4 80132484 3C192000 */       lui $t9, 0x2000
  /* 1734E8 80132488 2408FFFF */     addiu $t0, $zero, -1
  /* 1734EC 8013248C 24090001 */     addiu $t1, $zero, 1
  /* 1734F0 80132490 240A0001 */     addiu $t2, $zero, 1
  /* 1734F4 80132494 240B0001 */     addiu $t3, $zero, 1
  /* 1734F8 80132498 AFAB0030 */        sw $t3, 0x30($sp)
  /* 1734FC 8013249C AFAA0028 */        sw $t2, 0x28($sp)
  /* 173500 801324A0 AFA90024 */        sw $t1, 0x24($sp)
  /* 173504 801324A4 AFA80020 */        sw $t0, 0x20($sp)
  /* 173508 801324A8 AFB9001C */        sw $t9, 0x1c($sp)
  /* 17350C 801324AC AFB80018 */        sw $t8, 0x18($sp)
  /* 173510 801324B0 AFAF0014 */        sw $t7, 0x14($sp)
  /* 173514 801324B4 AFAE0010 */        sw $t6, 0x10($sp)
  /* 173518 801324B8 AFA0002C */        sw $zero, 0x2c($sp)
  /* 17351C 801324BC AFA00034 */        sw $zero, 0x34($sp)
  /* 173520 801324C0 24040401 */     addiu $a0, $zero, 0x401
  /* 173524 801324C4 00002825 */        or $a1, $zero, $zero
  /* 173528 801324C8 24060010 */     addiu $a2, $zero, 0x10
  /* 17352C 801324CC 0C002E4F */       jal func_8000B93C
  /* 173530 801324D0 3C078000 */       lui $a3, 0x8000
  /* 173534 801324D4 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 173538 801324D8 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 17353C 801324DC AFA20044 */        sw $v0, 0x44($sp)
  /* 173540 801324E0 8C430074 */        lw $v1, 0x74($v0)
  /* 173544 801324E4 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 173548 801324E8 44812000 */      mtc1 $at, $f4 # 230.0 to cop1
  /* 17354C 801324EC 44050000 */      mfc1 $a1, $f0
  /* 173550 801324F0 44060000 */      mfc1 $a2, $f0
  /* 173554 801324F4 3C07439B */       lui $a3, 0x439b
  /* 173558 801324F8 24640008 */     addiu $a0, $v1, 8
  /* 17355C 801324FC AFA30040 */        sw $v1, 0x40($sp)
  /* 173560 80132500 0C001C20 */       jal func_80007080
  /* 173564 80132504 E7A40010 */      swc1 $f4, 0x10($sp)
  /* 173568 80132508 3C0C8013 */       lui $t4, %hi(D_ovl49_80132D74)
  /* 17356C 8013250C 8D8C2D74 */        lw $t4, %lo(D_ovl49_80132D74)($t4)
  /* 173570 80132510 3C0D0000 */       lui $t5, %hi(D_NF_00004AB0)
  /* 173574 80132514 25AD4AB0 */     addiu $t5, $t5, %lo(D_NF_00004AB0)
  /* 173578 80132518 8FA40040 */        lw $a0, 0x40($sp)
  /* 17357C 8013251C 24060000 */     addiu $a2, $zero, 0
  /* 173580 80132520 0C003E8F */       jal func_8000FA3C
  /* 173584 80132524 018D2821 */      addu $a1, $t4, $t5
  /* 173588 80132528 3C058001 */       lui $a1, %hi(func_80010580)
  /* 17358C 8013252C 24A50580 */     addiu $a1, $a1, %lo(func_80010580)
  /* 173590 80132530 8FA40044 */        lw $a0, 0x44($sp)
  /* 173594 80132534 24060001 */     addiu $a2, $zero, 1
  /* 173598 80132538 0C002062 */       jal omAddGObjCommonProc
  /* 17359C 8013253C 24070001 */     addiu $a3, $zero, 1
  /* 1735A0 80132540 8FBF003C */        lw $ra, 0x3c($sp)
  /* 1735A4 80132544 27BD0048 */     addiu $sp, $sp, 0x48
  /* 1735A8 80132548 03E00008 */        jr $ra
  /* 1735AC 8013254C 00000000 */       nop 

glabel func_ovl49_80132550
  /* 1735B0 80132550 3C018013 */       lui $at, %hi(D_ovl49_80132A08)
  /* 1735B4 80132554 03E00008 */        jr $ra
  /* 1735B8 80132558 AC202A08 */        sw $zero, %lo(D_ovl49_80132A08)($at)

glabel func_ovl49_8013255C
  /* 1735BC 8013255C 3C038013 */       lui $v1, %hi(D_ovl49_80132A08)
  /* 1735C0 80132560 24632A08 */     addiu $v1, $v1, %lo(D_ovl49_80132A08)
  /* 1735C4 80132564 8C6E0000 */        lw $t6, ($v1) # D_ovl49_80132A08 + 0
  /* 1735C8 80132568 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 1735CC 8013256C AFBF0014 */        sw $ra, 0x14($sp)
  /* 1735D0 80132570 25CF0001 */     addiu $t7, $t6, 1
  /* 1735D4 80132574 29E1000A */      slti $at, $t7, 0xa
  /* 1735D8 80132578 AFA40018 */        sw $a0, 0x18($sp)
  /* 1735DC 8013257C 1420003B */      bnez $at, .L8013266C
  /* 1735E0 80132580 AC6F0000 */        sw $t7, ($v1) # D_ovl49_80132A08 + 0
  /* 1735E4 80132584 3C068013 */       lui $a2, %hi(D_ovl49_80132A10)
  /* 1735E8 80132588 24C62A10 */     addiu $a2, $a2, %lo(D_ovl49_80132A10)
  /* 1735EC 8013258C 8CC20000 */        lw $v0, ($a2) # D_ovl49_80132A10 + 0
  /* 1735F0 80132590 2404FFF1 */     addiu $a0, $zero, -0xf
  /* 1735F4 80132594 10400002 */      beqz $v0, .L801325A0
  /* 1735F8 80132598 2459FFFF */     addiu $t9, $v0, -1
  /* 1735FC 8013259C ACD90000 */        sw $t9, ($a2) # D_ovl49_80132A10 + 0
  .L801325A0:
  /* 173600 801325A0 0C0E4281 */       jal func_ovl1_80390A04
  /* 173604 801325A4 2405000F */     addiu $a1, $zero, 0xf
  /* 173608 801325A8 10400006 */      beqz $v0, .L801325C4
  /* 17360C 801325AC 2404FFF1 */     addiu $a0, $zero, -0xf
  /* 173610 801325B0 0C0E42B0 */       jal func_ovl1_80390AC0
  /* 173614 801325B4 2405000F */     addiu $a1, $zero, 0xf
  /* 173618 801325B8 10400002 */      beqz $v0, .L801325C4
  /* 17361C 801325BC 3C018013 */       lui $at, %hi(D_ovl49_80132A10)
  /* 173620 801325C0 AC202A10 */        sw $zero, %lo(D_ovl49_80132A10)($at)
  .L801325C4:
  /* 173624 801325C4 0C0E41DB */       jal func_ovl1_8039076C
  /* 173628 801325C8 3404D000 */       ori $a0, $zero, 0xd000
  /* 17362C 801325CC 10400007 */      beqz $v0, .L801325EC
  /* 173630 801325D0 3C03800A */       lui $v1, %hi(gSceneData)
  /* 173634 801325D4 24634AD0 */     addiu $v1, $v1, %lo(gSceneData)
  /* 173638 801325D8 90680000 */       lbu $t0, ($v1) # gSceneData + 0
  /* 17363C 801325DC 24090001 */     addiu $t1, $zero, 1
  /* 173640 801325E0 A0690000 */        sb $t1, ($v1) # gSceneData + 0
  /* 173644 801325E4 0C00171D */       jal func_80005C74
  /* 173648 801325E8 A0680001 */        sb $t0, 1($v1) # gSceneData + 1
  .L801325EC:
  /* 17364C 801325EC 3C028013 */       lui $v0, %hi(D_ovl49_80132A08)
  /* 173650 801325F0 8C422A08 */        lw $v0, %lo(D_ovl49_80132A08)($v0)
  /* 173654 801325F4 3C03800A */       lui $v1, %hi(gSceneData)
  /* 173658 801325F8 24010090 */     addiu $at, $zero, 0x90
  /* 17365C 801325FC 14410007 */       bne $v0, $at, .L8013261C
  /* 173660 80132600 24634AD0 */     addiu $v1, $v1, %lo(gSceneData)
  /* 173664 80132604 0C04C782 */       jal func_ovl49_80131E08
  /* 173668 80132608 00000000 */       nop 
  /* 17366C 8013260C 3C03800A */       lui $v1, %hi(gSceneData)
  /* 173670 80132610 3C028013 */       lui $v0, %hi(D_ovl49_80132A08)
  /* 173674 80132614 8C422A08 */        lw $v0, %lo(D_ovl49_80132A08)($v0)
  /* 173678 80132618 24634AD0 */     addiu $v1, $v1, %lo(gSceneData)
  .L8013261C:
  /* 17367C 8013261C 240100A0 */     addiu $at, $zero, 0xa0
  /* 173680 80132620 14410007 */       bne $v0, $at, .L80132640
  /* 173684 80132624 240B002E */     addiu $t3, $zero, 0x2e
  /* 173688 80132628 906A0000 */       lbu $t2, ($v1) # gSceneData + 0
  /* 17368C 8013262C A06B0000 */        sb $t3, ($v1) # gSceneData + 0
  /* 173690 80132630 0C00171D */       jal func_80005C74
  /* 173694 80132634 A06A0001 */        sb $t2, 1($v1) # gSceneData + 1
  /* 173698 80132638 3C028013 */       lui $v0, %hi(D_ovl49_80132A08)
  /* 17369C 8013263C 8C422A08 */        lw $v0, %lo(D_ovl49_80132A08)($v0)
  .L80132640:
  /* 1736A0 80132640 2401000F */     addiu $at, $zero, 0xf
  /* 1736A4 80132644 10410007 */       beq $v0, $at, .L80132664
  /* 1736A8 80132648 2401004B */     addiu $at, $zero, 0x4b
  /* 1736AC 8013264C 10410005 */       beq $v0, $at, .L80132664
  /* 1736B0 80132650 2401005A */     addiu $at, $zero, 0x5a
  /* 1736B4 80132654 10410003 */       beq $v0, $at, .L80132664
  /* 1736B8 80132658 24010069 */     addiu $at, $zero, 0x69
  /* 1736BC 8013265C 54410004 */      bnel $v0, $at, .L80132670
  /* 1736C0 80132660 8FBF0014 */        lw $ra, 0x14($sp)
  .L80132664:
  /* 1736C4 80132664 0C009A70 */       jal func_800269C0
  /* 1736C8 80132668 24040097 */     addiu $a0, $zero, 0x97
  .L8013266C:
  /* 1736CC 8013266C 8FBF0014 */        lw $ra, 0x14($sp)
  .L80132670:
  /* 1736D0 80132670 27BD0018 */     addiu $sp, $sp, 0x18
  /* 1736D4 80132674 03E00008 */        jr $ra
  /* 1736D8 80132678 00000000 */       nop 

  /* 1736DC 8013267C 27BDFFA0 */     addiu $sp, $sp, -0x60
  /* 1736E0 80132680 3C0E001B */       lui $t6, %hi(D_NF_001AC870)
  /* 1736E4 80132684 3C0F0000 */       lui $t7, %hi(D_NF_00000854)
  /* 1736E8 80132688 3C188013 */       lui $t8, %hi(D_ovl49_80132A18)
  /* 1736EC 8013268C 3C088013 */       lui $t0, %hi(D_ovl49_80132D38)
  /* 1736F0 80132690 AFBF002C */        sw $ra, 0x2c($sp)
  /* 1736F4 80132694 25CEC870 */     addiu $t6, $t6, %lo(D_NF_001AC870)
  /* 1736F8 80132698 25EF0854 */     addiu $t7, $t7, %lo(D_NF_00000854)
  /* 1736FC 8013269C 27182A18 */     addiu $t8, $t8, %lo(D_ovl49_80132A18)
  /* 173700 801326A0 24190064 */     addiu $t9, $zero, 0x64
  /* 173704 801326A4 25082D38 */     addiu $t0, $t0, %lo(D_ovl49_80132D38)
  /* 173708 801326A8 24090007 */     addiu $t1, $zero, 7
  /* 17370C 801326AC AFB20028 */        sw $s2, 0x28($sp)
  /* 173710 801326B0 AFB10024 */        sw $s1, 0x24($sp)
  /* 173714 801326B4 AFB00020 */        sw $s0, 0x20($sp)
  /* 173718 801326B8 AFAE003C */        sw $t6, 0x3c($sp)
  /* 17371C 801326BC AFAF0040 */        sw $t7, 0x40($sp)
  /* 173720 801326C0 AFA00044 */        sw $zero, 0x44($sp)
  /* 173724 801326C4 AFA00048 */        sw $zero, 0x48($sp)
  /* 173728 801326C8 AFB8004C */        sw $t8, 0x4c($sp)
  /* 17372C 801326CC AFB90050 */        sw $t9, 0x50($sp)
  /* 173730 801326D0 AFA80054 */        sw $t0, 0x54($sp)
  /* 173734 801326D4 AFA90058 */        sw $t1, 0x58($sp)
  /* 173738 801326D8 0C0337DE */       jal rdManagerInitSetup
  /* 17373C 801326DC 27A4003C */     addiu $a0, $sp, 0x3c
  /* 173740 801326E0 3C108013 */       lui $s0, %hi(D_ovl49_801328D0)
  /* 173744 801326E4 261028D0 */     addiu $s0, $s0, %lo(D_ovl49_801328D0)
  /* 173748 801326E8 02002025 */        or $a0, $s0, $zero
  /* 17374C 801326EC 0C0337BB */       jal rdManagerGetAllocSize
  /* 173750 801326F0 24050002 */     addiu $a1, $zero, 2
  /* 173754 801326F4 00402025 */        or $a0, $v0, $zero
  /* 173758 801326F8 0C001260 */       jal hlMemoryAlloc
  /* 17375C 801326FC 24050010 */     addiu $a1, $zero, 0x10
  /* 173760 80132700 3C068013 */       lui $a2, %hi(D_ovl49_80132D70)
  /* 173764 80132704 24C62D70 */     addiu $a2, $a2, %lo(D_ovl49_80132D70)
  /* 173768 80132708 02002025 */        or $a0, $s0, $zero
  /* 17376C 8013270C 24050002 */     addiu $a1, $zero, 2
  /* 173770 80132710 0C033781 */       jal rdManagerLoadFiles
  /* 173774 80132714 00403825 */        or $a3, $v0, $zero
  /* 173778 80132718 3C108000 */       lui $s0, 0x8000
  /* 17377C 8013271C 3C058013 */       lui $a1, %hi(func_ovl49_8013255C)
  /* 173780 80132720 24A5255C */     addiu $a1, $a1, %lo(func_ovl49_8013255C)
  /* 173784 80132724 02003825 */        or $a3, $s0, $zero
  /* 173788 80132728 00002025 */        or $a0, $zero, $zero
  /* 17378C 8013272C 0C00265A */       jal omMakeGObjCommon
  /* 173790 80132730 00003025 */        or $a2, $zero, $zero
  /* 173794 80132734 240A00FF */     addiu $t2, $zero, 0xff
  /* 173798 80132738 AFAA0010 */        sw $t2, 0x10($sp)
  /* 17379C 8013273C 00002025 */        or $a0, $zero, $zero
  /* 1737A0 80132740 02002825 */        or $a1, $s0, $zero
  /* 1737A4 80132744 24060064 */     addiu $a2, $zero, 0x64
  /* 1737A8 80132748 0C002E7F */       jal func_8000B9FC
  /* 1737AC 8013274C 24070003 */     addiu $a3, $zero, 3
  /* 1737B0 80132750 0C045624 */       jal func_ovl2_80115890
  /* 1737B4 80132754 00000000 */       nop 
  /* 1737B8 80132758 0C04C954 */       jal func_ovl49_80132550
  /* 1737BC 8013275C 00000000 */       nop 
  /* 1737C0 80132760 0C03F4C0 */       jal efManager_AllocUserData
  /* 1737C4 80132764 00000000 */       nop 
  /* 1737C8 80132768 24040001 */     addiu $a0, $zero, 1
  /* 1737CC 8013276C 0C035C65 */       jal ftManager_AllocFighterData
  /* 1737D0 80132770 24050008 */     addiu $a1, $zero, 8
  /* 1737D4 80132774 0C035E1B */       jal ftManager_SetFileDataKind
  /* 1737D8 80132778 00002025 */        or $a0, $zero, $zero
  /* 1737DC 8013277C 0C035E1B */       jal ftManager_SetFileDataKind
  /* 1737E0 80132780 24040001 */     addiu $a0, $zero, 1
  /* 1737E4 80132784 0C035E1B */       jal ftManager_SetFileDataKind
  /* 1737E8 80132788 24040002 */     addiu $a0, $zero, 2
  /* 1737EC 8013278C 0C035E1B */       jal ftManager_SetFileDataKind
  /* 1737F0 80132790 24040003 */     addiu $a0, $zero, 3
  /* 1737F4 80132794 0C035E1B */       jal ftManager_SetFileDataKind
  /* 1737F8 80132798 24040005 */     addiu $a0, $zero, 5
  /* 1737FC 8013279C 0C035E1B */       jal ftManager_SetFileDataKind
  /* 173800 801327A0 24040006 */     addiu $a0, $zero, 6
  /* 173804 801327A4 0C035E1B */       jal ftManager_SetFileDataKind
  /* 173808 801327A8 24040008 */     addiu $a0, $zero, 8
  /* 17380C 801327AC 0C035E1B */       jal ftManager_SetFileDataKind
  /* 173810 801327B0 24040009 */     addiu $a0, $zero, 9
  /* 173814 801327B4 3C108013 */       lui $s0, %hi(D_ovl49_801329D8)
  /* 173818 801327B8 3C128013 */       lui $s2, %hi(D_ovl49_801329F8)
  /* 17381C 801327BC 3C118013 */       lui $s1, %hi(D_ovl2_80130D9C)
  /* 173820 801327C0 26310D9C */     addiu $s1, $s1, %lo(D_ovl2_80130D9C)
  /* 173824 801327C4 265229F8 */     addiu $s2, $s2, %lo(D_ovl49_801329F8)
  /* 173828 801327C8 261029D8 */     addiu $s0, $s0, %lo(D_ovl49_801329D8)
  .L801327CC:
  /* 17382C 801327CC 8E240000 */        lw $a0, ($s1) # D_ovl2_80130D9C + 0
  /* 173830 801327D0 0C001260 */       jal hlMemoryAlloc
  /* 173834 801327D4 24050010 */     addiu $a1, $zero, 0x10
  /* 173838 801327D8 26100004 */     addiu $s0, $s0, 4
  /* 17383C 801327DC 1612FFFB */       bne $s0, $s2, .L801327CC
  /* 173840 801327E0 AE02FFFC */        sw $v0, -4($s0) # D_ovl49_801329D8 + -4
  /* 173844 801327E4 0C04C881 */       jal func_ovl49_80132204
  /* 173848 801327E8 00000000 */       nop 
  /* 17384C 801327EC 0C04C8C5 */       jal func_ovl49_80132314
  /* 173850 801327F0 00000000 */       nop 
  /* 173854 801327F4 0C04C91B */       jal func_ovl49_8013246C
  /* 173858 801327F8 00000000 */       nop 
  /* 17385C 801327FC 0C04C6D8 */       jal func_ovl49_80131B60
  /* 173860 80132800 00000000 */       nop 
  /* 173864 80132804 0C04C797 */       jal func_ovl49_80131E5C
  /* 173868 80132808 00000000 */       nop 
  /* 17386C 8013280C 3C014234 */       lui $at, (0x42340000 >> 16) # 45.0
  /* 173870 80132810 44816000 */      mtc1 $at, $f12 # 45.0 to cop1
  /* 173874 80132814 240B00FF */     addiu $t3, $zero, 0xff
  /* 173878 80132818 240C00FF */     addiu $t4, $zero, 0xff
  /* 17387C 8013281C AFAC0014 */        sw $t4, 0x14($sp)
  /* 173880 80132820 AFAB0010 */        sw $t3, 0x10($sp)
  /* 173884 80132824 240600FF */     addiu $a2, $zero, 0xff
  /* 173888 80132828 240700FF */     addiu $a3, $zero, 0xff
  /* 17388C 8013282C 0C0E4138 */       jal func_ovl1_803904E0
  /* 173890 80132830 46006386 */     mov.s $f14, $f12
  /* 173894 80132834 0C00024B */       jal func_8000092C
  /* 173898 80132838 00000000 */       nop 
  /* 17389C 8013283C 2C410F87 */     sltiu $at, $v0, 0xf87
  /* 1738A0 80132840 50200007 */      beql $at, $zero, .L80132860
  /* 1738A4 80132844 8FBF002C */        lw $ra, 0x2c($sp)
  .L80132848:
  /* 1738A8 80132848 0C00024B */       jal func_8000092C
  /* 1738AC 8013284C 00000000 */       nop 
  /* 1738B0 80132850 2C410F87 */     sltiu $at, $v0, 0xf87
  /* 1738B4 80132854 1420FFFC */      bnez $at, .L80132848
  /* 1738B8 80132858 00000000 */       nop 
  /* 1738BC 8013285C 8FBF002C */        lw $ra, 0x2c($sp)
  .L80132860:
  /* 1738C0 80132860 8FB00020 */        lw $s0, 0x20($sp)
  /* 1738C4 80132864 8FB10024 */        lw $s1, 0x24($sp)
  /* 1738C8 80132868 8FB20028 */        lw $s2, 0x28($sp)
  /* 1738CC 8013286C 03E00008 */        jr $ra
  /* 1738D0 80132870 27BD0060 */     addiu $sp, $sp, 0x60

glabel intro_sex_kicks_entry
  /* 1738D4 80132874 3C0E800A */       lui $t6, %hi(D_NF_800A5240)
  /* 1738D8 80132878 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 1738DC 8013287C 3C048013 */       lui $a0, %hi(D_ovl49_80132928)
  /* 1738E0 80132880 25CE5240 */     addiu $t6, $t6, %lo(D_NF_800A5240)
  /* 1738E4 80132884 24842928 */     addiu $a0, $a0, %lo(D_ovl49_80132928)
  /* 1738E8 80132888 AFBF0014 */        sw $ra, 0x14($sp)
  /* 1738EC 8013288C 25CFE700 */     addiu $t7, $t6, -0x1900
  /* 1738F0 80132890 0C001C09 */       jal func_80007024
  /* 1738F4 80132894 AC8F000C */        sw $t7, 0xc($a0) # D_ovl49_80132928 + 12
  /* 1738F8 80132898 3C188039 */       lui $t8, %hi(func_ovl1_803903E0)
  /* 1738FC 8013289C 3C198013 */       lui $t9, %hi(D_NF_80132D80)
  /* 173900 801328A0 3C048013 */       lui $a0, %hi(D_ovl49_80132944)
  /* 173904 801328A4 27392D80 */     addiu $t9, $t9, %lo(D_NF_80132D80)
  /* 173908 801328A8 271803E0 */     addiu $t8, $t8, %lo(func_ovl1_803903E0)
  /* 17390C 801328AC 24842944 */     addiu $a0, $a0, %lo(D_ovl49_80132944)
  /* 173910 801328B0 03194023 */      subu $t0, $t8, $t9
  /* 173914 801328B4 0C001A0F */       jal func_8000683C
  /* 173918 801328B8 AC880010 */        sw $t0, 0x10($a0) # D_ovl49_80132944 + 16
  /* 17391C 801328BC 8FBF0014 */        lw $ra, 0x14($sp)
  /* 173920 801328C0 27BD0018 */     addiu $sp, $sp, 0x18
  /* 173924 801328C4 03E00008 */        jr $ra
  /* 173928 801328C8 00000000 */       nop 

  /* 17392C 801328CC 00000000 */       nop 
