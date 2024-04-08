#include <wp/weapon.h>
#include <ft/fighter.h>

extern void *gFtDataBossBattleMotion;

extern intptr_t 
lWpBossBulletNormalWeaponAttributes;        // 0x00000774
extern intptr_t
lWpBossBulletHardWeaponAttributes;          // 0x000007A8

wpCreateDesc dWpBossBulletNormalWeaponDesc =
{
    0x01,                                   // Render flags?
    Wp_Kind_BulletNormal,                   // Weapon Kind
    &gFtDataBossBattleMotion,               // Pointer to character's loaded files?
    &lWpBossBulletNormalWeaponAttributes,   // Offset of weapon attributes in loaded files

    // DObj transformation struct
    {
        OMMtx_Transform_TraRotRpyRSca,      // Main matrix transformations
        OMMtx_Transform_Null,               // Secondary matrix transformations?
        0,                                  // ???
    },

    NULL,                                   // Proc Update
    wpBossBulletProcMap,                    // Proc Map
    wpBossBulletProcHit,                    // Proc Hit
    wpBossBulletProcHit,                    // Proc Shield
    wpBossBulletProcHop,                    // Proc Hop
    wpBossBulletProcHit,                    // Proc Set-Off
    wpBossBulletProcReflector,              // Proc Reflector
    wpBossBulletProcHit                     // Proc Absorb
};

wpCreateDesc dWpBossBulletHardWeaponDesc =
{
    0x01,                                   // Render flags?
    Wp_Kind_BulletHard,                     // Weapon Kind
    &gFtDataBossBattleMotion,               // Pointer to character's loaded files?
    &lWpBossBulletHardWeaponAttributes,     // Offset of weapon attributes in loaded files

    // DObj transformation struct
    {
        OMMtx_Transform_TraRotRpyRSca,      // Main matrix transformations
        OMMtx_Transform_Null,               // Secondary matrix transformations?
        0,                                  // ???
    },

    NULL,                                   // Proc Update
    wpBossBulletProcMap,                    // Proc Map
    wpBossBulletProcHit,                    // Proc Hit
    wpBossBulletProcHit,                    // Proc Shield
    wpBossBulletProcHop,                    // Proc Hop
    wpBossBulletProcHit,                    // Proc Set-Off
    wpBossBulletProcReflector,              // Proc Reflector
    wpBossBulletProcHit                     // Proc Absorb
};

// 0x8016DC00
sb32 wpBossBulletExplodeProcUpdate(GObj *weapon_gobj)
{
    if (wpMainDecLifeCheckExpire(wpGetStruct(weapon_gobj)) != FALSE)
    {
        return TRUE;
    }
    else return FALSE;
} 

// 0x8016DC2C
void wpBossBulletExplodeInitWeaponVars(GObj *weapon_gobj)
{
    wpStruct *wp = wpGetStruct(weapon_gobj);

    wp->weapon_hit.hit_sfx = alSound_SFX_ExplodeL;

    wp->weapon_hit.can_rehit_item = TRUE;
    wp->weapon_hit.can_hop = FALSE;
    wp->weapon_hit.can_reflect = FALSE;

    wp->weapon_hit.element = gmHitCollision_Element_Fire;

    wp->lifetime = WPYUBIBULLET_EXPLODE_LIFETIME;

    wp->phys_info.vel_air.x = wp->phys_info.vel_air.y = wp->phys_info.vel_air.z = 0.0F;

    wp->weapon_hit.size = WPYUBIBULLET_EXPLODE_SIZE;

    DObjGetStruct(weapon_gobj)->display_list = NULL;

    wp->proc_update = wpBossBulletExplodeProcUpdate;
    wp->proc_map = NULL;
    wp->proc_hit = NULL;
    wp->proc_shield = NULL;
    wp->proc_hop = NULL;
    wp->proc_setoff = NULL;
    wp->proc_reflector = NULL;
}

// 0x8016DCB0
sb32 wpBossBulletProcMap(GObj *weapon_gobj)
{
    if (wpMapTestAllCheckCollEnd(weapon_gobj) != FALSE)
    {
        wpBossBulletExplodeInitWeaponVars(weapon_gobj);
        func_800269C0(alSound_SFX_ExplodeS);
        efParticle_SparkleWhiteMultiExplode_MakeEffect(&DObjGetStruct(weapon_gobj)->translate.vec.f);

        return TRUE;
    }
    else return FALSE;
}

// 0x8016DD04
sb32 wpBossBulletProcHit(GObj *weapon_gobj)
{
    efParticle_SparkleWhiteMultiExplode_MakeEffect(&DObjGetStruct(weapon_gobj)->translate.vec.f);

    return TRUE;
}

// 0x8016DD2C
sb32 wpBossBulletProcHop(GObj *weapon_gobj)
{
    wpStruct *wp = wpGetStruct(weapon_gobj);

    func_80019438(&wp->phys_info.vel, &wp->shield_collide_vec, wp->shield_collide_angle * 2);
    wpMainReflectorRotateWeaponModel(weapon_gobj);

    return FALSE;
}

// 0x8016DD7C
sb32 wpBossBulletProcReflector(GObj *weapon_gobj)
{
    wpStruct *wp = wpGetStruct(weapon_gobj);
    ftStruct *fp = ftGetStruct(wp->owner_gobj);

    wpMainReflectorSetLR(wp, fp);
    wpMainReflectorRotateWeaponModel(weapon_gobj);

    return FALSE;
}

// 0x8016DDB4
GObj* wpBossBulletNormalMakeWeapon(GObj *fighter_gobj, Vec3f *pos)
{
    GObj *weapon_gobj = wpManagerMakeWeapon(fighter_gobj, &dWpBossBulletNormalWeaponDesc, pos, (WEAPON_FLAG_PROJECT | WEAPON_MASK_SPAWN_FIGHTER));
    wpStruct *wp;

    if (weapon_gobj == NULL)
    {
        return NULL;
    }
    wp = wpGetStruct(weapon_gobj);

    wp->phys_info.vel_air.x = WPYUBIBULLET_VEL_X * wp->lr;
    wp->phys_info.vel_air.y = WPYUBIBULLET_VEL_Y;

    wpMainReflectorRotateWeaponModel(weapon_gobj);

    return weapon_gobj;
}

// 0x8016DE28
GObj* wpBossBulletHardMakeWeapon(GObj *fighter_gobj, Vec3f *pos)
{
    GObj *weapon_gobj = wpManagerMakeWeapon(fighter_gobj, &dWpBossBulletHardWeaponDesc, pos, (WEAPON_FLAG_PROJECT | WEAPON_MASK_SPAWN_FIGHTER));
    wpStruct *wp;

    if (weapon_gobj == NULL)
    {
        return NULL;
    }
    wp = wpGetStruct(weapon_gobj);

    wp->phys_info.vel_air.x = WPYUBIBULLET_VEL_X * wp->lr;
    wp->phys_info.vel_air.y = WPYUBIBULLET_VEL_Y;

    wpMainReflectorRotateWeaponModel(weapon_gobj);

    return weapon_gobj;
}
