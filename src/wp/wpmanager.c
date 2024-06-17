#include <wp/weapon.h>
#include <it/item.h>
#include <ft/fighter.h>

extern void func_8000BED8_CAD8(GObj*, void*, void*, f32);
extern f32 gmCommon_DamageGetStaleMul(s32, s32, u16);

// // // // // // // // // // // //
//                               //
//   GLOBAL / STATIC VARIABLES   //
//                               //
// // // // // // // // // // // //

// 0x8018CFF0 - Points to next available weapon struct
wpStruct *sWPAllocFree;

// 0x8018CFF4
s32 sWPDisplayMode;

// 0x8018CFF8
u32 sWPGroupID;

// // // // // // // // // // // //
//                               //
//           FUNCTIONS           //
//                               //
// // // // // // // // // // // //

// 0x801654B0
void wpManagerAllocWeapons(void)
{
    wpStruct *wp;
    s32 i;

    sWPAllocFree = wp = gsMemoryAlloc(sizeof(wpStruct) * WEAPON_ALLOC_MAX, 0x8);

    for (i = 0; i < (WEAPON_ALLOC_MAX - 1); i++)
    {
        wp[i].alloc_next = &wp[i + 1];
    }
    if (wp != NULL)
    {
        wp[i].alloc_next = NULL;
    }
    sWPGroupID = 1;
    sWPDisplayMode = dbObject_DisplayMode_Master;
}

// 0x80165558
wpStruct* wpManagerGetWeaponSetNextAlloc()
{
    wpStruct *new_weapon = sWPAllocFree;
    wpStruct *get_weapon;

    if (new_weapon == NULL)
    {
        return NULL;
    }
    get_weapon = new_weapon;

    sWPAllocFree = new_weapon->alloc_next;

    return get_weapon;
}

// 0x80165588
void wpManagerSetPrevWeaponAlloc(wpStruct *wp)
{
    wp->alloc_next = sWPAllocFree;

    sWPAllocFree = wp;
}

// 0x801655A0 - Do NOT declare this with a void argument! PK Thunder passes unused arguments to this function.
u32 wpManagerGetGroupIndexInc()
{
    u32 group_id = sWPGroupID++;

    if (sWPGroupID == 0)
    {
        sWPGroupID++;
    }
    return group_id;
}

// 0x801655C8
GObj* wpManagerMakeWeapon(GObj *spawn_gobj, wpCreateDesc *wp_desc, Vec3f *spawn_pos, u32 flags)
{
    GObj *weapon_gobj;
    void (*cb)(GObj*);
    wpAttributes *attributes;
    wpStruct *wp;
    wpStruct *owner_wp;
    itStruct *ip;
    ftStruct *fp;
    s32 unused[7];

    wp = wpManagerGetWeaponSetNextAlloc(spawn_gobj);

    if (wp == NULL)
    {
        return NULL;
    }
    weapon_gobj = omMakeGObjSPAfter(GObj_Kind_Weapon, NULL, GObj_LinkID_Weapon, GOBJ_LINKORDER_DEFAULT);

    if (weapon_gobj == NULL)
    {
        wpManagerSetPrevWeaponAlloc(wp);
        return NULL;
    }
    attributes = (wpAttributes*) ((uintptr_t)*wp_desc->p_weapon + (intptr_t)wp_desc->o_attributes); // I hope this is correct?
    weapon_gobj->user_data.p = wp;
    wp->weapon_gobj = weapon_gobj;
    wp->wp_kind = wp_desc->wp_kind;

    switch (flags & WEAPON_MASK_SPAWN_ALL)
    {
    case WEAPON_MASK_SPAWN_FIGHTER: // Weapons spawned by fighters
        fp = ftGetStruct(spawn_gobj);
        wp->owner_gobj = spawn_gobj;
        wp->team = fp->team;
        wp->player = fp->player;
        wp->handicap = fp->handicap;
        wp->player_number = fp->player_number;
        wp->lr = fp->lr;

        wp->display_mode = fp->display_mode;

        wp->weapon_hit.stale = gmCommon_DamageGetStaleMul(fp->player, fp->attack_id, fp->motion_count);
        wp->weapon_hit.attack_id = fp->attack_id;
        wp->weapon_hit.motion_count = fp->motion_count;
        wp->weapon_hit.stat_flags = fp->stat_flags;
        wp->weapon_hit.stat_count = fp->stat_count;
        break;

    case WEAPON_MASK_SPAWN_WEAPON: // Weapons spawned by other weapons
        owner_wp = wpGetStruct(spawn_gobj);
        wp->owner_gobj = owner_wp->owner_gobj;
        wp->team = owner_wp->team;
        wp->player = owner_wp->player;
        wp->handicap = owner_wp->handicap;
        wp->player_number = owner_wp->player_number;
        wp->lr = owner_wp->lr;

        wp->display_mode = owner_wp->display_mode;

        wp->weapon_hit.stale = owner_wp->weapon_hit.stale;
        wp->weapon_hit.attack_id = owner_wp->weapon_hit.attack_id;
        wp->weapon_hit.motion_count = owner_wp->weapon_hit.motion_count;
        wp->weapon_hit.stat_flags = owner_wp->weapon_hit.stat_flags;
        wp->weapon_hit.stat_count = owner_wp->weapon_hit.stat_count;
        break;

    case WEAPON_MASK_SPAWN_ITEM: // Weapons spawned by items
        ip = itGetStruct(spawn_gobj);
        wp->owner_gobj = ip->owner_gobj;
        wp->team = ip->team;
        wp->player = ip->player;
        wp->handicap = ip->handicap;
        wp->player_number = ip->player_number;
        wp->lr = ip->lr;

        wp->display_mode = ip->display_mode;

        wp->weapon_hit.stale = ip->item_hit.stale;
        wp->weapon_hit.attack_id = ip->item_hit.attack_id;
        wp->weapon_hit.motion_count = ip->item_hit.motion_count;
        wp->weapon_hit.stat_flags = ip->item_hit.stat_flags;
        wp->weapon_hit.stat_count = ip->item_hit.stat_count;
        break;

    default: // Weapons spawned independently 
    case WEAPON_MASK_SPAWN_GROUND:
        wp->owner_gobj = NULL;
        wp->team = WEAPON_TEAM_DEFAULT;
        wp->player = WEAPON_PORT_DEFAULT;
        wp->handicap = WEAPON_HANDICAP_DEFAULT;
        wp->player_number = 0;
        wp->lr = LR_Right;

        wp->display_mode = sWPDisplayMode;

        wp->weapon_hit.attack_id = ftMotion_AttackIndex_None;
        wp->weapon_hit.stale = WEAPON_STALE_DEFAULT;
        wp->weapon_hit.motion_count = gmCommon_GetMotionCountInc();
        wp->weapon_hit.stat_flags.stat_attack_id = ftStatus_AttackIndex_None;
        wp->weapon_hit.stat_flags.is_smash_attack = wp->weapon_hit.stat_flags.is_ground_or_air = wp->weapon_hit.stat_flags.is_projectile = FALSE;
        wp->weapon_hit.stat_count = gmCommon_GetStatUpdateCountInc();
        break;
    }
    wp->weapon_hit.update_state = gmHitCollision_UpdateState_New;
    
    wp->phys_info.vel_air.x = wp->phys_info.vel_air.y = wp->phys_info.vel_air.z = 0.0F;

    wp->phys_info.vel_ground = 0.0F;

    wp->weapon_hit.damage = attributes->damage;

    wp->weapon_hit.element = attributes->element;

    wp->weapon_hit.offset[0].x = attributes->offset[0].x;
    wp->weapon_hit.offset[0].y = attributes->offset[0].y;
    wp->weapon_hit.offset[0].z = attributes->offset[0].z;
    wp->weapon_hit.offset[1].x = attributes->offset[1].x;
    wp->weapon_hit.offset[1].y = attributes->offset[1].y;
    wp->weapon_hit.offset[1].z = attributes->offset[1].z;

    wp->weapon_hit.size = attributes->size * 0.5F;

    wp->weapon_hit.angle = attributes->angle;

    wp->weapon_hit.knockback_scale = attributes->knockback_scale;
    wp->weapon_hit.knockback_weight = attributes->knockback_weight;
    wp->weapon_hit.knockback_base = attributes->knockback_base;

    wp->weapon_hit.can_setoff = attributes->can_setoff;

    wp->weapon_hit.shield_damage = attributes->shield_damage;

    wp->weapon_hit.hit_sfx = attributes->sfx;

    wp->weapon_hit.priority = attributes->priority;

    wp->weapon_hit.can_rehit_item = attributes->can_rehit_item;
    wp->weapon_hit.can_rehit_fighter = attributes->can_rehit_fighter;
    wp->weapon_hit.can_rehit_shield = FALSE;

    wp->weapon_hit.can_hop = attributes->can_hop;
    wp->weapon_hit.can_reflect = attributes->can_reflect;
    wp->weapon_hit.can_absorb = attributes->can_absorb;
    wp->weapon_hit.can_not_heal = FALSE;
    wp->weapon_hit.can_shield = attributes->can_shield;
    
    wp->weapon_hit.hitbox_count = attributes->hitbox_count;

    wp->weapon_hit.interact_mask = GMHITCOLLISION_MASK_ALL;

    wpMainClearHitRecord(wp);

    wp->hit_normal_damage = 0;
    wp->hit_refresh_damage = 0;
    wp->hit_attack_damage = 0;
    wp->hit_shield_damage = 0;
    wp->reflect_gobj = NULL;
    wp->absorb_gobj = NULL;

    wp->is_hitlag_victim = FALSE;
    wp->is_hitlag_weapon = FALSE;
    wp->is_camera_follow = FALSE;

    wp->group_id = 0;

    wp->is_static_damage = FALSE;

    wp->p_sfx = NULL;
    wp->sfx_id = 0;

    wp->shield_collide_angle = 0.0F;

    wp->shield_collide_vec.x = wp->shield_collide_vec.y = wp->shield_collide_vec.z = 0.0F;

    if (wp_desc->flags & 0x1)
    {
        func_8000F590(weapon_gobj, attributes->dobj_setup, NULL, wp_desc->transform_types.tk1, wp_desc->transform_types.tk2, wp_desc->transform_types.unk_dobjtransform_0x2);

        cb = (wp_desc->flags & 0x2) ? wpRenderDObjTreeDLLinks : func_ovl3_80167618;
    }
    else
    {
        func_ovl0_800C89BC(omAddDObjForGObj(weapon_gobj, attributes->dobj_setup), wp_desc->transform_types.tk1, wp_desc->transform_types.tk2, wp_desc->transform_types.unk_dobjtransform_0x2);

        cb = (wp_desc->flags & 0x2) ? wpRenderDObjDLLinks : wpRenderDLHead1;
    }
    omAddGObjRenderProc(weapon_gobj, cb, 14, GOBJ_DLLINKORDER_DEFAULT, -1);

    if (attributes->mobjsub != NULL)
    {
        func_8000F8F4(weapon_gobj, attributes->mobjsub);
    }
    if ((attributes->anim_joint != NULL) || (attributes->matanim_joint != NULL))
    {
        func_8000BED8_CAD8(weapon_gobj, attributes->anim_joint, attributes->matanim_joint, 0.0F);
    }
    wp->coll_data.p_translate = &DObjGetStruct(weapon_gobj)->translate.vec.f;
    wp->coll_data.p_lr = &wp->lr;

    wp->coll_data.object_coll.top = attributes->objectcoll_top;
    wp->coll_data.object_coll.center = attributes->objectcoll_center;
    wp->coll_data.object_coll.bottom = attributes->objectcoll_bottom;
    wp->coll_data.object_coll.width = attributes->objectcoll_width;
    wp->coll_data.p_object_coll = &wp->coll_data.object_coll;

    wp->coll_data.ignore_line_id = -1;
    wp->coll_data.ground_line_id = -1;
    wp->coll_data.ceil_line_id = -1;
    wp->coll_data.lwall_line_id = -1;
    wp->coll_data.rwall_line_id = -1;

    wp->coll_data.coll_update_frame = gMPCollUpdateFrame;
    wp->coll_data.coll_mask_curr = 0;

    wp->coll_data.vel_push.x = 0.0F;
    wp->coll_data.vel_push.y = 0.0F;
    wp->coll_data.vel_push.z = 0.0F;

    omAddGObjCommonProc(weapon_gobj, wpProcessProcWeaponMain, GObjProcess_Kind_Proc, 3);
    omAddGObjCommonProc(weapon_gobj, wpProcessProcSearchHitWeapon, GObjProcess_Kind_Proc, 1);
    omAddGObjCommonProc(weapon_gobj, wpProcessProcHitCollisions, GObjProcess_Kind_Proc, 0);

    wp->proc_update    = wp_desc->proc_update;
    wp->proc_map       = wp_desc->proc_map;
    wp->proc_hit       = wp_desc->proc_hit;
    wp->proc_shield    = wp_desc->proc_shield;
    wp->proc_hop       = wp_desc->proc_hop;
    wp->proc_setoff    = wp_desc->proc_setoff;
    wp->proc_reflector = wp_desc->proc_reflector;
    wp->proc_absorb    = wp_desc->proc_absorb;
    wp->proc_dead      = NULL;

    wp->coll_data.pos_curr = DObjGetStruct(weapon_gobj)->translate.vec.f = *spawn_pos;

    if (flags & WEAPON_FLAG_PROJECT)
    {
        switch (flags & WEAPON_MASK_SPAWN_ALL)
        {
        default:
        case WEAPON_MASK_SPAWN_GROUND:
            break;

        case WEAPON_MASK_SPAWN_FIGHTER:
            wpMap_RunCollisionDefault(weapon_gobj, ftGetStruct(spawn_gobj)->coll_data.p_translate, &ftGetStruct(spawn_gobj)->coll_data);
            break;

        case WEAPON_MASK_SPAWN_WEAPON:
            wpMap_RunCollisionDefault(weapon_gobj, wpGetStruct(spawn_gobj)->coll_data.p_translate, &wpGetStruct(spawn_gobj)->coll_data);
            break;

        case WEAPON_MASK_SPAWN_ITEM:
            wpMap_RunCollisionDefault(weapon_gobj, itGetStruct(spawn_gobj)->coll_data.p_translate, &itGetStruct(spawn_gobj)->coll_data);
            break;
        }
    }
    wp->ground_or_air = GA_Air;

    wpProcessUpdateHitPositions(weapon_gobj);

    return weapon_gobj;
}