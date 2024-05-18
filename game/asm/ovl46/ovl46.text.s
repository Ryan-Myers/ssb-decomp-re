.include "macros.inc"

# assembler directives
.set noat      # allow manual use of $at
.set noreorder # don't insert nops after branches
.set gp=64     # allow use of 64-bit general purpose registers

.section .text

.align 4

# Text Sections
#  0x80131B00 -> 0x801326D0

glabel gMvOpeningLinkHillSetupDisplayList
  /* 170660 80131B00 27BDFFD8 */     addiu $sp, $sp, -0x28
  /* 170664 80131B04 AFBF0014 */        sw $ra, 0x14($sp)
  /* 170668 80131B08 8C830000 */        lw $v1, ($a0)
  /* 17066C 80131B0C 3C0FD9FF */       lui $t7, (0xD9FFFFFF >> 16) # 3657433087
  /* 170670 80131B10 35EFFFFF */       ori $t7, $t7, (0xD9FFFFFF & 0xFFFF) # 3657433087
  /* 170674 80131B14 246E0008 */     addiu $t6, $v1, 8
  /* 170678 80131B18 AC8E0000 */        sw $t6, ($a0)
  /* 17067C 80131B1C 3C180002 */       lui $t8, 2
  /* 170680 80131B20 AC780004 */        sw $t8, 4($v1)
  /* 170684 80131B24 AC6F0000 */        sw $t7, ($v1)
  /* 170688 80131B28 0C0E4147 */       jal func_ovl1_8039051C
  /* 17068C 80131B2C AFA40028 */        sw $a0, 0x28($sp)
  /* 170690 80131B30 0C0E414A */       jal func_ovl1_80390528
  /* 170694 80131B34 E7A0001C */      swc1 $f0, 0x1c($sp)
  /* 170698 80131B38 44060000 */      mfc1 $a2, $f0
  /* 17069C 80131B3C 8FA40028 */        lw $a0, 0x28($sp)
  /* 1706A0 80131B40 0C03F2DC */       jal ftRender_Lights_DisplayLightReflect
  /* 1706A4 80131B44 8FA5001C */        lw $a1, 0x1c($sp)
  /* 1706A8 80131B48 8FBF0014 */        lw $ra, 0x14($sp)
  /* 1706AC 80131B4C 27BD0028 */     addiu $sp, $sp, 0x28
  /* 1706B0 80131B50 03E00008 */        jr $ra
  /* 1706B4 80131B54 00000000 */       nop

glabel mvOpeningLinkHillRenderHills
  /* 1706B8 80131B58 3C038004 */       lui $v1, %hi(gDisplayListHead)
  /* 1706BC 80131B5C 246365B0 */     addiu $v1, $v1, %lo(gDisplayListHead)
  /* 1706C0 80131B60 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 1706C4 80131B64 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 1706C8 80131B68 AFBF0014 */        sw $ra, 0x14($sp)
  /* 1706CC 80131B6C 244E0008 */     addiu $t6, $v0, 8
  /* 1706D0 80131B70 AC6E0000 */        sw $t6, ($v1) # gDisplayListHead + 0
  /* 1706D4 80131B74 3C0FE700 */       lui $t7, 0xe700
  /* 1706D8 80131B78 AC4F0000 */        sw $t7, ($v0)
  /* 1706DC 80131B7C AC400004 */        sw $zero, 4($v0)
  /* 1706E0 80131B80 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 1706E4 80131B84 3C19E300 */       lui $t9, (0xE3000A01 >> 16) # 3808430593
  /* 1706E8 80131B88 37390A01 */       ori $t9, $t9, (0xE3000A01 & 0xFFFF) # 3808430593
  /* 1706EC 80131B8C 24580008 */     addiu $t8, $v0, 8
  /* 1706F0 80131B90 AC780000 */        sw $t8, ($v1) # gDisplayListHead + 0
  /* 1706F4 80131B94 AC400004 */        sw $zero, 4($v0)
  /* 1706F8 80131B98 AC590000 */        sw $t9, ($v0)
  /* 1706FC 80131B9C 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 170700 80131BA0 3C09E200 */       lui $t1, (0xE200001C >> 16) # 3791650844
  /* 170704 80131BA4 3C0A0055 */       lui $t2, (0x552048 >> 16) # 5578824
  /* 170708 80131BA8 24480008 */     addiu $t0, $v0, 8
  /* 17070C 80131BAC AC680000 */        sw $t0, ($v1) # gDisplayListHead + 0
  /* 170710 80131BB0 354A2048 */       ori $t2, $t2, (0x552048 & 0xFFFF) # 5578824
  /* 170714 80131BB4 3529001C */       ori $t1, $t1, (0xE200001C & 0xFFFF) # 3791650844
  /* 170718 80131BB8 AC490000 */        sw $t1, ($v0)
  /* 17071C 80131BBC 0C00500E */       jal odRenderDObjTreeForGObj
  /* 170720 80131BC0 AC4A0004 */        sw $t2, 4($v0)
  /* 170724 80131BC4 3C038004 */       lui $v1, %hi(gDisplayListHead)
  /* 170728 80131BC8 246365B0 */     addiu $v1, $v1, %lo(gDisplayListHead)
  /* 17072C 80131BCC 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 170730 80131BD0 3C0CE700 */       lui $t4, 0xe700
  /* 170734 80131BD4 3C0EE300 */       lui $t6, (0xE3000A01 >> 16) # 3808430593
  /* 170738 80131BD8 244B0008 */     addiu $t3, $v0, 8
  /* 17073C 80131BDC AC6B0000 */        sw $t3, ($v1) # gDisplayListHead + 0
  /* 170740 80131BE0 AC400004 */        sw $zero, 4($v0)
  /* 170744 80131BE4 AC4C0000 */        sw $t4, ($v0)
  /* 170748 80131BE8 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 17074C 80131BEC 35CE0A01 */       ori $t6, $t6, (0xE3000A01 & 0xFFFF) # 3808430593
  /* 170750 80131BF0 3C18E200 */       lui $t8, (0xE200001C >> 16) # 3791650844
  /* 170754 80131BF4 244D0008 */     addiu $t5, $v0, 8
  /* 170758 80131BF8 AC6D0000 */        sw $t5, ($v1) # gDisplayListHead + 0
  /* 17075C 80131BFC AC400004 */        sw $zero, 4($v0)
  /* 170760 80131C00 AC4E0000 */        sw $t6, ($v0)
  /* 170764 80131C04 8C620000 */        lw $v0, ($v1) # gDisplayListHead + 0
  /* 170768 80131C08 3C190055 */       lui $t9, (0x552078 >> 16) # 5578872
  /* 17076C 80131C0C 37392078 */       ori $t9, $t9, (0x552078 & 0xFFFF) # 5578872
  /* 170770 80131C10 244F0008 */     addiu $t7, $v0, 8
  /* 170774 80131C14 AC6F0000 */        sw $t7, ($v1) # gDisplayListHead + 0
  /* 170778 80131C18 3718001C */       ori $t8, $t8, (0xE200001C & 0xFFFF) # 3791650844
  /* 17077C 80131C1C AC580000 */        sw $t8, ($v0)
  /* 170780 80131C20 AC590004 */        sw $t9, 4($v0)
  /* 170784 80131C24 8FBF0014 */        lw $ra, 0x14($sp)
  /* 170788 80131C28 27BD0018 */     addiu $sp, $sp, 0x18
  /* 17078C 80131C2C 03E00008 */        jr $ra
  /* 170790 80131C30 00000000 */       nop

glabel mvOpeningLinkHillCreateHills
  /* 170794 80131C34 27BDFFD8 */     addiu $sp, $sp, -0x28
  /* 170798 80131C38 AFBF001C */        sw $ra, 0x1c($sp)
  /* 17079C 80131C3C 00002025 */        or $a0, $zero, $zero
  /* 1707A0 80131C40 00002825 */        or $a1, $zero, $zero
  /* 1707A4 80131C44 24060011 */     addiu $a2, $zero, 0x11
  /* 1707A8 80131C48 0C00265A */       jal omMakeGObjCommon
  /* 1707AC 80131C4C 3C078000 */       lui $a3, 0x8000
  /* 1707B0 80131C50 3C0E8013 */       lui $t6, %hi(D_ovl46_80132998)
  /* 1707B4 80131C54 8DCE2998 */        lw $t6, %lo(D_ovl46_80132998)($t6)
  /* 1707B8 80131C58 3C0F0000 */       lui $t7, %hi(D_NF_000037A0)
  /* 1707BC 80131C5C 25EF37A0 */     addiu $t7, $t7, %lo(D_NF_000037A0)
  /* 1707C0 80131C60 AFA20024 */        sw $v0, 0x24($sp)
  /* 1707C4 80131C64 00402025 */        or $a0, $v0, $zero
  /* 1707C8 80131C68 00003025 */        or $a2, $zero, $zero
  /* 1707CC 80131C6C 0C003C48 */       jal func_8000F120
  /* 1707D0 80131C70 01CF2821 */      addu $a1, $t6, $t7
  /* 1707D4 80131C74 3C058013 */       lui $a1, %hi(mvOpeningLinkHillRenderHills)
  /* 1707D8 80131C78 2418FFFF */     addiu $t8, $zero, -1
  /* 1707DC 80131C7C AFB80010 */        sw $t8, 0x10($sp)
  /* 1707E0 80131C80 24A51B58 */     addiu $a1, $a1, %lo(mvOpeningLinkHillRenderHills)
  /* 1707E4 80131C84 8FA40024 */        lw $a0, 0x24($sp)
  /* 1707E8 80131C88 2406001A */     addiu $a2, $zero, 0x1a
  /* 1707EC 80131C8C 0C00277D */       jal omAddGObjRenderProc
  /* 1707F0 80131C90 3C078000 */       lui $a3, 0x8000
  /* 1707F4 80131C94 8FBF001C */        lw $ra, 0x1c($sp)
  /* 1707F8 80131C98 27BD0028 */     addiu $sp, $sp, 0x28
  /* 1707FC 80131C9C 03E00008 */        jr $ra
  /* 170800 80131CA0 00000000 */       nop

  /* 170804 80131CA4 03E00008 */        jr $ra
  /* 170808 80131CA8 00000000 */       nop

glabel mvOpeningLinkHillCreateFighter
  /* 17080C 80131CAC 27BDFFA0 */     addiu $sp, $sp, -0x60
  /* 170810 80131CB0 3C0F8011 */       lui $t7, %hi(dFTDefaultFighterDesc)
  /* 170814 80131CB4 25EF6DD0 */     addiu $t7, $t7, %lo(dFTDefaultFighterDesc)
  /* 170818 80131CB8 AFBF0014 */        sw $ra, 0x14($sp)
  /* 17081C 80131CBC 25E8003C */     addiu $t0, $t7, 0x3c
  /* 170820 80131CC0 27AE001C */     addiu $t6, $sp, 0x1c
  .L80131CC4:
  /* 170824 80131CC4 8DF90000 */        lw $t9, ($t7) # dFTDefaultFighterDesc + 0
  /* 170828 80131CC8 25EF000C */     addiu $t7, $t7, 0xc
  /* 17082C 80131CCC 25CE000C */     addiu $t6, $t6, 0xc
  /* 170830 80131CD0 ADD9FFF4 */        sw $t9, -0xc($t6)
  /* 170834 80131CD4 8DF8FFF8 */        lw $t8, -8($t7) # dFTDefaultFighterDesc + -8
  /* 170838 80131CD8 ADD8FFF8 */        sw $t8, -8($t6)
  /* 17083C 80131CDC 8DF9FFFC */        lw $t9, -4($t7) # dFTDefaultFighterDesc + -4
  /* 170840 80131CE0 15E8FFF8 */       bne $t7, $t0, .L80131CC4
  /* 170844 80131CE4 ADD9FFFC */        sw $t9, -4($t6)
  /* 170848 80131CE8 8DF90000 */        lw $t9, ($t7) # dFTDefaultFighterDesc + 0
  /* 17084C 80131CEC 24090005 */     addiu $t1, $zero, 5
  /* 170850 80131CF0 24040005 */     addiu $a0, $zero, 5
  /* 170854 80131CF4 ADD90000 */        sw $t9, ($t6)
  /* 170858 80131CF8 AFA9001C */        sw $t1, 0x1c($sp)
  /* 17085C 80131CFC 0C03B03B */       jal ftCostume_GetIndexFFA
  /* 170860 80131D00 00002825 */        or $a1, $zero, $zero
  /* 170864 80131D04 44800000 */      mtc1 $zero, $f0
  /* 170868 80131D08 3C0A8013 */       lui $t2, %hi(gMvOpeningLinkHillFighterAnimHeap)
  /* 17086C 80131D0C 8D4A27C8 */        lw $t2, %lo(gMvOpeningLinkHillFighterAnimHeap)($t2)
  /* 170870 80131D10 A3A20033 */        sb $v0, 0x33($sp)
  /* 170874 80131D14 27A4001C */     addiu $a0, $sp, 0x1c
  /* 170878 80131D18 E7A00020 */      swc1 $f0, 0x20($sp)
  /* 17087C 80131D1C E7A00024 */      swc1 $f0, 0x24($sp)
  /* 170880 80131D20 E7A00028 */      swc1 $f0, 0x28($sp)
  /* 170884 80131D24 0C035FCF */       jal ftManager_MakeFighter
  /* 170888 80131D28 AFAA0054 */        sw $t2, 0x54($sp)
  /* 17088C 80131D2C 3C018013 */       lui $at, %hi(gMvOpeningLinkHillFighterGObj)
  /* 170890 80131D30 3C050001 */       lui $a1, (0x1000F >> 16) # 65551
  /* 170894 80131D34 AC2227D4 */        sw $v0, %lo(gMvOpeningLinkHillFighterGObj)($at)
  /* 170898 80131D38 34A5000F */       ori $a1, $a1, (0x1000F & 0xFFFF) # 65551
  /* 17089C 80131D3C 00402025 */        or $a0, $v0, $zero
  /* 1708A0 80131D40 0C0E4173 */       jal func_ovl1_803905CC
  /* 1708A4 80131D44 AFA2005C */        sw $v0, 0x5c($sp)
  /* 1708A8 80131D48 8FA4005C */        lw $a0, 0x5c($sp)
  /* 1708AC 80131D4C 2405001C */     addiu $a1, $zero, 0x1c
  /* 1708B0 80131D50 0C002834 */       jal omMoveGObjDL
  /* 1708B4 80131D54 2406FFFF */     addiu $a2, $zero, -1
  /* 1708B8 80131D58 8FA7005C */        lw $a3, 0x5c($sp)
  /* 1708BC 80131D5C 3C013F80 */       lui $at, (0x3F800000 >> 16) # 1.0
  /* 1708C0 80131D60 44810000 */      mtc1 $at, $f0 # 1.0 to cop1
  /* 1708C4 80131D64 8CEB0074 */        lw $t3, 0x74($a3)
  /* 1708C8 80131D68 E5600040 */      swc1 $f0, 0x40($t3)
  /* 1708CC 80131D6C 8CEC0074 */        lw $t4, 0x74($a3)
  /* 1708D0 80131D70 E5800044 */      swc1 $f0, 0x44($t4)
  /* 1708D4 80131D74 8CED0074 */        lw $t5, 0x74($a3)
  /* 1708D8 80131D78 E5A00048 */      swc1 $f0, 0x48($t5)
  /* 1708DC 80131D7C 8FBF0014 */        lw $ra, 0x14($sp)
  /* 1708E0 80131D80 27BD0060 */     addiu $sp, $sp, 0x60
  /* 1708E4 80131D84 03E00008 */        jr $ra
  /* 1708E8 80131D88 00000000 */       nop

glabel mvOpeningLinkHillScrollBackground
  /* 1708EC 80131D8C 3C058013 */       lui $a1, %hi(gMvOpeningLinkHillFramesElapsed)
  /* 1708F0 80131D90 8CA527CC */        lw $a1, %lo(gMvOpeningLinkHillFramesElapsed)($a1)
  /* 1708F4 80131D94 24010001 */     addiu $at, $zero, 1
  /* 1708F8 80131D98 8C820074 */        lw $v0, 0x74($a0)
  /* 1708FC 80131D9C 10A1000C */       beq $a1, $at, .L80131DD0
  /* 170900 80131DA0 00A01825 */        or $v1, $a1, $zero
  /* 170904 80131DA4 24010050 */     addiu $at, $zero, 0x50
  /* 170908 80131DA8 1061000F */       beq $v1, $at, .L80131DE8
  /* 17090C 80131DAC 2401005A */     addiu $at, $zero, 0x5a
  /* 170910 80131DB0 10610013 */       beq $v1, $at, .L80131E00
  /* 170914 80131DB4 24010078 */     addiu $at, $zero, 0x78
  /* 170918 80131DB8 10610017 */       beq $v1, $at, .L80131E18
  /* 17091C 80131DBC 240100B4 */     addiu $at, $zero, 0xb4
  /* 170920 80131DC0 1061001B */       beq $v1, $at, .L80131E30
  /* 170924 80131DC4 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170928 80131DC8 1000001D */         b .L80131E40
  /* 17092C 80131DCC 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  .L80131DD0:
  /* 170930 80131DD0 3C014170 */       lui $at, (0x41700000 >> 16) # 15.0
  /* 170934 80131DD4 44812000 */      mtc1 $at, $f4 # 15.0 to cop1
  /* 170938 80131DD8 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 17093C 80131DDC 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170940 80131DE0 10000017 */         b .L80131E40
  /* 170944 80131DE4 E4640000 */      swc1 $f4, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131DE8:
  /* 170948 80131DE8 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 17094C 80131DEC 44813000 */      mtc1 $at, $f6 # 10.0 to cop1
  /* 170950 80131DF0 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170954 80131DF4 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170958 80131DF8 10000011 */         b .L80131E40
  /* 17095C 80131DFC E4660000 */      swc1 $f6, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E00:
  /* 170960 80131E00 3C0140C0 */       lui $at, (0x40C00000 >> 16) # 6.0
  /* 170964 80131E04 44814000 */      mtc1 $at, $f8 # 6.0 to cop1
  /* 170968 80131E08 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 17096C 80131E0C 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170970 80131E10 1000000B */         b .L80131E40
  /* 170974 80131E14 E4680000 */      swc1 $f8, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E18:
  /* 170978 80131E18 3C014000 */       lui $at, (0x40000000 >> 16) # 2.0
  /* 17097C 80131E1C 44815000 */      mtc1 $at, $f10 # 2.0 to cop1
  /* 170980 80131E20 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170984 80131E24 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170988 80131E28 10000005 */         b .L80131E40
  /* 17098C 80131E2C E46A0000 */      swc1 $f10, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E30:
  /* 170990 80131E30 44808000 */      mtc1 $zero, $f16
  /* 170994 80131E34 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 170998 80131E38 246327D8 */     addiu $v1, $v1, %lo(gMvOpeningLinkHillBackgroundScrollSpeed)
  /* 17099C 80131E3C E4700000 */      swc1 $f16, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E40:
  /* 1709A0 80131E40 28A10002 */      slti $at, $a1, 2
  /* 1709A4 80131E44 14200007 */      bnez $at, .L80131E64
  /* 1709A8 80131E48 28A10050 */      slti $at, $a1, 0x50
  /* 1709AC 80131E4C 10200005 */      beqz $at, .L80131E64
  /* 1709B0 80131E50 3C018013 */       lui $at, %hi(D_ovl46_801327B0)
  /* 1709B4 80131E54 C42427B0 */      lwc1 $f4, %lo(D_ovl46_801327B0)($at)
  /* 1709B8 80131E58 C4720000 */      lwc1 $f18, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  /* 1709BC 80131E5C 46049180 */     add.s $f6, $f18, $f4
  /* 1709C0 80131E60 E4660000 */      swc1 $f6, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E64:
  /* 1709C4 80131E64 28A10051 */      slti $at, $a1, 0x51
  /* 1709C8 80131E68 14200007 */      bnez $at, .L80131E88
  /* 1709CC 80131E6C 28A1005A */      slti $at, $a1, 0x5a
  /* 1709D0 80131E70 10200005 */      beqz $at, .L80131E88
  /* 1709D4 80131E74 3C018013 */       lui $at, %hi(D_ovl46_801327B4)
  /* 1709D8 80131E78 C42A27B4 */      lwc1 $f10, %lo(D_ovl46_801327B4)($at)
  /* 1709DC 80131E7C C4680000 */      lwc1 $f8, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  /* 1709E0 80131E80 460A4400 */     add.s $f16, $f8, $f10
  /* 1709E4 80131E84 E4700000 */      swc1 $f16, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131E88:
  /* 1709E8 80131E88 28A1005B */      slti $at, $a1, 0x5b
  /* 1709EC 80131E8C 14200007 */      bnez $at, .L80131EAC
  /* 1709F0 80131E90 28A10078 */      slti $at, $a1, 0x78
  /* 1709F4 80131E94 10200005 */      beqz $at, .L80131EAC
  /* 1709F8 80131E98 3C018013 */       lui $at, %hi(D_ovl46_801327B8)
  /* 1709FC 80131E9C C42427B8 */      lwc1 $f4, %lo(D_ovl46_801327B8)($at)
  /* 170A00 80131EA0 C4720000 */      lwc1 $f18, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  /* 170A04 80131EA4 46049180 */     add.s $f6, $f18, $f4
  /* 170A08 80131EA8 E4660000 */      swc1 $f6, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131EAC:
  /* 170A0C 80131EAC 28A10079 */      slti $at, $a1, 0x79
  /* 170A10 80131EB0 14200007 */      bnez $at, .L80131ED0
  /* 170A14 80131EB4 28A100B4 */      slti $at, $a1, 0xb4
  /* 170A18 80131EB8 10200005 */      beqz $at, .L80131ED0
  /* 170A1C 80131EBC 3C018013 */       lui $at, %hi(D_ovl46_801327BC)
  /* 170A20 80131EC0 C42A27BC */      lwc1 $f10, %lo(D_ovl46_801327BC)($at)
  /* 170A24 80131EC4 C4680000 */      lwc1 $f8, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  /* 170A28 80131EC8 460A4400 */     add.s $f16, $f8, $f10
  /* 170A2C 80131ECC E4700000 */      swc1 $f16, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  .L80131ED0:
  /* 170A30 80131ED0 C4520058 */      lwc1 $f18, 0x58($v0)
  /* 170A34 80131ED4 C4640000 */      lwc1 $f4, ($v1) # gMvOpeningLinkHillBackgroundScrollSpeed + 0
  /* 170A38 80131ED8 3C01C3A0 */       lui $at, (0xC3A00000 >> 16) # -320.0
  /* 170A3C 80131EDC 44814000 */      mtc1 $at, $f8 # -320.0 to cop1
  /* 170A40 80131EE0 46049181 */     sub.s $f6, $f18, $f4
  /* 170A44 80131EE4 3C0143A0 */       lui $at, 0x43a0
  /* 170A48 80131EE8 E4460058 */      swc1 $f6, 0x58($v0)
  /* 170A4C 80131EEC C4400058 */      lwc1 $f0, 0x58($v0)
  /* 170A50 80131EF0 4608003C */    c.lt.s $f0, $f8
  /* 170A54 80131EF4 00000000 */       nop
  /* 170A58 80131EF8 45020007 */     bc1fl .L80131F18
  /* 170A5C 80131EFC 3C0143A0 */       lui $at, (0x43A00000 >> 16) # 320.0
  /* 170A60 80131F00 44815000 */      mtc1 $at, $f10 # 320.0 to cop1
  /* 170A64 80131F04 00000000 */       nop
  /* 170A68 80131F08 460A0400 */     add.s $f16, $f0, $f10
  /* 170A6C 80131F0C E4500058 */      swc1 $f16, 0x58($v0)
  /* 170A70 80131F10 C4400058 */      lwc1 $f0, 0x58($v0)
  /* 170A74 80131F14 3C0143A0 */       lui $at, (0x43A00000 >> 16) # 320.0
  .L80131F18:
  /* 170A78 80131F18 44819000 */      mtc1 $at, $f18 # 320.0 to cop1
  /* 170A7C 80131F1C 8C4E0008 */        lw $t6, 8($v0)
  /* 170A80 80131F20 46120100 */     add.s $f4, $f0, $f18
  /* 170A84 80131F24 03E00008 */        jr $ra
  /* 170A88 80131F28 E5C40058 */      swc1 $f4, 0x58($t6)

glabel mvOpeningLinkHillCreateBackground
  /* 170A8C 80131F2C 27BDFFD0 */     addiu $sp, $sp, -0x30
  /* 170A90 80131F30 AFBF001C */        sw $ra, 0x1c($sp)
  /* 170A94 80131F34 00002025 */        or $a0, $zero, $zero
  /* 170A98 80131F38 00002825 */        or $a1, $zero, $zero
  /* 170A9C 80131F3C 24060012 */     addiu $a2, $zero, 0x12
  /* 170AA0 80131F40 0C00265A */       jal omMakeGObjCommon
  /* 170AA4 80131F44 3C078000 */       lui $a3, 0x8000
  /* 170AA8 80131F48 3C05800D */       lui $a1, %hi(func_ovl0_800CCF00)
  /* 170AAC 80131F4C 240EFFFF */     addiu $t6, $zero, -1
  /* 170AB0 80131F50 AFA2002C */        sw $v0, 0x2c($sp)
  /* 170AB4 80131F54 AFAE0010 */        sw $t6, 0x10($sp)
  /* 170AB8 80131F58 24A5CF00 */     addiu $a1, $a1, %lo(func_ovl0_800CCF00)
  /* 170ABC 80131F5C 00402025 */        or $a0, $v0, $zero
  /* 170AC0 80131F60 2406001B */     addiu $a2, $zero, 0x1b
  /* 170AC4 80131F64 0C00277D */       jal omAddGObjRenderProc
  /* 170AC8 80131F68 3C078000 */       lui $a3, 0x8000
  /* 170ACC 80131F6C 3C058013 */       lui $a1, %hi(mvOpeningLinkHillScrollBackground)
  /* 170AD0 80131F70 24A51D8C */     addiu $a1, $a1, %lo(mvOpeningLinkHillScrollBackground)
  /* 170AD4 80131F74 8FA4002C */        lw $a0, 0x2c($sp)
  /* 170AD8 80131F78 24060001 */     addiu $a2, $zero, 1
  /* 170ADC 80131F7C 0C002062 */       jal omAddGObjCommonProc
  /* 170AE0 80131F80 24070001 */     addiu $a3, $zero, 1
  /* 170AE4 80131F84 3C0F8013 */       lui $t7, %hi(D_ovl46_8013299C)
  /* 170AE8 80131F88 8DEF299C */        lw $t7, %lo(D_ovl46_8013299C)($t7)
  /* 170AEC 80131F8C 3C030001 */       lui $v1, %hi(D_NF_0000B500)
  /* 170AF0 80131F90 2463B500 */     addiu $v1, $v1, %lo(D_NF_0000B500)
  /* 170AF4 80131F94 AFA30024 */        sw $v1, 0x24($sp)
  /* 170AF8 80131F98 8FA4002C */        lw $a0, 0x2c($sp)
  /* 170AFC 80131F9C 0C0333F7 */       jal gcAppendSObjWithSprite
  /* 170B00 80131FA0 01E32821 */      addu $a1, $t7, $v1
  /* 170B04 80131FA4 8FA30024 */        lw $v1, 0x24($sp)
  /* 170B08 80131FA8 3C014000 */       lui $at, (0x40000000 >> 16) # 2.0
  /* 170B0C 80131FAC 44810000 */      mtc1 $at, $f0 # 2.0 to cop1
  /* 170B10 80131FB0 44801000 */      mtc1 $zero, $f2
  /* 170B14 80131FB4 94580024 */       lhu $t8, 0x24($v0)
  /* 170B18 80131FB8 3C088013 */       lui $t0, %hi(D_ovl46_8013299C)
  /* 170B1C 80131FBC E4400018 */      swc1 $f0, 0x18($v0)
  /* 170B20 80131FC0 3319FFDF */      andi $t9, $t8, 0xffdf
  /* 170B24 80131FC4 A4590024 */        sh $t9, 0x24($v0)
  /* 170B28 80131FC8 E440001C */      swc1 $f0, 0x1c($v0)
  /* 170B2C 80131FCC E4420058 */      swc1 $f2, 0x58($v0)
  /* 170B30 80131FD0 E442005C */      swc1 $f2, 0x5c($v0)
  /* 170B34 80131FD4 8D08299C */        lw $t0, %lo(D_ovl46_8013299C)($t0)
  /* 170B38 80131FD8 8FA4002C */        lw $a0, 0x2c($sp)
  /* 170B3C 80131FDC 0C0333F7 */       jal gcAppendSObjWithSprite
  /* 170B40 80131FE0 01032821 */      addu $a1, $t0, $v1
  /* 170B44 80131FE4 3C014000 */       lui $at, (0x40000000 >> 16) # 2.0
  /* 170B48 80131FE8 44810000 */      mtc1 $at, $f0 # 2.0 to cop1
  /* 170B4C 80131FEC 94490024 */       lhu $t1, 0x24($v0)
  /* 170B50 80131FF0 3C0143A0 */       lui $at, (0x43A00000 >> 16) # 320.0
  /* 170B54 80131FF4 44812000 */      mtc1 $at, $f4 # 320.0 to cop1
  /* 170B58 80131FF8 44803000 */      mtc1 $zero, $f6
  /* 170B5C 80131FFC 312AFFDF */      andi $t2, $t1, 0xffdf
  /* 170B60 80132000 A44A0024 */        sh $t2, 0x24($v0)
  /* 170B64 80132004 E4400018 */      swc1 $f0, 0x18($v0)
  /* 170B68 80132008 E440001C */      swc1 $f0, 0x1c($v0)
  /* 170B6C 8013200C E4440058 */      swc1 $f4, 0x58($v0)
  /* 170B70 80132010 E446005C */      swc1 $f6, 0x5c($v0)
  /* 170B74 80132014 8FBF001C */        lw $ra, 0x1c($sp)
  /* 170B78 80132018 27BD0030 */     addiu $sp, $sp, 0x30
  /* 170B7C 8013201C 03E00008 */        jr $ra
  /* 170B80 80132020 00000000 */       nop

glabel mvOpeningLinkHillCreateOcarina
  /* 170B84 80132024 27BDFFD8 */     addiu $sp, $sp, -0x28
  /* 170B88 80132028 AFBF0024 */        sw $ra, 0x24($sp)
  /* 170B8C 8013202C AFB00020 */        sw $s0, 0x20($sp)
  /* 170B90 80132030 00002025 */        or $a0, $zero, $zero
  /* 170B94 80132034 00002825 */        or $a1, $zero, $zero
  /* 170B98 80132038 24060011 */     addiu $a2, $zero, 0x11
  /* 170B9C 8013203C 0C00265A */       jal omMakeGObjCommon
  /* 170BA0 80132040 3C078000 */       lui $a3, 0x8000
  /* 170BA4 80132044 3C0E8013 */       lui $t6, %hi(D_ovl46_80132998)
  /* 170BA8 80132048 8DCE2998 */        lw $t6, %lo(D_ovl46_80132998)($t6)
  /* 170BAC 8013204C 3C0F0000 */       lui $t7, %hi(D_NF_000067A0)
  /* 170BB0 80132050 3C018013 */       lui $at, %hi(gMvOpeningLinkHillOcarinaGObj)
  /* 170BB4 80132054 25EF67A0 */     addiu $t7, $t7, %lo(D_NF_000067A0)
  /* 170BB8 80132058 AC2227D0 */        sw $v0, %lo(gMvOpeningLinkHillOcarinaGObj)($at)
  /* 170BBC 8013205C 00408025 */        or $s0, $v0, $zero
  /* 170BC0 80132060 00402025 */        or $a0, $v0, $zero
  /* 170BC4 80132064 00003025 */        or $a2, $zero, $zero
  /* 170BC8 80132068 2407001C */     addiu $a3, $zero, 0x1c
  /* 170BCC 8013206C AFA00010 */        sw $zero, 0x10($sp)
  /* 170BD0 80132070 AFA00014 */        sw $zero, 0x14($sp)
  /* 170BD4 80132074 0C003D64 */       jal func_8000F590
  /* 170BD8 80132078 01CF2821 */      addu $a1, $t6, $t7
  /* 170BDC 8013207C 3C058001 */       lui $a1, %hi(odRenderDObjTreeForGObj)
  /* 170BE0 80132080 2418FFFF */     addiu $t8, $zero, -1
  /* 170BE4 80132084 AFB80010 */        sw $t8, 0x10($sp)
  /* 170BE8 80132088 24A54038 */     addiu $a1, $a1, %lo(odRenderDObjTreeForGObj)
  /* 170BEC 8013208C 02002025 */        or $a0, $s0, $zero
  /* 170BF0 80132090 2406001A */     addiu $a2, $zero, 0x1a
  /* 170BF4 80132094 0C00277D */       jal omAddGObjRenderProc
  /* 170BF8 80132098 3C078000 */       lui $a3, 0x8000
  /* 170BFC 8013209C 3C028013 */       lui $v0, %hi(gMvOpeningLinkHillFighterGObj)
  /* 170C00 801320A0 244227D4 */     addiu $v0, $v0, %lo(gMvOpeningLinkHillFighterGObj)
  /* 170C04 801320A4 8C590000 */        lw $t9, ($v0) # gMvOpeningLinkHillFighterGObj + 0
  /* 170C08 801320A8 8E090074 */        lw $t1, 0x74($s0)
  /* 170C0C 801320AC 3C188013 */       lui $t8, %hi(D_ovl46_80132998)
  /* 170C10 801320B0 8F280074 */        lw $t0, 0x74($t9)
  /* 170C14 801320B4 3C190000 */       lui $t9, %hi(D_NF_00006850)
  /* 170C18 801320B8 27396850 */     addiu $t9, $t9, %lo(D_NF_00006850)
  /* 170C1C 801320BC C5040040 */      lwc1 $f4, 0x40($t0)
  /* 170C20 801320C0 02002025 */        or $a0, $s0, $zero
  /* 170C24 801320C4 24060000 */     addiu $a2, $zero, 0
  /* 170C28 801320C8 E5240040 */      swc1 $f4, 0x40($t1)
  /* 170C2C 801320CC 8C4A0000 */        lw $t2, ($v0) # gMvOpeningLinkHillFighterGObj + 0
  /* 170C30 801320D0 8E0C0074 */        lw $t4, 0x74($s0)
  /* 170C34 801320D4 8D4B0074 */        lw $t3, 0x74($t2)
  /* 170C38 801320D8 C5660044 */      lwc1 $f6, 0x44($t3)
  /* 170C3C 801320DC E5860044 */      swc1 $f6, 0x44($t4)
  /* 170C40 801320E0 8C4D0000 */        lw $t5, ($v0) # gMvOpeningLinkHillFighterGObj + 0
  /* 170C44 801320E4 8E0F0074 */        lw $t7, 0x74($s0)
  /* 170C48 801320E8 8DAE0074 */        lw $t6, 0x74($t5)
  /* 170C4C 801320EC C5C80048 */      lwc1 $f8, 0x48($t6)
  /* 170C50 801320F0 E5E80048 */      swc1 $f8, 0x48($t7)
  /* 170C54 801320F4 8F182998 */        lw $t8, %lo(D_ovl46_80132998)($t8)
  /* 170C58 801320F8 0C002F63 */       jal func_8000BD8C
  /* 170C5C 801320FC 03192821 */      addu $a1, $t8, $t9
  /* 170C60 80132100 3C058001 */       lui $a1, %hi(func_8000DF34)
  /* 170C64 80132104 24A5DF34 */     addiu $a1, $a1, %lo(func_8000DF34)
  /* 170C68 80132108 02002025 */        or $a0, $s0, $zero
  /* 170C6C 8013210C 24060001 */     addiu $a2, $zero, 1
  /* 170C70 80132110 0C002062 */       jal omAddGObjCommonProc
  /* 170C74 80132114 24070001 */     addiu $a3, $zero, 1
  /* 170C78 80132118 8FBF0024 */        lw $ra, 0x24($sp)
  /* 170C7C 8013211C 8FB00020 */        lw $s0, 0x20($sp)
  /* 170C80 80132120 27BD0028 */     addiu $sp, $sp, 0x28
  /* 170C84 80132124 03E00008 */        jr $ra
  /* 170C88 80132128 00000000 */       nop

glabel mvOpeningLinkHillMainCameraProc
  /* 170C8C 8013212C 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 170C90 80132130 AFBF0014 */        sw $ra, 0x14($sp)
  /* 170C94 80132134 0C004160 */       jal func_80010580
  /* 170C98 80132138 00000000 */       nop
  /* 170C9C 8013213C 8FBF0014 */        lw $ra, 0x14($sp)
  /* 170CA0 80132140 27BD0018 */     addiu $sp, $sp, 0x18
  /* 170CA4 80132144 03E00008 */        jr $ra
  /* 170CA8 80132148 00000000 */       nop

glabel mvOpeningLinkHillCreateMainViewport
  /* 170CAC 8013214C 27BDFFA0 */     addiu $sp, $sp, -0x60
  /* 170CB0 80132150 3C028001 */       lui $v0, %hi(func_80017EC0)
  /* 170CB4 80132154 AFBF0044 */        sw $ra, 0x44($sp)
  /* 170CB8 80132158 24427EC0 */     addiu $v0, $v0, %lo(func_80017EC0)
  /* 170CBC 8013215C 240E0050 */     addiu $t6, $zero, 0x50
  /* 170CC0 80132160 24180000 */     addiu $t8, $zero, 0
  /* 170CC4 80132164 3C190400 */       lui $t9, 0x400
  /* 170CC8 80132168 240FFFFF */     addiu $t7, $zero, -1
  /* 170CCC 8013216C 24080001 */     addiu $t0, $zero, 1
  /* 170CD0 80132170 24090001 */     addiu $t1, $zero, 1
  /* 170CD4 80132174 AFB10040 */        sw $s1, 0x40($sp)
  /* 170CD8 80132178 AFB0003C */        sw $s0, 0x3c($sp)
  /* 170CDC 8013217C AFA90030 */        sw $t1, 0x30($sp)
  /* 170CE0 80132180 AFA80028 */        sw $t0, 0x28($sp)
  /* 170CE4 80132184 AFAF0020 */        sw $t7, 0x20($sp)
  /* 170CE8 80132188 AFB9001C */        sw $t9, 0x1c($sp)
  /* 170CEC 8013218C AFB80018 */        sw $t8, 0x18($sp)
  /* 170CF0 80132190 AFAE0014 */        sw $t6, 0x14($sp)
  /* 170CF4 80132194 AFA20010 */        sw $v0, 0x10($sp)
  /* 170CF8 80132198 AFA20054 */        sw $v0, 0x54($sp)
  /* 170CFC 8013219C AFA00024 */        sw $zero, 0x24($sp)
  /* 170D00 801321A0 AFA0002C */        sw $zero, 0x2c($sp)
  /* 170D04 801321A4 AFA00034 */        sw $zero, 0x34($sp)
  /* 170D08 801321A8 24040401 */     addiu $a0, $zero, 0x401
  /* 170D0C 801321AC 00002825 */        or $a1, $zero, $zero
  /* 170D10 801321B0 24060010 */     addiu $a2, $zero, 0x10
  /* 170D14 801321B4 0C002E4F */       jal func_8000B93C
  /* 170D18 801321B8 3C078000 */       lui $a3, 0x8000
  /* 170D1C 801321BC 00408825 */        or $s1, $v0, $zero
  /* 170D20 801321C0 8C440074 */        lw $a0, 0x74($v0)
  /* 170D24 801321C4 24050004 */     addiu $a1, $zero, 4
  /* 170D28 801321C8 0C00233C */       jal omAddOMMtxForCamera
  /* 170D2C 801321CC 00003025 */        or $a2, $zero, $zero
  /* 170D30 801321D0 8E240074 */        lw $a0, 0x74($s1)
  /* 170D34 801321D4 24050006 */     addiu $a1, $zero, 6
  /* 170D38 801321D8 0C00233C */       jal omAddOMMtxForCamera
  /* 170D3C 801321DC 00003025 */        or $a2, $zero, $zero
  /* 170D40 801321E0 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 170D44 801321E4 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 170D48 801321E8 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 170D4C 801321EC 8E300074 */        lw $s0, 0x74($s1)
  /* 170D50 801321F0 44812000 */      mtc1 $at, $f4 # 230.0 to cop1
  /* 170D54 801321F4 44050000 */      mfc1 $a1, $f0
  /* 170D58 801321F8 44060000 */      mfc1 $a2, $f0
  /* 170D5C 801321FC 3C07439B */       lui $a3, 0x439b
  /* 170D60 80132200 26040008 */     addiu $a0, $s0, 8
  /* 170D64 80132204 0C001C20 */       jal func_80007080
  /* 170D68 80132208 E7A40010 */      swc1 $f4, 0x10($sp)
  /* 170D6C 8013220C 3C014300 */       lui $at, (0x43000000 >> 16) # 128.0
  /* 170D70 80132210 44813000 */      mtc1 $at, $f6 # 128.0 to cop1
  /* 170D74 80132214 3C014680 */       lui $at, (0x46800000 >> 16) # 16384.0
  /* 170D78 80132218 44814000 */      mtc1 $at, $f8 # 16384.0 to cop1
  /* 170D7C 8013221C 3C0A8013 */       lui $t2, %hi(D_ovl46_80132998)
  /* 170D80 80132220 E6060028 */      swc1 $f6, 0x28($s0)
  /* 170D84 80132224 E608002C */      swc1 $f8, 0x2c($s0)
  /* 170D88 80132228 8D4A2998 */        lw $t2, %lo(D_ovl46_80132998)($t2)
  /* 170D8C 8013222C 3C020001 */       lui $v0, %hi(D_NF_00008910)
  /* 170D90 80132230 24428910 */     addiu $v0, $v0, %lo(D_NF_00008910)
  /* 170D94 80132234 AFA20050 */        sw $v0, 0x50($sp)
  /* 170D98 80132238 02002025 */        or $a0, $s0, $zero
  /* 170D9C 8013223C 24060000 */     addiu $a2, $zero, 0
  /* 170DA0 80132240 0C003E8F */       jal func_8000FA3C
  /* 170DA4 80132244 01422821 */      addu $a1, $t2, $v0
  /* 170DA8 80132248 3C058013 */       lui $a1, %hi(mvOpeningLinkHillMainCameraProc)
  /* 170DAC 8013224C 24A5212C */     addiu $a1, $a1, %lo(mvOpeningLinkHillMainCameraProc)
  /* 170DB0 80132250 AFA5004C */        sw $a1, 0x4c($sp)
  /* 170DB4 80132254 02202025 */        or $a0, $s1, $zero
  /* 170DB8 80132258 24060001 */     addiu $a2, $zero, 1
  /* 170DBC 8013225C 0C002062 */       jal omAddGObjCommonProc
  /* 170DC0 80132260 24070001 */     addiu $a3, $zero, 1
  /* 170DC4 80132264 8FAB0054 */        lw $t3, 0x54($sp)
  /* 170DC8 80132268 240C0046 */     addiu $t4, $zero, 0x46
  /* 170DCC 8013226C 240E0000 */     addiu $t6, $zero, 0
  /* 170DD0 80132270 3C0F1000 */       lui $t7, 0x1000
  /* 170DD4 80132274 240DFFFF */     addiu $t5, $zero, -1
  /* 170DD8 80132278 24180001 */     addiu $t8, $zero, 1
  /* 170DDC 8013227C 24190001 */     addiu $t9, $zero, 1
  /* 170DE0 80132280 AFB90030 */        sw $t9, 0x30($sp)
  /* 170DE4 80132284 AFB80028 */        sw $t8, 0x28($sp)
  /* 170DE8 80132288 AFAD0020 */        sw $t5, 0x20($sp)
  /* 170DEC 8013228C AFAF001C */        sw $t7, 0x1c($sp)
  /* 170DF0 80132290 AFAE0018 */        sw $t6, 0x18($sp)
  /* 170DF4 80132294 AFAC0014 */        sw $t4, 0x14($sp)
  /* 170DF8 80132298 24040401 */     addiu $a0, $zero, 0x401
  /* 170DFC 8013229C 00002825 */        or $a1, $zero, $zero
  /* 170E00 801322A0 24060010 */     addiu $a2, $zero, 0x10
  /* 170E04 801322A4 3C078000 */       lui $a3, 0x8000
  /* 170E08 801322A8 AFA00024 */        sw $zero, 0x24($sp)
  /* 170E0C 801322AC AFA0002C */        sw $zero, 0x2c($sp)
  /* 170E10 801322B0 AFA00034 */        sw $zero, 0x34($sp)
  /* 170E14 801322B4 0C002E4F */       jal func_8000B93C
  /* 170E18 801322B8 AFAB0010 */        sw $t3, 0x10($sp)
  /* 170E1C 801322BC 00408825 */        or $s1, $v0, $zero
  /* 170E20 801322C0 8C440074 */        lw $a0, 0x74($v0)
  /* 170E24 801322C4 24050004 */     addiu $a1, $zero, 4
  /* 170E28 801322C8 0C00233C */       jal omAddOMMtxForCamera
  /* 170E2C 801322CC 00003025 */        or $a2, $zero, $zero
  /* 170E30 801322D0 8E240074 */        lw $a0, 0x74($s1)
  /* 170E34 801322D4 24050006 */     addiu $a1, $zero, 6
  /* 170E38 801322D8 0C00233C */       jal omAddOMMtxForCamera
  /* 170E3C 801322DC 00003025 */        or $a2, $zero, $zero
  /* 170E40 801322E0 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 170E44 801322E4 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 170E48 801322E8 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 170E4C 801322EC 8E300074 */        lw $s0, 0x74($s1)
  /* 170E50 801322F0 44815000 */      mtc1 $at, $f10 # 230.0 to cop1
  /* 170E54 801322F4 44050000 */      mfc1 $a1, $f0
  /* 170E58 801322F8 44060000 */      mfc1 $a2, $f0
  /* 170E5C 801322FC 3C07439B */       lui $a3, 0x439b
  /* 170E60 80132300 26040008 */     addiu $a0, $s0, 8
  /* 170E64 80132304 0C001C20 */       jal func_80007080
  /* 170E68 80132308 E7AA0010 */      swc1 $f10, 0x10($sp)
  /* 170E6C 8013230C 3C014300 */       lui $at, (0x43000000 >> 16) # 128.0
  /* 170E70 80132310 44818000 */      mtc1 $at, $f16 # 128.0 to cop1
  /* 170E74 80132314 3C014680 */       lui $at, (0x46800000 >> 16) # 16384.0
  /* 170E78 80132318 44819000 */      mtc1 $at, $f18 # 16384.0 to cop1
  /* 170E7C 8013231C E6100028 */      swc1 $f16, 0x28($s0)
  /* 170E80 80132320 3C088013 */       lui $t0, %hi(D_ovl46_80132998)
  /* 170E84 80132324 E612002C */      swc1 $f18, 0x2c($s0)
  /* 170E88 80132328 8FA90050 */        lw $t1, 0x50($sp)
  /* 170E8C 8013232C 8D082998 */        lw $t0, %lo(D_ovl46_80132998)($t0)
  /* 170E90 80132330 02002025 */        or $a0, $s0, $zero
  /* 170E94 80132334 24060000 */     addiu $a2, $zero, 0
  /* 170E98 80132338 0C003E8F */       jal func_8000FA3C
  /* 170E9C 8013233C 01092821 */      addu $a1, $t0, $t1
  /* 170EA0 80132340 02202025 */        or $a0, $s1, $zero
  /* 170EA4 80132344 8FA5004C */        lw $a1, 0x4c($sp)
  /* 170EA8 80132348 24060001 */     addiu $a2, $zero, 1
  /* 170EAC 8013234C 0C002062 */       jal omAddGObjCommonProc
  /* 170EB0 80132350 24070001 */     addiu $a3, $zero, 1
  /* 170EB4 80132354 8FBF0044 */        lw $ra, 0x44($sp)
  /* 170EB8 80132358 8FB0003C */        lw $s0, 0x3c($sp)
  /* 170EBC 8013235C 8FB10040 */        lw $s1, 0x40($sp)
  /* 170EC0 80132360 03E00008 */        jr $ra
  /* 170EC4 80132364 27BD0060 */     addiu $sp, $sp, 0x60

glabel mvOpeningLinkHillCreateBackgroundViewport
  /* 170EC8 80132368 27BDFFC0 */     addiu $sp, $sp, -0x40
  /* 170ECC 8013236C 3C0E800D */       lui $t6, %hi(func_ovl0_800CD2CC)
  /* 170ED0 80132370 AFBF003C */        sw $ra, 0x3c($sp)
  /* 170ED4 80132374 25CED2CC */     addiu $t6, $t6, %lo(func_ovl0_800CD2CC)
  /* 170ED8 80132378 240F005A */     addiu $t7, $zero, 0x5a
  /* 170EDC 8013237C 24180000 */     addiu $t8, $zero, 0
  /* 170EE0 80132380 3C190800 */       lui $t9, 0x800
  /* 170EE4 80132384 2408FFFF */     addiu $t0, $zero, -1
  /* 170EE8 80132388 24090001 */     addiu $t1, $zero, 1
  /* 170EEC 8013238C 240A0001 */     addiu $t2, $zero, 1
  /* 170EF0 80132390 AFAA0030 */        sw $t2, 0x30($sp)
  /* 170EF4 80132394 AFA90028 */        sw $t1, 0x28($sp)
  /* 170EF8 80132398 AFA80020 */        sw $t0, 0x20($sp)
  /* 170EFC 8013239C AFB9001C */        sw $t9, 0x1c($sp)
  /* 170F00 801323A0 AFB80018 */        sw $t8, 0x18($sp)
  /* 170F04 801323A4 AFAF0014 */        sw $t7, 0x14($sp)
  /* 170F08 801323A8 AFAE0010 */        sw $t6, 0x10($sp)
  /* 170F0C 801323AC AFA00024 */        sw $zero, 0x24($sp)
  /* 170F10 801323B0 AFA0002C */        sw $zero, 0x2c($sp)
  /* 170F14 801323B4 AFA00034 */        sw $zero, 0x34($sp)
  /* 170F18 801323B8 24040401 */     addiu $a0, $zero, 0x401
  /* 170F1C 801323BC 00002825 */        or $a1, $zero, $zero
  /* 170F20 801323C0 24060010 */     addiu $a2, $zero, 0x10
  /* 170F24 801323C4 0C002E4F */       jal func_8000B93C
  /* 170F28 801323C8 3C078000 */       lui $a3, 0x8000
  /* 170F2C 801323CC 3C014120 */       lui $at, (0x41200000 >> 16) # 10.0
  /* 170F30 801323D0 44810000 */      mtc1 $at, $f0 # 10.0 to cop1
  /* 170F34 801323D4 3C014366 */       lui $at, (0x43660000 >> 16) # 230.0
  /* 170F38 801323D8 8C430074 */        lw $v1, 0x74($v0)
  /* 170F3C 801323DC 44812000 */      mtc1 $at, $f4 # 230.0 to cop1
  /* 170F40 801323E0 44050000 */      mfc1 $a1, $f0
  /* 170F44 801323E4 44060000 */      mfc1 $a2, $f0
  /* 170F48 801323E8 3C07439B */       lui $a3, 0x439b
  /* 170F4C 801323EC 24640008 */     addiu $a0, $v1, 8
  /* 170F50 801323F0 0C001C20 */       jal func_80007080
  /* 170F54 801323F4 E7A40010 */      swc1 $f4, 0x10($sp)
  /* 170F58 801323F8 8FBF003C */        lw $ra, 0x3c($sp)
  /* 170F5C 801323FC 27BD0040 */     addiu $sp, $sp, 0x40
  /* 170F60 80132400 03E00008 */        jr $ra
  /* 170F64 80132404 00000000 */       nop

glabel mvOpeningLinkHillInitFramesElapsed
  /* 170F68 80132408 3C018013 */       lui $at, %hi(gMvOpeningLinkHillFramesElapsed)
  /* 170F6C 8013240C 03E00008 */        jr $ra
  /* 170F70 80132410 AC2027CC */        sw $zero, %lo(gMvOpeningLinkHillFramesElapsed)($at)

glabel mvOpeningLinkHillMainProc
  /* 170F74 80132414 3C038013 */       lui $v1, %hi(gMvOpeningLinkHillFramesElapsed)
  /* 170F78 80132418 246327CC */     addiu $v1, $v1, %lo(gMvOpeningLinkHillFramesElapsed)
  /* 170F7C 8013241C 8C6E0000 */        lw $t6, ($v1) # gMvOpeningLinkHillFramesElapsed + 0
  /* 170F80 80132420 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 170F84 80132424 AFBF0014 */        sw $ra, 0x14($sp)
  /* 170F88 80132428 25CF0001 */     addiu $t7, $t6, 1
  /* 170F8C 8013242C 29E1000A */      slti $at, $t7, 0xa
  /* 170F90 80132430 AFA40018 */        sw $a0, 0x18($sp)
  /* 170F94 80132434 14200026 */      bnez $at, .L801324D0
  /* 170F98 80132438 AC6F0000 */        sw $t7, ($v1) # gMvOpeningLinkHillFramesElapsed + 0
  /* 170F9C 8013243C 3C068013 */       lui $a2, %hi(gMvOpeningLinkHillUnusedCounter)
  /* 170FA0 80132440 24C627DC */     addiu $a2, $a2, %lo(gMvOpeningLinkHillUnusedCounter)
  /* 170FA4 80132444 8CC20000 */        lw $v0, ($a2) # gMvOpeningLinkHillUnusedCounter + 0
  /* 170FA8 80132448 2404FFF1 */     addiu $a0, $zero, -0xf
  /* 170FAC 8013244C 10400002 */      beqz $v0, .L80132458
  /* 170FB0 80132450 2459FFFF */     addiu $t9, $v0, -1
  /* 170FB4 80132454 ACD90000 */        sw $t9, ($a2) # gMvOpeningLinkHillUnusedCounter + 0
  .L80132458:
  /* 170FB8 80132458 0C0E4281 */       jal func_ovl1_80390A04
  /* 170FBC 8013245C 2405000F */     addiu $a1, $zero, 0xf
  /* 170FC0 80132460 10400006 */      beqz $v0, .L8013247C
  /* 170FC4 80132464 2404FFF1 */     addiu $a0, $zero, -0xf
  /* 170FC8 80132468 0C0E42B0 */       jal func_ovl1_80390AC0
  /* 170FCC 8013246C 2405000F */     addiu $a1, $zero, 0xf
  /* 170FD0 80132470 10400002 */      beqz $v0, .L8013247C
  /* 170FD4 80132474 3C018013 */       lui $at, %hi(gMvOpeningLinkHillUnusedCounter)
  /* 170FD8 80132478 AC2027DC */        sw $zero, %lo(gMvOpeningLinkHillUnusedCounter)($at)
  .L8013247C:
  /* 170FDC 8013247C 0C0E41DB */       jal func_ovl1_8039076C
  /* 170FE0 80132480 3404D000 */       ori $a0, $zero, 0xd000
  /* 170FE4 80132484 10400007 */      beqz $v0, .L801324A4
  /* 170FE8 80132488 24090001 */     addiu $t1, $zero, 1
  /* 170FEC 8013248C 3C02800A */       lui $v0, %hi(gSceneData)
  /* 170FF0 80132490 24424AD0 */     addiu $v0, $v0, %lo(gSceneData)
  /* 170FF4 80132494 90480000 */       lbu $t0, ($v0) # gSceneData + 0
  /* 170FF8 80132498 A0490000 */        sb $t1, ($v0) # gSceneData + 0
  /* 170FFC 8013249C 0C00171D */       jal func_80005C74
  /* 171000 801324A0 A0480001 */        sb $t0, 1($v0) # gSceneData + 1
  .L801324A4:
  /* 171004 801324A4 3C0A8013 */       lui $t2, %hi(gMvOpeningLinkHillFramesElapsed)
  /* 171008 801324A8 8D4A27CC */        lw $t2, %lo(gMvOpeningLinkHillFramesElapsed)($t2)
  /* 17100C 801324AC 3C02800A */       lui $v0, %hi(gSceneData)
  /* 171010 801324B0 240100A0 */     addiu $at, $zero, 0xa0
  /* 171014 801324B4 15410006 */       bne $t2, $at, .L801324D0
  /* 171018 801324B8 24424AD0 */     addiu $v0, $v0, %lo(gSceneData)
  /* 17101C 801324BC 904B0000 */       lbu $t3, ($v0) # gSceneData + 0
  /* 171020 801324C0 240C002A */     addiu $t4, $zero, 0x2a
  /* 171024 801324C4 A04C0000 */        sb $t4, ($v0) # gSceneData + 0
  /* 171028 801324C8 0C00171D */       jal func_80005C74
  /* 17102C 801324CC A04B0001 */        sb $t3, 1($v0) # gSceneData + 1
  .L801324D0:
  /* 171030 801324D0 8FBF0014 */        lw $ra, 0x14($sp)
  /* 171034 801324D4 27BD0018 */     addiu $sp, $sp, 0x18
  /* 171038 801324D8 03E00008 */        jr $ra
  /* 17103C 801324DC 00000000 */       nop

glabel mvOpeningLinkHillInit
  /* 171040 801324E0 27BDFFB0 */     addiu $sp, $sp, -0x50
  /* 171044 801324E4 3C0E001B */       lui $t6, %hi(D_NF_001AC870)
  /* 171048 801324E8 3C0F0000 */       lui $t7, %hi(D_NF_00000854)
  /* 17104C 801324EC 3C188013 */       lui $t8, %hi(D_ovl46_801327E0)
  /* 171050 801324F0 3C088013 */       lui $t0, %hi(D_ovl46_80132960)
  /* 171054 801324F4 AFBF001C */        sw $ra, 0x1c($sp)
  /* 171058 801324F8 25CEC870 */     addiu $t6, $t6, %lo(D_NF_001AC870)
  /* 17105C 801324FC 25EF0854 */     addiu $t7, $t7, %lo(D_NF_00000854)
  /* 171060 80132500 271827E0 */     addiu $t8, $t8, %lo(D_ovl46_801327E0)
  /* 171064 80132504 24190030 */     addiu $t9, $zero, 0x30
  /* 171068 80132508 25082960 */     addiu $t0, $t0, %lo(D_ovl46_80132960)
  /* 17106C 8013250C 24090007 */     addiu $t1, $zero, 7
  /* 171070 80132510 AFAE002C */        sw $t6, 0x2c($sp)
  /* 171074 80132514 AFAF0030 */        sw $t7, 0x30($sp)
  /* 171078 80132518 AFA00034 */        sw $zero, 0x34($sp)
  /* 17107C 8013251C AFA00038 */        sw $zero, 0x38($sp)
  /* 171080 80132520 AFB8003C */        sw $t8, 0x3c($sp)
  /* 171084 80132524 AFB90040 */        sw $t9, 0x40($sp)
  /* 171088 80132528 AFA80044 */        sw $t0, 0x44($sp)
  /* 17108C 8013252C AFA90048 */        sw $t1, 0x48($sp)
  /* 171090 80132530 0C0337DE */       jal rdManagerInitSetup
  /* 171094 80132534 27A4002C */     addiu $a0, $sp, 0x2c
  /* 171098 80132538 3C048013 */       lui $a0, %hi(D_ovl46_801326D0)
  /* 17109C 8013253C 248426D0 */     addiu $a0, $a0, %lo(D_ovl46_801326D0)
  /* 1710A0 80132540 0C0337BB */       jal rdManagerGetAllocSize
  /* 1710A4 80132544 24050002 */     addiu $a1, $zero, 2
  /* 1710A8 80132548 00402025 */        or $a0, $v0, $zero
  /* 1710AC 8013254C 0C001260 */       jal gsMemoryAlloc
  /* 1710B0 80132550 24050010 */     addiu $a1, $zero, 0x10
  /* 1710B4 80132554 3C048013 */       lui $a0, %hi(D_ovl46_801326D0)
  /* 1710B8 80132558 3C068013 */       lui $a2, %hi(D_ovl46_80132998)
  /* 1710BC 8013255C 24C62998 */     addiu $a2, $a2, %lo(D_ovl46_80132998)
  /* 1710C0 80132560 248426D0 */     addiu $a0, $a0, %lo(D_ovl46_801326D0)
  /* 1710C4 80132564 24050002 */     addiu $a1, $zero, 2
  /* 1710C8 80132568 0C033781 */       jal rdManagerLoadFiles
  /* 1710CC 8013256C 00403825 */        or $a3, $v0, $zero
  /* 1710D0 80132570 3C058013 */       lui $a1, %hi(mvOpeningLinkHillMainProc)
  /* 1710D4 80132574 24A52414 */     addiu $a1, $a1, %lo(mvOpeningLinkHillMainProc)
  /* 1710D8 80132578 00002025 */        or $a0, $zero, $zero
  /* 1710DC 8013257C 00003025 */        or $a2, $zero, $zero
  /* 1710E0 80132580 0C00265A */       jal omMakeGObjCommon
  /* 1710E4 80132584 3C078000 */       lui $a3, 0x8000
  /* 1710E8 80132588 00002025 */        or $a0, $zero, $zero
  /* 1710EC 8013258C 3C058000 */       lui $a1, 0x8000
  /* 1710F0 80132590 24060064 */     addiu $a2, $zero, 0x64
  /* 1710F4 80132594 24070001 */     addiu $a3, $zero, 1
  /* 1710F8 80132598 0C002E7F */       jal func_8000B9FC
  /* 1710FC 8013259C AFA00010 */        sw $zero, 0x10($sp)
  /* 171100 801325A0 0C045624 */       jal func_ovl2_80115890
  /* 171104 801325A4 00000000 */       nop
  /* 171108 801325A8 0C04C902 */       jal mvOpeningLinkHillInitFramesElapsed
  /* 17110C 801325AC 00000000 */       nop
  /* 171110 801325B0 0C03F4C0 */       jal efManager_AllocUserData
  /* 171114 801325B4 00000000 */       nop
  /* 171118 801325B8 24040001 */     addiu $a0, $zero, 1
  /* 17111C 801325BC 0C035C65 */       jal ftManager_AllocFighterData
  /* 171120 801325C0 24050001 */     addiu $a1, $zero, 1
  /* 171124 801325C4 0C035E1B */       jal ftManager_SetFileDataKind
  /* 171128 801325C8 24040005 */     addiu $a0, $zero, 5
  /* 17112C 801325CC 3C048013 */       lui $a0, %hi(gFTAnimHeapSize)
  /* 171130 801325D0 8C840D9C */        lw $a0, %lo(gFTAnimHeapSize)($a0)
  /* 171134 801325D4 0C001260 */       jal gsMemoryAlloc
  /* 171138 801325D8 24050010 */     addiu $a1, $zero, 0x10
  /* 17113C 801325DC 3C018013 */       lui $at, %hi(gMvOpeningLinkHillFighterAnimHeap)
  /* 171140 801325E0 0C04C853 */       jal mvOpeningLinkHillCreateMainViewport
  /* 171144 801325E4 AC2227C8 */        sw $v0, %lo(gMvOpeningLinkHillFighterAnimHeap)($at)
  /* 171148 801325E8 0C04C8DA */       jal mvOpeningLinkHillCreateBackgroundViewport
  /* 17114C 801325EC 00000000 */       nop
  /* 171150 801325F0 0C04C7CB */       jal mvOpeningLinkHillCreateBackground
  /* 171154 801325F4 00000000 */       nop
  /* 171158 801325F8 0C04C70D */       jal mvOpeningLinkHillCreateHills
  /* 17115C 801325FC 00000000 */       nop
  /* 171160 80132600 0C04C72B */       jal mvOpeningLinkHillCreateFighter
  /* 171164 80132604 00000000 */       nop
  /* 171168 80132608 0C04C809 */       jal mvOpeningLinkHillCreateOcarina
  /* 17116C 8013260C 00000000 */       nop
  /* 171170 80132610 3C01C234 */       lui $at, (0xC2340000 >> 16) # -45.0
  /* 171174 80132614 44816000 */      mtc1 $at, $f12 # -45.0 to cop1
  /* 171178 80132618 3C0141C8 */       lui $at, (0x41C80000 >> 16) # 25.0
  /* 17117C 8013261C 44817000 */      mtc1 $at, $f14 # 25.0 to cop1
  /* 171180 80132620 240A00FF */     addiu $t2, $zero, 0xff
  /* 171184 80132624 240B00FF */     addiu $t3, $zero, 0xff
  /* 171188 80132628 AFAB0014 */        sw $t3, 0x14($sp)
  /* 17118C 8013262C AFAA0010 */        sw $t2, 0x10($sp)
  /* 171190 80132630 240600FF */     addiu $a2, $zero, 0xff
  /* 171194 80132634 0C0E4138 */       jal func_ovl1_803904E0
  /* 171198 80132638 240700FF */     addiu $a3, $zero, 0xff
  /* 17119C 8013263C 0C00024B */       jal func_8000092C
  /* 1711A0 80132640 00000000 */       nop
  /* 1711A4 80132644 2C4109C4 */     sltiu $at, $v0, 0x9c4
  /* 1711A8 80132648 50200007 */      beql $at, $zero, .L80132668
  /* 1711AC 8013264C 8FBF001C */        lw $ra, 0x1c($sp)
  .L80132650:
  /* 1711B0 80132650 0C00024B */       jal func_8000092C
  /* 1711B4 80132654 00000000 */       nop
  /* 1711B8 80132658 2C4109C4 */     sltiu $at, $v0, 0x9c4
  /* 1711BC 8013265C 1420FFFC */      bnez $at, .L80132650
  /* 1711C0 80132660 00000000 */       nop
  /* 1711C4 80132664 8FBF001C */        lw $ra, 0x1c($sp)
  .L80132668:
  /* 1711C8 80132668 27BD0050 */     addiu $sp, $sp, 0x50
  /* 1711CC 8013266C 03E00008 */        jr $ra
  /* 1711D0 80132670 00000000 */       nop

glabel intro_link_hill_entry
  /* 1711D4 80132674 3C0E800A */       lui $t6, %hi(D_NF_800A5240)
  /* 1711D8 80132678 27BDFFE8 */     addiu $sp, $sp, -0x18
  /* 1711DC 8013267C 3C048013 */       lui $a0, %hi(D_ovl46_80132708)
  /* 1711E0 80132680 25CE5240 */     addiu $t6, $t6, %lo(D_NF_800A5240)
  /* 1711E4 80132684 24842708 */     addiu $a0, $a0, %lo(D_ovl46_80132708)
  /* 1711E8 80132688 AFBF0014 */        sw $ra, 0x14($sp)
  /* 1711EC 8013268C 25CFE700 */     addiu $t7, $t6, -0x1900
  /* 1711F0 80132690 0C001C09 */       jal func_80007024
  /* 1711F4 80132694 AC8F000C */        sw $t7, 0xc($a0) # D_ovl46_80132708 + 12
  /* 1711F8 80132698 3C188039 */       lui $t8, %hi(func_ovl1_803903E0)
  /* 1711FC 8013269C 3C198013 */       lui $t9, %hi(D_NF_801329A0)
  /* 171200 801326A0 3C048013 */       lui $a0, %hi(D_ovl46_80132724)
  /* 171204 801326A4 273929A0 */     addiu $t9, $t9, %lo(D_NF_801329A0)
  /* 171208 801326A8 271803E0 */     addiu $t8, $t8, %lo(func_ovl1_803903E0)
  /* 17120C 801326AC 24842724 */     addiu $a0, $a0, %lo(D_ovl46_80132724)
  /* 171210 801326B0 03194023 */      subu $t0, $t8, $t9
  /* 171214 801326B4 0C001A0F */       jal gsGTLSceneInit
  /* 171218 801326B8 AC880010 */        sw $t0, 0x10($a0) # D_ovl46_80132724 + 16
  /* 17121C 801326BC 8FBF0014 */        lw $ra, 0x14($sp)
  /* 171220 801326C0 27BD0018 */     addiu $sp, $sp, 0x18
  /* 171224 801326C4 03E00008 */        jr $ra
  /* 171228 801326C8 00000000 */       nop

  /* 17122C 801326CC 00000000 */       nop
