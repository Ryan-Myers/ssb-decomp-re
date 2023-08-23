#include <ft/fighter.h>
#include "ground.h"

// 0x80141FF0
void ftCommon_DokanStart_UpdateModelYaw(ftStruct *fp)
{
    if (fp->status_vars.common.dokan.turn_stop_wait != 0)
    {
        fp->status_vars.common.dokan.turn_stop_wait--;

        fp->joint[ftParts_Joint_TopN]->rotate.vec.f.y += (-FTCOMMON_DOKAN_TURN_STEP * fp->lr);

        func_ovl2_800EB528(fp->joint[ftParts_Joint_TopN]);
    }
}

// 0x8014204C
void ftCommon_DokanStart_ProcUpdate(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    ftCommon_DokanStart_UpdateModelYaw(fp);
    ftAnim_IfAnimEnd_ProcStatus(fighter_gobj, ftCommon_DokanWait_SetStatus);
}

// 0x80142080
void ftCommon_DokanStart_ProcPhysics(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);
    s32 unused[2];
    f32 pos_x;
    Vec3f *translate = &DObjGetStruct(fighter_gobj)->translate;
    s32 ground_line_id;

    mpCollision_GetGPointIDsKind((fp->status_vars.common.dokan.ground_material == mpCollision_Material_DokanLeft) ? 0xA : 0xB, &ground_line_id);
    mpCollision_GetGPointPositionsID(ground_line_id, &pos_x);

    if (translate->x > pos_x)
    {
        translate->x -= FTCOMMON_DOKAN_POS_ADJUST;

        if (translate->x <= pos_x)
        {
            translate->x = pos_x;
        }
    }
    else if (translate->x < pos_x)
    {
        translate->x += FTCOMMON_DOKAN_POS_ADJUST;

        if (translate->x >= pos_x)
        {
            translate->x = pos_x;
        }
    }
}

// 0x80142164
void ftCommon_DokanStart_SetStatus(GObj *fighter_gobj, s32 ground_line_id)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);
    s32 new_line_id;

    ftStatus_Update(fighter_gobj, ftStatus_Common_DokanStart, 0.0F, 1.0F, FTSTATUPDATE_NONE_PRESERVE);
    ftAnim_Update(fighter_gobj);

    fp->tap_stick_y = U8_MAX - 1;

    func_ovl2_800D9444(fighter_gobj);

    fp->x18F_flag_b4 = TRUE;

    fp->status_vars.common.dokan.ground_material = ground_line_id;

    mpCollision_GetGPointIDsKind((fp->status_vars.common.dokan.ground_material == mpCollision_Material_DokanLeft) ? 0xA : 0xB, &new_line_id);
    mpCollision_GetGPointPositionsID(new_line_id, &fp->status_vars.common.dokan.pos_current);

    func_800269C0(0xD6);
    func_ovl2_800E7F7C(fighter_gobj, 1);

    if
    (
        (fp->ft_kind == Ft_Kind_Mario) || (fp->ft_kind == Ft_Kind_MetalMario) || (fp->ft_kind == Ft_Kind_PolyMario) ||
        (fp->ft_kind == Ft_Kind_Luigi) || (fp->ft_kind == Ft_Kind_PolyLuigi)
    )
    {
        fp->status_vars.common.dokan.turn_stop_wait = 0;
    }
    else fp->status_vars.common.dokan.turn_stop_wait = FTCOMMON_DOKAN_TURN_STOP_WAIT_DEFAULT;

    ftCommon_DokanStart_UpdateModelYaw(fp);
    func_ovl2_8010972C();
}

// 0x80142258
bool32 ftCommon_DokanStart_CheckInterruptCommon(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);
    Vec3f pos;
    s32 ground_line_id;
    f32 dist_x;

    if ((fp->input.pl.stick_range.y <= FTCOMMON_DOKAN_STICK_RANGE_MIN) && (fp->tap_stick_y < FTCOMMON_DOKAN_BUFFER_FRAMES_MAX))
    {
        if ((fp->coll_data.ground_flags & ~MPCOLL_VERTEX_CLL_MASK) == mpCollision_Material_DokanLeft)
        {
            mpCollision_GetGPointIDsKind(0xA, &ground_line_id);
            mpCollision_GetGPointPositionsID(ground_line_id, &pos);

            if (pos.x < DObjGetStruct(fighter_gobj)->translate.vec.f.x)
            {
                dist_x = -(pos.x - DObjGetStruct(fighter_gobj)->translate.vec.f.x);
            }
            else dist_x = pos.x - DObjGetStruct(fighter_gobj)->translate.vec.f.x;

            if (dist_x <= FTCOMMON_DOKAN_DETECT_WIDTH)
            {
                ftCommon_DokanStart_SetStatus(fighter_gobj, mpCollision_Material_DokanLeft);

                return TRUE;
            }
        }
        else if ((fp->coll_data.ground_flags & ~MPCOLL_VERTEX_CLL_MASK) == mpCollision_Material_DokanRight)
        {
            mpCollision_GetGPointIDsKind(0xB, &ground_line_id);
            mpCollision_GetGPointPositionsID(ground_line_id, &pos);

            if (pos.x < DObjGetStruct(fighter_gobj)->translate.vec.f.x)
            {
                dist_x = -(pos.x - DObjGetStruct(fighter_gobj)->translate.vec.f.x);
            }
            else dist_x = pos.x - DObjGetStruct(fighter_gobj)->translate.vec.f.x;

            if (dist_x <= FTCOMMON_DOKAN_DETECT_WIDTH)
            {
                ftCommon_DokanStart_SetStatus(fighter_gobj, mpCollision_Material_DokanRight);

                return TRUE;
            }
        }
    }
    return FALSE;
}

// 0x801423B4
void ftCommon_DokanWait_ProcUpdate(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    fp->status_vars.common.dokan.pos_adjust_wait++;

    if (fp->status_vars.common.dokan.pos_adjust_wait == FTCOMMON_DOKAN_POS_ADJUST_WAIT)
    {
        if (fp->status_vars.common.dokan.wall_line_id == 0x14)
        {
            ftCommon_DokanEndWalk_SetStatus(fighter_gobj);
        }
        else ftCommon_DokanEnd_SetStatus(fighter_gobj);
    }
}

// 0x80142424
void ftCommon_DokanWait_ProcMap(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    DObjGetStruct(fighter_gobj)->translate.vec.f.x = func_8000CA28(0.033333335F, fp->status_vars.common.dokan.pos_adjust_wait, fp->status_vars.common.dokan.pos_current.x, fp->status_vars.common.dokan.pos_target.x, 0.0F, 0.0F);
    DObjGetStruct(fighter_gobj)->translate.vec.f.y = func_8000CA28(0.033333335F, fp->status_vars.common.dokan.pos_adjust_wait, fp->status_vars.common.dokan.pos_current.y, fp->status_vars.common.dokan.pos_target.y, 0.0F, 0.0F);
}

// 0x801424BC
void ftCommon_DokanWait_SetStatus(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);
    f32 pos_target_x;
    s32 wall_line_id;

    ftMap_SetAir(fp);
    ftStatus_Update(fighter_gobj, ftStatus_Common_DokanWait, 0.0F, 1.0F, FTSTATUPDATE_HITSTATUS_PRESERVE);

    fp->is_invisible = TRUE;
    fp->x18E_flag_b3 = TRUE;
    fp->is_playing_gfx = TRUE;

    fp->status_vars.common.dokan.pos_adjust_wait = 0;

    fp->x191_flag_b3 = TRUE;

    if (fp->status_vars.common.dokan.ground_material == mpCollision_Material_DokanLeft)
    {
        fp->status_vars.common.dokan.wall_line_id = 0xB;
    }
    else fp->status_vars.common.dokan.wall_line_id = 0xA;

    mpCollision_GetGPointIDsKind(fp->status_vars.common.dokan.wall_line_id, &wall_line_id);

    mpCollision_GetGPointPositionsID(wall_line_id, &fp->status_vars.common.dokan.pos_target);

    if (lbRandom_GetFloat() <= 0.25F)
    {
        fp->status_vars.common.dokan.wall_line_id = 0x14;

        mpCollision_GetGPointIDsKind(0x14, &wall_line_id);
        mpCollision_GetGPointPositionsID(wall_line_id, &fp->status_vars.common.dokan.pos_target);

        if (func_ovl2_800F9C30(&fp->status_vars.common.dokan.pos_target, 0, &pos_target_x, 0, 0) != FALSE)
        {
            fp->status_vars.common.dokan.pos_target.x += pos_target_x + fp->coll_data.object_coll.width;
        }
    }
}

// 0x801425E4
void ftCommon_DokanEnd_UpdateModelYaw(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    if (fighter_gobj->anim_frame >= FTCOMMON_DOKAN_EXIT_WAIT)
    {
        if (fp->status_vars.common.dokan.turn_stop_wait != 0)
        {
            fp->status_vars.common.dokan.turn_stop_wait--;

            fp->joint[ftParts_Joint_TopN]->rotate.vec.f.y += (FTCOMMON_DOKAN_TURN_STEP * fp->lr);

            func_ovl2_800EB528(fp->joint[ftParts_Joint_TopN]);
        }
    }
}

// 0x80142660
void ftCommon_DokanEnd_UpdateUnknown(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    if (fp->status_vars.common.dokan.set_unk_wait != 0)
    {
        fp->status_vars.common.dokan.set_unk_wait--;

        if (fp->status_vars.common.dokan.set_unk_wait == 0)
        {
            func_ovl2_800E7F7C(fighter_gobj, 1);
        }
    }
}

// 0x80142698
void ftCommon_DokanEnd_ProcUpdate(GObj *fighter_gobj)
{
    ftCommon_DokanEnd_UpdateUnknown(fighter_gobj);
    ftCommon_DokanEnd_UpdateModelYaw(fighter_gobj);
    ftAnim_IfAnimEnd_ProcStatus(fighter_gobj, func_ovl2_800DEE54);
}

// 0x801426D0
void ftCommon_DokanEnd_SetStatus(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    ftMap_SetGround(fp);
    ftStatus_Update(fighter_gobj, ftStatus_Common_DokanEnd, 0.0F, 1.0F, FTSTATUPDATE_HITSTATUS_PRESERVE);

    DObjGetStruct(fighter_gobj)->translate.vec.f = fp->status_vars.common.dokan.pos_target;

    func_ovl2_800F9348(&DObjGetStruct(fighter_gobj)->translate, &fp->coll_data.ground_line_id, &fp->coll_data.ground_dist, &fp->coll_data.ground_flags, &fp->coll_data.ground_angle);

    fp->x18F_flag_b4 = TRUE;
    fp->status_vars.common.dokan.set_unk_wait = FTCOMMON_DOKAN_UNK_WAIT;

    if ((fp->ft_kind != Ft_Kind_Mario) && (fp->ft_kind != Ft_Kind_MetalMario) && (fp->ft_kind != Ft_Kind_PolyMario) && (fp->ft_kind != Ft_Kind_Luigi) && (fp->ft_kind != Ft_Kind_PolyLuigi))
    {
        fp->status_vars.common.dokan.turn_stop_wait = FTCOMMON_DOKAN_TURN_STOP_WAIT_DEFAULT;
        fp->joint[ftParts_Joint_TopN]->rotate.vec.f.y = 0.0F;

        func_ovl2_800EB528(fp->joint[ftParts_Joint_TopN]);
    }
    else fp->status_vars.common.dokan.turn_stop_wait = 0;

    func_800269C0(0xD6U);
}

// 0x801427CC
void ftCommon_DokanEndWalk_SetStatus(GObj *fighter_gobj)
{
    ftStruct *fp = ftGetStruct(fighter_gobj);

    ftMap_SetAir(fp);

    fp->lr = LR_Right;

    ftStatus_Update(fighter_gobj, ftStatus_Common_DokanEndWalk, 0.0F, 1.0F, FTSTATUPDATE_HITSTATUS_PRESERVE);

    DObjGetStruct(fighter_gobj)->translate.vec.f = fp->status_vars.common.dokan.pos_target;

    fp->status_vars.common.dokan.set_unk_wait = FTCOMMON_DOKAN_UNK_WAIT;

    func_800269C0(0xD6U);
}