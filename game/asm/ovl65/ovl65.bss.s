.include "macros.inc"

.section .bss

# 0x80192FA0 -> 0x80193900 [0x960 bytes]
glabel s1PGameEnemyPlayerCount
    .space 1
glabel s1PGameEnemyStocksRemaining
    .space 3
glabel s1PGameEnemyStockSpriteFlags
    .space 4
glabel s1PGameTeamPlayersRemaining
    .space 1
glabel s1PGameCurrentEnemyVariation
    .space 7
glabel s1PGameEnemyVariations
    .space 3
glabel D_ovl65_80192FB3
    .space 3
glabel D_ovl65_80192FB6
    .space 6
glabel D_ovl65_80192FBC
    .space 20
glabel s1PGameBossDefeatZoomPosition
    .space 12
glabel s1PGameBossDefeatSoundTerminateTemp
    .space 4
glabel s1PGamePlayerSetups
    .space 24
glabel D_ovl65_80192FF8
    .space 104
glabel s1PGameEnemyKirbyCostume
    .space 4
glabel s1PGameZakoStockSprite
    .space 4
glabel s1PGameStatusBuf
    .space 800
glabel s1PGameForceBuf
    .space 56
glabel s1PGameIsEndStage
    .space 4
glabel s1PGameIsStartStage
    .space 4
glabel g1PGameBonusStatEndPlayerStatus
    .space 4
glabel g1PGameBonusStatInvincibleTimer
    .space 4
glabel g1PGameBonusStatEnemyStats
    .space 24
glabel D_ovl65_801933E8
    .space 24
glabel D_ovl65_80193400
    .space 672
glabel g1PGameBonusStatNumPlayerKOs
    .space 4
glabel g1PGameBonusStatBrosCalamity
    .space 4
glabel g1PGameBonusStatTomatoCount
    .space 1
glabel g1PGameBonusStatHeartCount
    .space 1
glabel g1PGameBonusStatStarCount
    .space 1
glabel g1PGameBonusStatShieldBreaker
    .space 1
glabel g1PGameBonusStatGiantImpact
    .space 1
glabel g1PGameBonusStatMewCatcher
    .space 3
glabel g1PGameBonusStatAttackIDCount
    .space 4
glabel D_ovl65_801936B4
    .space 144
glabel D_ovl65_80193744
    .space 80
glabel D_ovl65_80193794
    .space 4
glabel g1PGameBonusStatAttackIsSmashCount
    .space 8
glabel g1PGameBonusStatAttackGroundAirCount
    .space 8
glabel g1PGameBonusStatAttackIsProjectileCount
    .space 8
glabel g1PGameBonusStatDefendIDCount
    .space 4
glabel D_ovl65_801937B4
    .space 52
glabel D_ovl65_801937E8
    .space 12
glabel D_ovl65_801937F4
    .space 56
glabel D_ovl65_8019382C
    .space 24
glabel D_ovl65_80193844
    .space 76
glabel D_ovl65_80193890
    .space 8
glabel g1PGameBonusStatDefendIsSmashCount
    .space 8
glabel g1PGameBonusStatDefendGroundAirCount
    .space 8
glabel g1PGameBonusStatDefendIsProjectileCount
    .space 8
glabel s1PGameStageTimeSec
    .space 4
glabel s1PGameTotalTimeSec
    .space 4
glabel s1PGamePlayerInterfacePositionsX
    .space 16
glabel s1PGameEnemyStocksDisplay
    .space 4
glabel s1PGameEnemyTeamSprites
    .space 4
glabel s1PGameBossBackgroundGObj
    .space 8
glabel s1PGameBossMain
    .space 16
glabel D_ovl65_801938E8
    .space 4
glabel D_ovl65_801938EC
    .space 4
glabel s1PGameBossBackgroundStepRGBA
    .space 16