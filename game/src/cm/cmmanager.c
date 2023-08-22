#include <gr/ground.h>
#include <ft/fighter.h>
#include <wp/weapon.h>
#include <gm/battle.h>

f32 grCamera_Zoom_Table[/* */] =
{
     0.00F,
     1.50F,
     1.32F,
     1.16F,
     1.00F
};

// 0x8010B810
u32 func_ovl2_8010B810(Vec3f *pos)
{
    u32 bounds = 0;

    if (pos->x < gGroundInfo->cam_bound_left)
    {
        bounds |= 1;
    }
    if (pos->x > gGroundInfo->cam_bound_right)
    {
        bounds |= 2;
    }
    if (pos->y < gGroundInfo->cam_bound_bottom)
    {
        bounds |= 4;
    }
    if (pos->y > gGroundInfo->cam_bound_top)
    {
        bounds |= 8;
    }
    return bounds;
}

// 0x8010B8BC
void func_ovl2_8010B8BC(Vec3f *pos)
{
    while (TRUE)
    {
        u32 bounds = func_ovl2_8010B810(pos);

        if (bounds != 0)
        {
            if (bounds & 1)
            {
                pos->x = gGroundInfo->cam_bound_left;
            }
            else if (bounds & 2)
            {
                pos->x = gGroundInfo->cam_bound_right;
            }
            else if (bounds & 4)
            {
                pos->y = gGroundInfo->cam_bound_bottom;
            }
            else if (bounds & 8)
            {
                pos->y = gGroundInfo->cam_bound_top;
            }
        }
        else break;
    }
}

// 0x8010B98C
u32 func_ovl2_8010B98C(Vec3f *pos)
{
    u32 bounds = 0;

    if (pos->x < gGroundInfo->unk_groundinfo_0x90)
    {
        bounds |= 1;
    }
    if (pos->x > gGroundInfo->unk_groundinfo_0x8E)
    {
        bounds |= 2;
    }
    if (pos->y < gGroundInfo->unk_groundinfo_0x8C)
    {
        bounds |= 4;
    }
    if (pos->y > gGroundInfo->unk_groundinfo_0x8A)
    {
        bounds |= 8;
    }
    return bounds;
}

// 0x8010BA38
void func_ovl2_8010BA38(Vec3f *pos)
{
    while (TRUE)
    {
        u32 bounds = func_ovl2_8010B98C(pos);

        if (bounds != 0)
        {
            if (bounds & 1)
            {
                pos->x = gGroundInfo->unk_groundinfo_0x90;
            }
            else if (bounds & 2)
            {
                pos->x = gGroundInfo->unk_groundinfo_0x8E;
            }
            else if (bounds & 4)
            {
                pos->y = gGroundInfo->unk_groundinfo_0x8C;
            }
            else if (bounds & 8)
            {
                pos->y = gGroundInfo->unk_groundinfo_0x8A;
            }
        }
        else break;
    }
}

// 0x8010BB08
void func_ovl2_8010BB08(Vec3f *pos)
{
    pos->x = (gGroundInfo->cam_bound_top * pos->x) / gGroundInfo->blastzone_top;
    pos->y = gGroundInfo->cam_bound_top;
}

// 0x8010BB58
f32 func_ovl2_8010BB58(s32 index)
{
    f32 zoom = grCamera_Zoom_Table[index];

    if (gBattleState->game_type == gmMatch_GameType_HowToPlay)
    {
        zoom *= 0.75F;
    }
    return zoom;
}

// 0x8010BB98
f32 func_ovl2_8010BB98(ftStruct *fp, f32 cam_zoom)
{
    cam_zoom *= fp->fighter_cam_zoom_frame;
    cam_zoom *= fp->fighter_cam_zoom_range;

    if ((fp->status_info.status_id == ftStatus_Common_Wait) && (fp->status_info.status_time_spent >= 120))
    {
        cam_zoom *= 0.75F;
    }
    return cam_zoom;
}

// 0x8010BBE4
f32 func_ovl2_8010BBE4(f32 arg0)
{
    if (arg0 > 2000.0F)
    {
        return 0.0682F;
    }
    else if (arg0 < 1000.0F)
    {
        return 0.0F;
    }
    else return ((arg0 - 1000.0F) / 1000) * 0.0682F;
}

// 0x8010BC54
void func_ovl2_8010BC54(Vec3f *vec, f32 *hz, f32 *vt)
{
    s32 player_num;
    s32 cam_num;
    ftCamera ft_cam[GMMATCH_PLAYERS_MAX];
    ftStruct *fp;
    wpStruct *wp;
    f32 temp_f16;
    f32 var_f16;
    f32 temp_f18;
    f32 ft_right;
    f32 ft_top;
    f32 ft_left;
    f32 ft_bottom;
    f32 zoom;
    GObj *fighter_gobj;
    ftStruct *cam_fp;
    f32 wp_top;
    f32 wp_bottom;
    f32 wp_left;
    f32 wp_right;
    f32 adjust;
    f32 gm_top;
    f32 gm_bottom;
    f32 gm_left;
    f32 gm_right;
    f32 var_f2;
    GObj *weapon_gobj;
    s32 lr;
    Vec3f weapon_pos;

    fighter_gobj = gOMObjCommonLinks[gOMObjLinkIndexFighter];

    player_num = 0;

    while (fighter_gobj != NULL)
    {
        fp = ftGetStruct(fighter_gobj);

        switch (fp->cam_mode)
        {
        default:
            if (player_num >= ARRAY_COUNT(ft_cam))
            {
                while (TRUE)
                {
                    fatal_printf("Player Num is Over for Camera!\n");
                    scnmgr_crash_print_gobj_state();
                }
            }
            ft_cam[player_num].target_fp = fp;

            switch (fp->cam_mode)
            {
            default:
                ft_cam[player_num].target_pos = DObjGetStruct(fighter_gobj)->translate;
                break;

            case 3:
            case 4:
                ft_cam[player_num].target_pos = fp->entry_pos;
                break;

            case 2:
                ft_cam[player_num].target_pos = fp->status_vars.common.dead.pos;
                break;
            }
            ft_cam[player_num].target_pos.y += fp->attributes->cam_offset_y;

            if ((gBattleState->game_type == gmMatch_GameType_1PGame) && (gBattleState->player_block[fp->player].is_rebirth_multi != FALSE))
            {
                switch (fp->cam_mode)
                {
                default: 
                    break;

                    // WHAT!?!? There are a few ways to match this, but it appears to be a control flow issue more than anything.
                    // Other solution #1: cast &ft_cam[player_num].target_pos to an integer
                    // Other solution #2: explicitly define any of the Vec3f* functions below as s32 functions (just forget about it)
                }
                func_ovl2_8010BA38(&ft_cam[player_num].target_pos);
            }
            else switch (fp->cam_mode)
            {
            case 2:
                func_ovl2_8010BB08(&ft_cam[player_num].target_pos);
                break;

            default:
                func_ovl2_8010B8BC(&ft_cam[player_num].target_pos);
                break;
            }
            player_num++;
            break;

        case 1:
            break;
        }
        fighter_gobj = fighter_gobj->group_gobj_next;
    }
    if (player_num != 0)
    {
        ft_top = 65536.0F;
        ft_bottom = -65536.0F;
        ft_left = -65536.0F;
        ft_right = 65536.0F;

        gm_bottom = 65536.0F;
        gm_top = -65536.0F;
        gm_left = 65536.0F;
        gm_right = -65536.0F;

        zoom = func_ovl2_8010BB58(player_num);

        for (cam_num = 0; cam_num < player_num; cam_num++)
        {
            cam_fp = ft_cam[cam_num].target_fp;

            adjust = func_ovl2_8010BB98(cam_fp, zoom);

            lr = (cam_fp->cam_mode == 3 || cam_fp->cam_mode == 4) ? cam_fp->status_vars.common.entry.lr_entry : cam_fp->lr;

            if (lr == LR_Left)
            {
                var_f2 = ft_cam[cam_num].target_pos.x - (1000.0F * adjust);
                var_f16 = ft_cam[cam_num].target_pos.x + (700.0F * adjust);
            }
            else
            {
                var_f2 = ft_cam[cam_num].target_pos.x - (700.0F * adjust);
                var_f16 = ft_cam[cam_num].target_pos.x + (1000.0F * adjust);
            }
            if (var_f2 < gm_left)
            {
                gm_left = var_f2;
            }
            if (gm_right < var_f16)
            {
                gm_right = var_f16;
            }
            temp_f16 = ft_cam[cam_num].target_pos.y + (700.0F * adjust);
            temp_f18 = ft_cam[cam_num].target_pos.y + (-700.0F * adjust);

            if (temp_f18 < gm_bottom)
            {
                gm_bottom = temp_f18;
            }
            if (gm_top < temp_f16)
            {
                gm_top = temp_f16;
            }
            if (ft_cam[cam_num].target_pos.x < ft_right) // ft_right = ft_right?
            {
                ft_right = ft_cam[cam_num].target_pos.x;
            }
            if (ft_cam[cam_num].target_pos.x > ft_left) // ft_left = ft_left?
            {
                ft_left = ft_cam[cam_num].target_pos.x;
            }
            if (ft_cam[cam_num].target_pos.y < ft_top) // ft_top = ft_top?
            {
                ft_top = ft_cam[cam_num].target_pos.y;
            }
            if (ft_cam[cam_num].target_pos.y > ft_bottom) // ft_bottom = ft_bottom?
            {
                ft_bottom = ft_cam[cam_num].target_pos.y;
            }
            ft_cam[cam_num].unk_ftcam_0x10 = adjust;
        }
        weapon_gobj = gOMObjCommonLinks[gOMObjLinkIndexWeapon];

        while (weapon_gobj != NULL)
        {
            wp = wpGetStruct(weapon_gobj);

            if (wp->is_camera_follow)
            {
                weapon_pos = DObjGetStruct(weapon_gobj)->translate;

                wp_left = ft_right - 1000.0F; // wp_left = left?
                wp_right = ft_left + 1000.0F; // wp_right = right?
                wp_bottom = ft_top - 1000.0F; // wp_bottom = bottom?
                wp_top = ft_bottom + 1000.0F; // wp_top = top?

                func_ovl2_8010B8BC(&weapon_pos);

                if (weapon_pos.x < wp_left)
                {
                    weapon_pos.x = wp_left;
                }
                if (weapon_pos.x > wp_right)
                {
                    weapon_pos.x = wp_right;
                }
                if (weapon_pos.y < wp_bottom)
                {
                    weapon_pos.y = wp_bottom;
                }
                if (weapon_pos.y > wp_top)
                {
                    weapon_pos.y = wp_top;
                }
                if ((weapon_pos.x - 1000.0F) < gm_left) // gm_left = gm_left?
                {
                    gm_left = (weapon_pos.x - 1000.0F);
                }
                if ((weapon_pos.x + 1000.0F) > gm_right) // gm_right = gm_right?
                {
                    gm_right = (weapon_pos.x + 1000.0F);
                }
                if ((weapon_pos.y - 1000.0F) < gm_bottom) // gm_bottom = gm_bottom?
                {
                    gm_bottom = (weapon_pos.y - 1000.0F);
                }
                if ((weapon_pos.y + 1000.0F) > gm_top) // gm_top = gm_top?
                {
                    gm_top = (weapon_pos.y + 1000.0F);
                }
            }
            weapon_gobj = weapon_gobj->group_gobj_next;
        }
        *hz = (gm_right - gm_left) * 0.5F;
        *vt = (gm_top - gm_bottom) * 0.5F;

        vec->x = ((gm_left + gm_right) * 0.5F);
        vec->y = (0.5F - func_ovl2_8010BBE4((*vt < *hz) ? *hz : *vt)) * (gm_bottom + gm_top);
        vec->z = 0.0F;
    }
    else
    {
        vec->x = vec->y = vec->z = 0.0F;

        *hz = *vt = 2000.0F;
    }
}

// This is from .bss
extern f32 D_ovl2_801314F0;

// 0x8010C200
void func_ovl2_8010C200(f32 arg0, f32 arg1, f32 *arg2)
{
    f32 var_f0;

    arg1 /= func_ovl0_800C793C(F_DEG_TO_RAD(gCameraStruct.unk_cmstruct_0x40 * 0.5F));

    arg0 /= ((func_ovl0_800C793C(F_DEG_TO_RAD(gCameraStruct.unk_cmstruct_0x40 * 0.5F)) * gCameraStruct.unk_0x38.x) / gCameraStruct.unk_0x38.y);

    var_f0 = (arg1 < arg0) ? arg0 : arg1;

    if (var_f0 < 2500.0F)
    {
        var_f0 = 2500.0F;
    }
    if (var_f0 > 30000.0F)
    {
        var_f0 = 30000.0F;
    }
    *arg2 = var_f0;
}

extern f32 D_ovl2_80131464;
extern f32 D_ovl2_80131468; // Also from .bss

// 0x8010C320
void func_ovl2_8010C320(s32 arg0, Vec3f *vec, f32 arg2, f32 arg3)
{
    f32 temp_f12;
    f32 temp_f12_2;

    temp_f12 = D_ovl2_80131464 + arg3 + gGroundInfo->light_angle.z;

    vec->y = -bitmap_sinf(temp_f12);
    vec->z = bitmap_cosf(temp_f12);

    temp_f12_2 = D_ovl2_80131468 + arg2;

    vec->x = (bitmap_sinf(temp_f12_2) * vec->z);

    vec->z *= bitmap_cosf(temp_f12_2);
}

// 0x8010C3C0
void func_ovl2_8010C3C0(Vec3f *vec, Vec3f *arg1)
{
    f32 var_f0;
    f32 var_f2;

    var_f2 = -F_DEG_TO_RAD((vec->y + (-900.0F)) / 133.0F);

    if (var_f2 > F_DEG_TO_RAD(5.0F)) // 0.08726647F
    {
        var_f2 = F_DEG_TO_RAD(5.0F);
    }
    if (var_f2 < F_DEG_TO_RAD(-7.0F)) // -0.122173056F
    {
        var_f2 = F_DEG_TO_RAD(-7.0F);
    }
    var_f0 = -F_DEG_TO_RAD(vec->x / 133.0F);

    if (var_f0 > F_DEG_TO_RAD(17.5F)) // 0.30543265F
    {
        var_f0 = F_DEG_TO_RAD(17.5F);
    }
    if (var_f0 < F_DEG_TO_RAD(-17.5F)) // -0.30543265F
    {
        var_f0 = F_DEG_TO_RAD(-17.5F);
    }
    func_ovl2_8010C320(vec, arg1, var_f0, var_f2);
}

// 0x8010C4A4
void func_ovl2_8010C4A4(Vec3f *arg0, Vec3f *arg1)
{
    func_ovl2_8010C320(arg0, arg1, 0.0F, 0.0F);
}

// 0x8010C4D0
f32 func_ovl2_8010C4D0(void)
{
    if (gCameraStruct.cam_target_dist > 15000.0F)
    {
        return 0.1F;
    }
    else if (gCameraStruct.cam_target_dist < 2000.0F)
    {
        return 0.05F;
    }
    return ((1.0F - ((gCameraStruct.cam_target_dist - 2000.0F) / 13000.0F)) * 0.05F) + .05F; // Needs to be two different 0.05s lol
}

// 0x8010C55C
void func_ovl2_8010C55C(OMCamera *cam, Vec3f *arg1, f32 arg2)
{
    f32 mag;
    f32 unused;
    Vec3f sp1C;

    lbVector_Vec3fSubtract(&sp1C, arg1, &cam->pan);
    mag = lbVector_Vec3fMagnitude(&sp1C) * arg2;
    lbVector_Vec3fNormalize(&sp1C);
    lbVector_Vec3fScale(&sp1C, mag);
    lbVector_Vec3fAddTo(&cam->pan, &sp1C);
}

// 0x8010C5C0
void func_ovl2_8010C5C0(OMCamera *arg0, Vec3f *arg1)
{
    Vec3f sp34;
    Vec3f pan;
    f32 unused;
    f32 mag;

    pan.x = arg0->pan.x + (gCameraStruct.cam_target_dist * arg1->x);
    pan.y = arg0->pan.y + (gCameraStruct.cam_target_dist * arg1->y);
    pan.z = arg0->pan.z + (gCameraStruct.cam_target_dist * arg1->z);

    lbVector_Vec3fSubtract(&sp34, &pan, &arg0->tilt);
    mag = lbVector_Vec3fMagnitude(&sp34) * 0.1F;
    lbVector_Vec3fNormalize(&sp34);
    lbVector_Vec3fScale(&sp34, mag);
    lbVector_Vec3fAddTo(&arg0->tilt, &sp34);
}

// 0x8010C670
void func_ovl2_8010C670(f32 arg0)
{
    f32 temp_f0;
    f32 temp_f14;

    temp_f0 = gCameraStruct.cam_target_dist - arg0;

    temp_f14 = temp_f0 * 0.075F;

    if (temp_f0 <= temp_f14)
    {
        gCameraStruct.cam_target_dist = arg0;
    }
    else gCameraStruct.cam_target_dist -= temp_f14;
}

// 0x8010C6B8
void func_ovl2_8010C6B8(OMCamera *cam)
{
    lbVector_Vec3fAddTo(&cam->pan, &gCameraStruct.unk_cmstruct_0x14);
    gCameraStruct.unk_cmstruct_0x14.x = gCameraStruct.unk_cmstruct_0x14.y = gCameraStruct.unk_cmstruct_0x14.z = 0.0F;
}

// 0x8010C6FC
void func_ovl2_8010C6FC(OMCamera *cam)
{
    cam->unk_omcam_0x20 = gCameraStruct.unk_cmstruct_0x40;
}

// 0x8010C70C
void func_ovl2_8010C70C(f32 arg0)
{
    gCameraStruct.unk_cmstruct_0x40 += ((arg0 - gCameraStruct.unk_cmstruct_0x40) * 0.1F);
}

// 0x8010C734
void jtgt_ovl2_8010C734(GObj *camera_gobj)
{
    OMCamera *cam;
    f32 sp48;
    Vec3f sp3C;
    Vec3f sp30;
    f32 sp2C;
    f32 sp28;

    cam = OMCameraGetStruct(camera_gobj);

    func_ovl2_8010BC54(&sp30, &sp2C, &sp28);
    func_ovl2_8010C70C(38.0F);
    func_ovl2_8010C200(sp2C, sp28, &sp48);
    func_ovl2_8010C670(sp48);
    func_ovl2_8010C55C(cam, &sp30, func_ovl2_8010C4D0());
    func_ovl2_8010C3C0(&cam->pan, &sp3C);
    func_ovl2_8010C5C0(cam, &sp3C);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010C7D0
void func_ovl2_8010C7D0(OMCamera *cam, Vec3f *arg1)
{
    Vec3f sp3C;
    Vec3f sp30;
    f32 unused;
    f32 mag;
    f32 current;
    f32 step;

    sp30.x = cam->pan.x + (gCameraStruct.cam_target_dist * arg1->x);
    sp30.y = cam->pan.y + (gCameraStruct.cam_target_dist * arg1->y);
    sp30.z = cam->pan.z + (gCameraStruct.cam_target_dist * arg1->z);

    grCommon_Zebes_GetAcidLevelInfo(&current, &step);

    current += (step + 3000.0F);

    if (sp30.y < current)
    {
        sp30.y = current;
    }
    lbVector_Vec3fSubtract(&sp3C, &sp30, &cam->tilt);
    mag = lbVector_Vec3fMagnitude(&sp3C) * 0.1F;
    lbVector_Vec3fNormalize(&sp3C);
    lbVector_Vec3fScale(&sp3C, mag);
    lbVector_Vec3fAddTo(&cam->tilt, &sp3C);
}

// 0x8010C8C4
void jtgt_ovl2_8010C8C4(GObj *camera_gobj)
{
    OMCamera *cam;
    f32 sp48;
    Vec3f sp3C;
    Vec3f sp30;
    f32 sp2C;
    f32 sp28;

    cam = OMCameraGetStruct(camera_gobj);

    func_ovl2_8010BC54(&sp30, &sp2C, &sp28);
    func_ovl2_8010C70C(38.0F);
    func_ovl2_8010C200(sp2C, sp28, &sp48);
    func_ovl2_8010C670(sp48);
    func_ovl2_8010C55C(cam, &sp30, func_ovl2_8010C4D0());
    func_ovl2_8010C3C0(&cam->pan, &sp3C);
    func_ovl2_8010C7D0(cam, &sp3C);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010C960
void func_ovl2_8010C960(GObj *camera_gobj)
{
    OMCamera *cam;
    ftStruct *fp;
    Vec3f sp54;
    Vec3f sp48;
    Vec3f sp3C;
    Vec3f sp30;
    f32 temp_f12;

    cam = OMCameraGetStruct(camera_gobj);

    sp30 = DObjGetStruct(gCameraStruct.pl_pause_gobj)->translate;

    fp = ftGetStruct(gCameraStruct.pl_pause_gobj);

    sp30.y += fp->attributes->cam_offset_y;

    func_ovl2_8010C70C(gCameraStruct.unk_cmstruct_0x58);

    gCameraStruct.cam_target_dist = gCameraStruct.unk_cmstruct_0x50;

    func_ovl2_8010C55C(cam, &sp30, gCameraStruct.unk_cmstruct_0x54);

    sp54.y = D_ovl2_80131468 + gCameraStruct.unk_cmstruct_0x48;
    sp54.x = D_ovl2_80131464 + gCameraStruct.unk_cmstruct_0x4C;

    sp48.y = -bitmap_sinf(sp54.x);
    sp48.z = bitmap_cosf(sp54.x);
    sp48.x = bitmap_sinf(sp54.y) * sp48.z;
    sp48.z *= bitmap_cosf(sp54.y);

    func_ovl2_8010C5C0(cam, &sp48);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010CA7C
bool32 func_ovl2_8010CA7C(Vec3f *arg0)
{
    if ((func_ovl2_8010B810() != FALSE) || (arg0->z < -1000.0F) || (arg0->z > 1000.0F))
    {
        return TRUE;
    }
    else return FALSE;
}

extern void (*cmManager_ProcCamera[/* */])(void*);

// 0x8010CAE0
void jtgt_ovl2_8010CAE0(GObj *camera_gobj)
{
    if (func_ovl2_8010CA7C(&DObjGetStruct(gCameraStruct.pl_pause_gobj)->translate) != FALSE)
    {
        cmManager_ProcCamera[gCameraStruct.status_default](camera_gobj);
    }
    else func_ovl2_8010C960(camera_gobj);
}

// 0x8010CB48
void jtgt_ovl2_8010CB48(GObj *camera_gobj)
{
    OMCamera *cam;
    f32 sp48;
    Vec3f sp3C;
    Vec3f sp30;
    f32 sp2C;
    f32 sp28;

    cam = OMCameraGetStruct(camera_gobj);

    func_ovl2_8010BC54(&sp30, &sp2C, &sp28);
    func_ovl2_8010C70C(38.0F);
    func_ovl2_8010C200(sp2C, sp28, &sp48);
    func_ovl2_8010C670(sp48);
    func_ovl2_8010C55C(cam, &sp30, func_ovl2_8010C4D0());
    func_ovl2_8010C4A4(&cam->pan, &sp3C);
    func_ovl2_8010C5C0(cam, &sp3C);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010CBE4
void func_ovl2_8010CBE4(GObj *camera_gobj)
{
    OMCamera *cam;

    func_80010580();

    cam = OMCameraGetStruct(camera_gobj);

    cam->pan.x += gCameraStruct.unk_cmstruct_0x8C.x;
    cam->pan.y += gCameraStruct.unk_cmstruct_0x8C.y;
    cam->pan.z += gCameraStruct.unk_cmstruct_0x8C.z;
    cam->tilt.x += gCameraStruct.unk_cmstruct_0x8C.x;
    cam->tilt.y += gCameraStruct.unk_cmstruct_0x8C.y;
    cam->tilt.z += gCameraStruct.unk_cmstruct_0x8C.z;
}

// 0x8010CC74
void jtgt_ovl2_8010CC74(GObj *camera_gobj)
{
    func_ovl2_8010CBE4();

    if (OMCameraGetStruct(camera_gobj)->omcam_f0 == (f32)FLOAT_NEG_MAX)
    {
        func_ovl2_8010CF20();
    }
}

// 0x8010CCC0
void jtgt_ovl2_8010CCC0(GObj *camera_gobj)
{
    OMCamera *cam;
    Vec3f sp30;
    f32 sp2C;
    f32 sp28;

    cam = OMCameraGetStruct(camera_gobj);

    func_ovl2_8010C70C(38.0F);

    lbVector_Vec3fSubtract(&sp30, &gCameraStruct.unk_cmstruct_0x5C, &cam->pan);
    sp28 = lbVector_Vec3fMagnitude(&sp30);
    sp2C = func_ovl2_8010C4D0() * sp28;
    lbVector_Vec3fNormalize(&sp30);
    lbVector_Vec3fScale(&sp30, sp2C);
    lbVector_Vec3fAddTo(&cam->pan, &sp30);

    lbVector_Vec3fSubtract(&sp30, &gCameraStruct.unk_cmstruct_0x68, &cam->tilt);
    sp2C = lbVector_Vec3fMagnitude(&sp30) * 0.1F;
    lbVector_Vec3fNormalize(&sp30);
    lbVector_Vec3fScale(&sp30, sp2C);
    lbVector_Vec3fAddTo(&cam->tilt, &sp30);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010CDAC
void jtgt_ovl2_8010CDAC(GObj *camera_gobj)
{
    Vec3f unused;
    f32 sp58;
    f32 temp_f12;
    Vec3f sp48;
    Vec3f sp3C;
    Vec3f sp30;
    OMCamera *cam;
    ftStruct *fp;

    cam = OMCameraGetStruct(camera_gobj);
    sp30 = DObjGetStruct(gCameraStruct.pl_bonus_gobj)->translate;

    fp = ftGetStruct(gCameraStruct.pl_bonus_gobj);

    sp30.y += fp->attributes->cam_offset_y;
    sp30.z = 0.0F;

    func_ovl2_8010B8BC(&sp30);
    func_ovl2_8010C70C(gCameraStruct.unk_cmstruct_0x88);

    gCameraStruct.cam_target_dist = gCameraStruct.unk_cmstruct_0x80;

    func_ovl2_8010C55C(cam, &sp30, gCameraStruct.unk_cmstruct_0x84);

    sp58 = D_ovl2_80131468 + gCameraStruct.unk_cmstruct_0x78;
    temp_f12 = D_ovl2_80131464 + gCameraStruct.unk_cmstruct_0x7C;

    sp48.y = -bitmap_sinf(temp_f12);
    sp48.z = bitmap_cosf(temp_f12);
    sp48.x = bitmap_sinf(sp58) * sp48.z;
    sp48.z *= bitmap_cosf(sp58);
    func_ovl2_8010C5C0(cam, &sp48);
    func_ovl2_8010C6B8(cam);
    func_ovl2_8010C6FC(cam);
}

// 0x8010CECC
void cmManager_RunProcCamera(GObj *camera_gobj)
{
    gCameraStruct.proc_camera(camera_gobj);
}

// 0x8010CEF4
void cmManager_SetCameraStatus(s32 status_id)
{
    gCameraStruct.status_prev = gCameraStruct.status_curr;
    gCameraStruct.status_curr = status_id;

    gCameraStruct.proc_camera = cmManager_ProcCamera[status_id];
}

// 0x8010CF20
void func_ovl2_8010CF20(void)
{
    cmManager_SetCameraStatus(gCameraStruct.status_default);
}

void func_ovl2_8010CF44(GObj *fighter_gobj, f32 arg1, f32 arg2, f32 arg3, f32 arg4, f32 arg5)
{
    cmManager_SetCameraStatus(1);

    gCameraStruct.pl_pause_gobj = fighter_gobj;
    gCameraStruct.unk_cmstruct_0x48 = arg1;
    gCameraStruct.unk_cmstruct_0x4C = arg2;
    gCameraStruct.unk_cmstruct_0x50 = arg3;
    gCameraStruct.unk_cmstruct_0x54 = arg4;
    gCameraStruct.unk_cmstruct_0x58 = arg5;
}

// 0x8010CFA8
void func_ovl2_8010CFA8(GObj *fighter_gobj, f32 arg1, f32 arg2, f32 arg3, f32 arg4, f32 arg5)
{
    cmManager_SetCameraStatus(5);

    gCameraStruct.pl_bonus_gobj = fighter_gobj;
    gCameraStruct.unk_cmstruct_0x78 = arg1;
    gCameraStruct.unk_cmstruct_0x7C = arg2;
    gCameraStruct.unk_cmstruct_0x80 = arg3;
    gCameraStruct.unk_cmstruct_0x84 = arg4;
    gCameraStruct.unk_cmstruct_0x88 = arg5;
}

// 0x8010D00C
void cmManager_RestoreCameraStatus(void)
{
    cmManager_SetCameraStatus(gCameraStruct.status_prev);
}

// 0x8010D030
void func_ovl2_8010D030(ATrack *arg0, f32 arg1, Vec3f *arg2)
{
    cmManager_SetCameraStatus(2);

    gCameraStruct.unk_cmstruct_0x8C = *arg2;

    // WARNING: This takes DObj* as its first argument, but gCameraGObj should have OMCamera as its GObj render object???
    func_8000FA3C(DObjGetStruct(gCameraGObj), arg0, arg1);
    func_ovl2_8010CBE4(gCameraGObj);
}

// 0x8010D0A4
void func_ovl2_8010D0A4(Vec3f *arg0, Vec3f *arg1)
{
    Vec3f sp1C;

    cmManager_SetCameraStatus(4);

    gCameraStruct.unk_cmstruct_0x5C = *arg0;

    gCameraStruct.unk_cmstruct_0x68 = *arg1;

    lbVector_Vec3fSubtract(&sp1C, arg0, arg1);

    gCameraStruct.cam_target_dist = lbVector_Vec3fMagnitude(&sp1C);
}

// 0x8010D128
void func_ovl2_8010D128(Vec3f *arg0)
{
    gCameraStruct.unk_cmstruct_0x14 = *arg0;
}

// 0x8010D14C - Unused?
void func_ovl2_8010D14C(void *arg0)
{
    return;
}

// 0x8010D154
f32 func_ovl2_8010D154(void)
{
    f32 ret, abs;
    s32 i, j;

    ret = 0.0F;

    for (i = 0; i < ARRAY_COUNT(gCameraMatrix[i]); i++)
    {
        for (j = 0; j < ARRAY_COUNT(gCameraMatrix); j++)
        {
            abs = ABSF(gCameraMatrix[i][j]);

            if (ret < abs)
            {
                ret = abs;
            }
        }
    }
    return ret;
}