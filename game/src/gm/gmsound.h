#ifndef _GMSOUND_H_
#define _GMSOUND_H_

#include <ssb_types.h>
#include <PR/ultratypes.h>
#include <sys/obj.h>

typedef struct alSoundEffect
{
    void *unk_0x0;
    void *unk_0x4;
    void *unk_0x8;
    void *unk_0xC;
    u16 unk_0x10;
    u16 unk_0x12;
    u16 unk_0x14;
    u16 unk_0x16;
    u16 unk_0x18;
    u16 unk_0x1A;
    u16 unk_0x1C;
    u16 unk_0x1E;
    u16 unk_0x20;
    u16 unk_0x22;
    u16 unk_0x24;
    u16 sfx_id;
    u16 sfx_max;    // End of SFX index list

} alSoundEffect;

typedef enum alMusicID
{
    alSound_Music_Hammer = 0x2D,            // 0x2D
    alSound_Music_Starman                   // 0x2E

} alMusicID;

typedef enum alSoundEffectID
{
    alSound_SFX_ExplodeS,
    alSound_SFX_ExplodeL,
    alSound_SFX_FireShoot1,
    alSound_SFX_UnkShoot1,
    alSound_SFX_UnkDial1,
    alSound_SFX_ChargeShotAll,
    alSound_SFX_UnkSmallPing1,
    alSound_SFX_Blaster,
    alSound_SFX_SamusJump1,
    alSound_SFX_DonkeySlap1,
    alSound_SFX_DonkeySlap2,
    alSound_SFX_Escape,         // Roll
    alSound_SFX_DeadUpStar,     // Star KO spark
    alSound_SFX_GuardOn,        // Put up shield
    alSound_SFX_GuardOff,
    alSound_SFX_ShieldBreak,
    alSound_SFX_ShieldBreakPitchLw,
    alSound_SFX_HeavySwing1,
    alSound_SFX_LightSwingLw1,
    alSound_SFX_Catch,          // Grab
    alSound_SFX_DoorClose,
    alSound_SFX_TModeSel,
    alSound_SFX_ShockL,
    alSound_SFX_ShockM,
    alSound_SFX_ShockS,
    alSound_SFX_BurnL,
    alSound_SFX_BurnE,          // Burn empty (empty Fire Flower)
    alSound_SFX_BurnM,
    alSound_SFX_BurnS,
    alSound_SFX_ShockML,
    alSound_SFX_Firefox,
    alSound_SFX_KickL,
    alSound_SFX_KickM,
    alSound_SFX_DeadFall,       // Plays when dying in a blast zone?
    alSound_SFX_KickS,
    alSound_SFX_UnkTap1,
    alSound_SFX_FireShoot2,
    alSound_SFX_PunchL,
    alSound_SFX_PunchM,
    alSound_SFX_UnkSlam1,
    alSound_SFX_PunchS,
    alSound_SFX_LightSwingL,
    alSound_SFX_LightSwingM,
    alSound_SFX_LightSwingS,
    alSound_SFX_MSBombAttach,
    alSound_SFX_BombHeiFuse,
    alSound_SFX_ItemMapCollide,   // Item falls on ground
    alSound_SFX_BumperHit,
    alSound_SFX_FireFlowerBurn,
    alSound_SFX_ItemPickup,
    alSound_SFX_HammerSwing,
    alSound_SFX_HarisenHit,
    alSound_SFX_BatHit,
    alSound_SFX_StarMapCollide,
    alSound_SFX_StarCollect,
    alSound_SFX_BombHeiWalkStart,
    alSound_SFX_ShellHit,
    alSound_SFX_ItemThrow,
    alSound_SFX_ItemSpawn1,
    alSound_SFX_ContainerSmash,
    alSound_SFX_FireFlowerShoot,
    alSound_SFX_LGunShoot,
    alSound_SFX_LGunEmpty,
    alSound_SFX_StarRodSwing4,
    alSound_SFX_StarRodSwing3,
    alSound_SFX_StarRodSwing1,
    alSound_SFX_StarRodEmpty,
    alSound_SFX_SwordSwing4,
    alSound_SFX_SwordSwing3,
    alSound_SFX_SwordSwing1,
    alSound_SFX_RBombHit,           // Hit entity?
    alSound_SFX_RBombMap,           // Collide with wall?
    alSound_SFX_Footstep1,
    alSound_SFX_Footstep2,
    alSound_SFX_Footstep3,
    alSound_SFX_Footstep4,
    alSound_SFX_Footstep5,
    alSound_SFX_Footstep6,
    alSound_SFX_Footstep7,
    alSound_SFX_Footstep8,
    alSound_SFX_Footstep9,
    alSound_SFX_SamusLandingClick,
    alSound_SFX_Footstep10,
    alSound_SFX_UnkGrind2,
    alSound_SFX_UnkGrind3,
    alSound_SFX_UnkGrind4,
    alSound_SFX_InflateJump1,
    alSound_SFX_UnkGrind5,
    alSound_SFX_SamusJump2,
    alSound_SFX_UnkNessPSI,
    alSound_SFX_InflateJump2,
    alSound_SFX_InflateJump3,
    alSound_SFX_SamusJumpAerial,
    alSound_SFX_InflateJump4,
    alSound_SFX_KirbyPurinJump,
    alSound_SFX_GroundGrind1,
    alSound_SFX_GroundGrind2,
    alSound_SFX_InflateJump5,
    alSound_SFX_GroundGrind3,
    alSound_SFX_InflateJump6,
    alSound_SFX_NessJump,
    alSound_SFX_InflateJump7,
    alSound_SFX_InflateJump8,
    alSound_SFX_GroundGrind4,
    alSound_SFX_InflateJump9,
    alSound_SFX_Footstep11,    // Might be footsteps? They are very quiet
    alSound_SFX_Footstep12,
    alSound_SFX_Footstep13,
    alSound_SFX_Footstep14,
    alSound_SFX_Footstep15,
    alSound_SFX_Footstep16,
    alSound_SFX_Footstep17,
    alSound_SFX_Footstep18,
    alSound_SFX_Footstep19,
    alSound_SFX_Footstep20,
    alSound_SFX_Footstep21,
    alSound_SFX_Footstep22,
    alSound_SFX_MetalMarioFoot = 0x7A,
    alSound_SFX_MetalMarioLanding,  // Unconfirmed
    alSound_SFX_SamusTurnClick = 0x7F,
    alSound_SFX_GroundBrakeGrind,
    alSound_SFX_UnkEchoHit1,
    alSound_SFX_DogasSmog = 0x83,
    alSound_SFX_IwarkRockCreate,
    alSound_SFX_KabigonFall,
    alSound_SFX_KabigonJump, // ???
    alSound_SFX_KamexHydro,
    alSound_SFX_LizardonFlame,
    alSound_SFX_MewFly,
    alSound_SFX_NyarsCoin,
    alSound_SFX_MBallOpen,
    alSound_SFX_MonsterShoot,      // Venusaur and Starmie firing sound effect
    alSound_SFX_TosakintoSplash,
    alSound_SFX_JKickL,
    alSound_SFX_JKickM,
    alSound_SFX_JKickS,
    alSound_SFX_JPunchL,
    alSound_SFX_JPunchM,
    alSound_SFX_JPunchS,
    alSound_SFX_WindAmbient1,
    alSound_SFX_UnkWhirr3,
    alSound_SFX_PublicCheer1,
    alSound_SFX_UnkBatS,
    alSound_SFX_UnkBatM,
    alSound_SFX_DeadPortalLw,       // Bottom blastzone warning sound?
    alSound_SFX_DeadPortalHitL,     // One of many sounds that play when hitting the blastzone
    alSound_SFX_DeadPortalHitS,
    alSound_SFX_UnkMechanical1,     // Menu sound?
    alSound_SFX_TitlePressStart, 
    alSound_SFX_MenuSelect,
    alSound_SFX_MapSelect,
    alSound_SFX_1PGameContinue,
    alSound_SFX_1PGameContinueMulti,
    alSound_SFX_TModeSel2,
    alSound_SFX_MenuScroll1,        // Scroll vertically?
    alSound_SFX_MenuScroll2,        // Scroll horizontally / vertically in Training Mode
    alSound_SFX_MenuDenied,
    alSound_SFX_PlayerGateClose,    // Plays when player's character portrait is closed on the CSS?
    alSound_SFX_PlayerGateWhoosh,   // Might be unrelated
    alSound_SFX_UnkMetallic2,
    alSound_SFX_StageClearScoreRegister,
    alSound_SFX_StageClearScoreDisplay,
    alSound_SFX_UnkSwoosh1,
    alSound_SFX_BossDefeatL,
    alSound_SFX_UnkGate1,
    alSound_SFX_MasterHandYubi,
    alSound_SFX_MasterHandSlam,
    alSound_SFX_MasterHandUnk1,
    alSound_SFX_MasterHandUnk2,
    alSound_SFX_DonkeySpin,         // Spinning kong swing sound effect
    alSound_SFX_DonkeyCharge,       // These two might be swapped
    alSound_SFX_CaptainAppearCar1,
    alSound_SFX_CaptainAppearCar2,
    alSound_SFX_CaptainSpecialHi,
    alSound_SFX_CaptainSpecialNStart,
    alSound_SFX_CaptainSpecialNPunch,
    alSound_SFX_FoxSpecialN,        // Blaster again???
    alSound_SFX_FoxSpecialHiStart,
    alSound_SFX_FoxSpecialHiFly,
    alSound_SFX_FoxSpecialLwHit,
    alSound_SFX_FoxSpecialLwStart,
    alSound_SFX_FoxAttackAirLw,
    alSound_SFX_FoxAppearArwing,
    alSound_SFX_UnkMechanical4,
    alSound_SFX_UnkLongWind,
    alSound_SFX_KirbySpecialLwLanding,
    alSound_SFX_KirbyAttackAirHi,
    alSound_SFX_KirbySpecialNThrow,
    alSound_SFX_KirbySpecialNCopyEat,
    alSound_SFX_KirbySpecialNCopyThrow,
    alSound_SFX_KirbySpecialNCopyUnk,
    alSound_SFX_KirbyStarPing1,
    alSound_SFX_KirbyStarPing2,
    alSound_SFX_KirbySpecialLwStart,
    alSound_SFX_KirbySpecialNStart,
    alSound_SFX_KirbySpecialNLoseCopy,
    alSound_SFX_LinkSpecialLwGet,
    alSound_SFX_LinkSpecialNThrow,
    alSound_SFX_LinkSpecialNDraw,
    alSound_SFX_LinkSpecialNReturn,
    alSound_SFX_LinkSpecialHi,
    alSound_SFX_LinkCatchHookshot,
    alSound_SFX_LinkAppear,
    alSound_SFX_MarioAppealGrow,
    alSound_SFX_MarioAppealShrink,
    alSound_SFX_MarioDokan,
    alSound_SFX_MarioSpecialN,
    alSound_SFX_MarioSpecialHiCoin,
    alSound_SFX_MarioSpecialHiJump,
    alSound_SFX_MarioUnkSwing1,      // Down air or down special?
    alSound_SFX_MarioUnkSwing2,
    alSound_SFX_CharacterUnk1,
    alSound_SFX_NessPKThunderLoop,
    alSound_SFX_NessPSI,
    alSound_SFX_NessPSIAgain,     // Huh
    alSound_SFX_NessSpecialLwStart,
    alSound_SFX_NessSpecialHiCrack1, // Might be Pikachu's Thunder Jolt
    alSound_SFX_NessSpecialHiCrack2,
    alSound_SFX_NessSpecialHiCrack3,
    alSound_SFX_NessSpecialHiCrack4,
    alSound_SFX_NessSpecialHiCrack5,
    alSound_SFX_NessSpecialHiCrackLoop,
    alSound_SFX_PikachuSpecialHiStart,
    alSound_SFX_PikachuSpecialLwThunder,
    alSound_SFX_CharacterUnk2,
    alSound_SFX_CharacterUnk3,
    alSound_SFX_SamusSpecialNShootF,
    alSound_SFX_SamusSpecialNShootL,
    alSound_SFX_SamusSpecialNShootM,
    alSound_SFX_SamusSpecialNShootS,
    alSound_SFX_SamusSpecialNCharge0,
    alSound_SFX_SamusSpecialNCharge1,
    alSound_SFX_SamusSpecialNCharge2,
    alSound_SFX_SamusSpecialNCharge3,
    alSound_SFX_SamusSpecialNCharge4,
    alSound_SFX_SamusSpecialNCharge5,
    alSound_SFX_SamusSpecialNCharge6,
    alSound_SFX_SamusSpecialNCharge7,
    alSound_SFX_SamusSpecialLw,
    alSound_SFX_SamusCatchGrappleBeam,
    alSound_SFX_SamusSpecialHi,
    alSound_SFX_SamusUnkSwing,
    alSound_SFX_SamusUnkCharge,
    alSound_SFX_YoshiEggShatter1,
    alSound_SFX_YoshiEggShatter2,
    alSound_SFX_YoshiSpecialNTongue,
    alSound_SFX_YoshiEggShatter3,
    alSound_SFX_YoshiSpecialHiThrow,
    alSound_SFX_YoshiEggLayShatter,
    alSound_SFX_BladeSwing4,
    alSound_SFX_BladeSwing3,
    alSound_SFX_BladeSwing1,
    alSound_SFX_SlashL,
    alSound_SFX_SlashM,
    alSound_SFX_SlashS,
    alSound_SFX_BladeDraw,
    alSound_SFX_SectorArwingLaser,
    alSound_SFX_SectorAmbient1,
    alSound_SFX_SectorAmbient2,
    alSound_SFX_SectorAmbient3,
    alSound_SFX_OptionsDataErase,
    alSound_SFX_YCityGate,          // Empty?
    alSound_SFX_Magnify,
    alSound_SFX_ShinePingUnk,
    alSound_SFX_MenuExclamationUnk,
    alSound_SFX_PlayerHeal,         // High-pitched short click, sped up Mario Fireball?
    alSound_SFX_YosterCloudVapor,
    alSound_SFX_DeadPortalFallQuick,
    alSound_SFX_Bonus2PlatformLanding,       // Land on Bonus 2 platform
    alSound_SFX_GamePause,
    alSound_SFX_InishiePowerBlock,  // POW Block
    alSound_SFX_Bonus1TargetBreak,           // Break Bonus 1 target
    alSound_SFX_KongoTaruCannShoot,
    alSound_SFX_KongoTaruCannEnter,
    alSound_SFX_HyruleTwisterSpawn,
    alSound_SFX_HyruleTwisterEnter,
    alSound_SFX_PupupuWhispyWind,   // Despawn?
    alSound_SFX_FloorDamageBurn,
    alSound_SFX_FighterBodySlamL,               // This continues until 0x12A
    alSound_SFX_DownBounceDonkey = 0x12A,       // 0x12A; This continues until 0x135
    alSound_SFX_DownBounceCaptain,              // 0x12B
    alSound_SFX_DownBounceFox,                  // 0x12C
    alSound_SFX_DownBounceKirby,                // 0x12D
    alSound_SFX_DownBounceLink,                 // 0x12E
    alSound_SFX_DownBounceMario,                // 0x12F
    alSound_SFX_DownBounceNess,                 // 0x130
    alSound_SFX_DownBouncePikachu,              // 0x131
    alSound_SFX_DownBouncePurin,                // 0x132
    alSound_SFX_DownBounceSamus,                // 0x133
    alSound_SFX_DownBounceYoshi,                // 0x134
    alSound_Voice_MBallDogasSpawn = 0x135,
    alSound_Voice_MBallIwarkSpawn,
    alSound_Voice_MBallKabigonFall,
    alSound_Voice_MBallKabigonSpawn,
    alSound_Voice_MBallKamexSpawn,
    alSound_Voice_MBallLuckySpawn,
    alSound_Voice_MBallMewSpawn,
    alSound_Voice_MBallPippiSpawn,
    alSound_Voice_MBallLizardonSpawn,
    alSound_Voice_MBallSawamuraSpawn,
    alSound_Voice_MBallSawamuraKick,
    alSound_Voice_MBallSpearSpawn,
    alSound_Voice_MBallSpearSwarm,
    alSound_Voice_MBallStarmieSpawn,
    alSound_Voice_MBallTosakintoSpawn,
    alSound_Voice_DonkeyFuraSleep,
    alSound_Voice_DonkeyAppeal,
    alSound_Voice_DonkeySmash1,
    alSound_Voice_DonkeySmash2,
    alSound_Voice_DonkeySmash3,
    alSound_Voice_DonkeySpecialNPunch,
    alSound_Voice_DonkeyDeadUp,
    alSound_Voice_DonkeyFuraFura,
    alSound_Voice_DonkeyDamage,
    alSound_Voice_DonkeyDead1,
    alSound_Voice_DonkeyHeavyGet,
    alSound_Voice_DonkeyHeavyUnk,
    alSound_Voice_DonkeyDead2,
    alSound_Voice_CaptainAppeal,
    alSound_Voice_CaptainYes,
    alSound_Voice_CaptainSmash1,
    alSound_Voice_CaptainSmash2,
    alSound_Voice_CaptainSmash3,
    alSound_Voice_CaptainSmash4,
    alSound_Voice_CaptainFinalComeOn,
    alSound_Voice_CaptainSmash5,    // Same as Smash 3 or 4?
    alSound_Voice_CaptainAttackS4,
    alSound_Voice_CaptainSpecialLw,
    alSound_Voice_CaptainSpecialNPunch,
    alSound_Voice_CaptainSpecialNFalcon,
    alSound_Voice_CaptainDeadUp,
    alSound_Voice_CaptainFuraFura,
    alSound_Voice_CaptainDamage,
    alSound_Voice_CaptainUnkPing1,
    alSound_Voice_CaptainJumpAerial, // ??? Same as Captain Falcon's airdodge in Melee
    alSound_Voice_CaptainHeavyGet,
    alSound_Voice_CaptainDead,
    alSound_Voice_CaptainFuraSleep,
    alSound_Voice_CaptainUnkQuick,
    alSound_Voice_CaptainUnkPing2,
    alSound_Voice_CaptainUnkPing3,
    alSound_Voice_FoxDeadUp,
    alSound_Voice_FoxAppeal,
    alSound_Voice_FoxSpecialHiFire,
    alSound_Voice_FoxJumpAerial,
    alSound_Voice_FoxEscape,
    alSound_Voice_FoxSelected,
    alSound_Voice_FoxFinalIke,
    alSound_Voice_FoxUnkGrunt,
    alSound_Voice_FoxResult,    // Same as Appeal and Selected
    alSound_Voice_FoxGrunt2,
    alSound_Voice_FoxDead,
    alSound_Voice_FoxFuraSleep,
    alSound_Voice_FoxSmash1,
    alSound_Voice_FoxSmash2,
    alSound_Voice_FoxSmash3,
    alSound_Voice_FoxDamage,
    alSound_Voice_FoxFuraFura,
    alSound_Voice_KirbyAppeal,
    alSound_Voice_KirbySmash1,
    alSound_Voice_KirbySmash2,
    alSound_Voice_KirbySmash3,
    alSound_Voice_AnnounceComplete = 0x1CB,
    alSound_Voice_AnnounceNewRecord = 0x1D0,
    alSound_Voice_YamabukiFushigibana = 0x228,
    alSound_Voice_YamabukiHitokage,
    alSound_Voice_YamabukiLucky,
    alSound_Voice_YamabukiMarumine,
    alSound_Voice_YamabukiPorygon

} alSoundEffectID;

#endif