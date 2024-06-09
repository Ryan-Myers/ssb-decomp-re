#ifndef _EFMANAGER_H_
#define _EFMANAGER_H_

#include "eftypes.h"

extern void efManager_AllocUserData(void);
extern efStruct* efManager_GetEffectStruct(sb32 is_force_return);
extern efStruct* efManager_GetStructNoForceReturn(void);
extern efStruct* efManager_GetStructForceReturn(void);
extern void efManager_SetPrevAlloc(efStruct *ep);
extern void func_ovl2_800FD524(GObj *effect_gobj);
extern void efManagerDefaultEndEjectProcUpdate(GObj *effect_gobj);
extern void func_ovl2_800FD5D8(GObj *effect_gobj);
extern void efManagerSortZNeg(DObj *dobj);
extern void efManagerSortZPos(DObj *dobj);
extern void efManagerProcRun(GObj *effect_gobj);
extern GObj* efManagerMakeEffect(efCreateDesc *effect_desc, sb32 is_force_return);
extern void efManagerMakeEffectNoForce(efCreateDesc *effect_desc);
extern void efManagerMakeEffectForce(efCreateDesc *effect_desc);
extern efParticle* efManagerDestroyParticleGObj(efParticle *efpart, GObj *effect_gobj);
extern void efTransform_Default_ProcDead(efTransform *eftrans);
extern void efDefaultProcUpdate(GObj *effect_gobj);
extern efParticle* efParticle_DamageNormalLight_MakeEffect(Vec3f *pos, s32 player, s32 size, sb32 is_static);
extern void efTransform_DamageNormalHeavy_ProcDead(efTransform *eftrans);
extern efParticle* func_ovl2_800FE068(Vec3f *pos, s32 size);
extern void efCommonVelAddDestroyAnimEnd(GObj *effect_gobj);
extern efParticle* efParticle_DamageFire_MakeEffect(Vec3f *pos, s32 size);
extern efParticle* func_ovl2_800FE4EC(Vec3f *pos, s32 size);
extern GObj* efParticle_DamageSlash_MakeEffect(Vec3f *pos, s32 size, f32 rotate);
extern efParticle* efParticle_FlameLR_MakeEffect(Vec3f *pos, s32 lr);
extern efParticle* efParticle_FlameRandom_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_FlameStatic_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_DustCollision_MakeEffect(Vec3f *pos);
extern GObj* efParticle_ShockSmall_MakeEffect(Vec3f *pos);
extern void efParticle_DustLight_ProcUpdate(GObj *effect_gobj);
extern efParticle* efParticle_DustLight_MakeEffect(Vec3f *pos, sb32 is_invert_vel, f32 f_index);
extern efParticle* efParticle_DustHeavy_MakeEffect(Vec3f *pos, s32 lr);
extern void efParticle_DustHeavyDouble_ProcUpdate(GObj *effect_gobj);
extern efParticle* efParticle_DustHeavyDouble_MakeEffect(Vec3f *pos, s32 lr, f32 f_index);
extern efParticle* efParticle_DustExpandLarge_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_DustExpandSmall_MakeEffect(Vec3f *pos, f32 f_index);
extern efParticle* efParticle_DustDash_MakeEffect(Vec3f *pos, s32 lr, f32 scale);
extern void efParticle_DamageFlyOrbs_ProcUpdate(GObj *effect_gobj);
extern void efParticle_DamageSpawnOrbs_ProcUpdate(GObj *this_gobj);
extern GObj* efParticle_DamageSpawnOrbs_MakeEffect(Vec3f *pos);
extern GObj* efParticle_DamageSpawnOrbs_CheckRandomMakeEffect(Vec3f *pos);
extern void efParticle_ImpactWave_ProcRender(GObj *effect_gobj);
extern void efParticle_ImpactWave_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_ImpactWave_MakeEffect(Vec3f *pos, s32 index, f32 rotate);
extern GObj* efParticle_ImpactAirWave_MakeEffect(Vec3f *pos, s32 index);
extern void efParticle_StarRodSpark_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_StarRodSpark_MakeEffect(Vec3f *pos, s32 lr);
extern void efParticle_DamageFlySparks_ProcUpdate(GObj *effect_gobj);
extern void efParticle_DamageSpawnSparks_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_DamageSpawnSparks_MakeEffect(Vec3f *pos, s32 lr);
extern GObj* efParticle_DamageSpawnSparks_CheckRandomMakeEffect(Vec3f *pos, s32 lr);
extern void efParticle_DamageSpawnMDust_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_DamageSpawnMDust_MakeEffect(Vec3f *pos, s32 lr);
extern GObj* efParticle_DamageSpawnMDust_CheckRandomMakeEffect(Vec3f *pos, s32 lr);
extern efParticle* efParticle_SparkleWhite_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_SparkleWhiteMulti_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_SparkleWhiteMultiExplode_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_SparkleWhiteScale_MakeEffect(Vec3f *pos, f32 scale);
extern efParticle* efParticle_SparkleWhiteDead_MakeEffect(Vec3f *pos, f32 scale);
extern void efParticle_Quake_ProcUpdate(GObj *effect_gobj);
extern void efParticle_Quake_AddProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_Quake_MakeEffect(s32 magnitude);
extern void efTransform_DamageCoin_ProcDead(efTransform *eftrans);
extern efParticle* efParticle_DamageCoin_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_SetOff_MakeEffect(Vec3f *pos, s32 size);
extern GObj* efParticle_FireSpark_MakeEffect(GObj *fighter_gobj);
extern void efTransform_Reflector_SetImageIndex(GObj *effect_gobj, s32 index);
extern void efParticle_Reflector_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_Reflector_MakeEffect(GObj *fighter_gobj);
extern void efShieldProcUpdate(GObj *effect_gobj);
extern void efShieldProcRender(GObj *effect_gobj);
extern GObj* efParticle_Shield_MakeEffect(GObj *fighter_gobj);
extern void efYoshiShieldProcRender(GObj *effect_gobj);
extern GObj* efParticle_YoshiShield_MakeEffect(GObj *fighter_gobj);
extern efParticle* efParticle_ThunderHit_MakeEffect(Vec3f *pos);
extern efGenerator* efParticle_Ripple_MakeEffect(Vec3f *pos);
extern GObj* efParticle_CatchSwirl_MakeEffect(Vec3f *pos);
extern GObj* efParticle_ReflectBreak_MakeEffect(Vec3f *pos, s32 lr);
extern efParticle* efParticle_FuraSparkle_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_Psionic_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_FlashSmall_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_FlashMiddle_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_FlashLarge_MakeEffect(Vec3f *pos);
extern efGenerator* efParticle_ShieldBreak_MakeEffect(Vec3f *pos);
extern void func_ovl2_801017E8(GObj *effect_gobj);
extern GObj* func_ovl2_8010183C(Vec3f *pos, s32 arg1);
extern GObj* efParticle_ThunderShock_MakeEffect(GObj *fighter_gobj, Vec3f *pos, s32 frame);
extern void efParticle_ThunderTrail_ProcUpdate(GObj *effect_gobj);
extern void efParticle_ThunderTrail_ProcRender(void);
extern GObj* efParticle_ThunderTrail_MakeEffect(Vec3f *pos, s32 lifetime, s32 texture_index);
extern GObj* efParticle_ThunderJolt_MakeEffect(Vec3f *pos, f32 rotate);
extern void efParticle_VulcanJab_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_VulcanJab_MakeEffect(Vec3f *pos, s32 lr, f32 rotate, f32 vel, f32 add);
extern GObj* efParticle_GrappleBeamGlow_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_FalconKick_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_FalconPunch_MakeEffect(GObj *fighter_gobj);
extern efGenerator* efParticle_KirbyStar_MakeEffect(Vec3f *pos);
extern efGenerator* efParticle_StarSplash_MakeEffect(Vec3f *pos, s32 lr);
extern GObj* efParticle_PurinSing_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_DeadBlast_MakeEffect(Vec3f *pos, s32 player, s32 type);
extern void func_ovl2_801023D4(Vec3f *pos);
extern GObj* efParticle_FinalCutterUp_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_FinalCutterDown_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_FinalCutterDraw_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_FinalCutterTrail_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_PsychicMagnet_MakeEffect(GObj *fighter_gobj);
extern void efParticle_PKThunderTrail_ProcUpdate(GObj *effect_gobj);
extern void efParticle_PKThunderTrail_ProcRender(void);
extern GObj* efParticle_PKThunderTrail_MakeEffect(GObj *fighter_gobj);
extern void efParticle_PKReflectTrail_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_PKReflectTrail_MakeEffect(GObj *weapon_gobj);
extern GObj* efParticle_PKThunderWave_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_PKFlash_MakeEffect(Vec3f *pos);
extern GObj* efParticle_LinkEntryWave_MakeEffect(Vec3f *pos);
extern GObj* efParticle_LinkEntryBeam_MakeEffect(Vec3f *pos);
extern GObj* efParticle_KirbyEntryStar_MakeEffect(Vec3f *pos, s32 lr);
extern GObj* efParticle_MBallRays_MakeEffect(Vec3f *pos);
extern void efMBallThrownProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_MBallThrown_MakeEffect(Vec3f *pos, s32 lr);
extern efParticle* efParticle_FireGrind_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_HealSparkles_MakeEffect(Vec3f *pos);
extern GObj* efParticle_YoshiEntryEgg_MakeEffect(Vec3f *pos);
extern void efYoshiEggLaySetAnim(GObj *effect_gobj, s32 index);
extern void efYoshiEggLayProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_YoshiEggLay_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_YoshiEggRoll_MakeEffect(GObj *fighter_gobj);
extern efParticle* func_ovl2_801031E0(Vec3f *pos);
extern efParticle* func_ovl2_80103280(Vec3f *pos);
extern efParticle* efParticle_FoxBlasterGlow_MakeEffect(Vec3f *pos);
extern GObj* efParticle_SpinAttackTrail_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_DonkeyEntryBarrel_MakeEffect(Vec3f *pos);
extern GObj* efParticle_SamusEntryPoint_MakeEffect(Vec3f *pos);
extern void efCaptainEntryCarProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_CaptainEntryCar_MakeEffect(Vec3f *pos, s32 lr);
extern GObj* efParticle_MarioEntryPipe_MakeEffect(Vec3f *pos, s32 ft_kind);
extern void efFoxEntryArwingProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_FoxEntryArwing_MakeEffect(Vec3f *pos, s32 lr);
extern void func_ovl2_80103918(f32 arg0, f32 arg1, s32 arg2);
extern void func_ovl2_80103974(f32 arg0, f32 arg1);
extern void func_ovl2_80103994(f32 arg0, f32 arg1);
extern void func_ovl2_801039B4(f32 arg0, f32 arg1);
extern efParticle* efParticle_SingNote_MakeEffect(Vec3f *pos);
extern efParticle* efParticle_YoshiEggExplode_MakeEffect(Vec3f *pos);
extern void efParticle_CaptureKirbyStar_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_CaptureKirbyStar_MakeEffect(GObj *fighter_gobj);
extern void efParticle_LoseKirbyStar_ProcUpdate(GObj *effect_gobj);
extern GObj* efParticle_LoseKirbyStar_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_RebirthHalo_MakeEffect(GObj *fighter_gobj, f32 scale);
extern efParticle* efParticle_BattleScoreDisplay_MakeEffect(Vec3f *pos, s32 arg1);
extern efParticle* efParticle_EggBreak_MakeEffect(Vec3f *pos);
extern void efParticle_KirbyInhaleWind_ProcUpdate(GObj *effect_gobj);
extern efParticle* efParticle_KirbyInhaleWind_MakeEffect(GObj *fighter_gobj);
extern GObj* efParticle_ItemPickupSwirl_ProcUpdate(Vec3f *pos);
extern efParticle* efParticle_ItemSpawnSwirl_MakeEffect(Vec3f *pos);
extern efParticle* func_ovl2_80104554(Vec3f *pos, s32 arg1);

#endif
