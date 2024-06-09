#ifndef _FTMANAGER_H_
#define _FTMANAGER_H_

#include "ftdef.h"
#include <ssb_types.h>
#include <sys/objdef.h>

void func_ovl2_800D6FE0();
void ftManagerAllocFighter(u32 data_flags, s32 alloc_count);
ftStruct* ftManagerGetStructSetNextAlloc();
void ftManager_SetPrevAlloc(ftStruct* fp);
ftParts* ftManager_GetFighterPartsSetNextAlloc();
void ftManager_SetFighterPartsPrevAlloc(ftParts* ft_parts);
void ftManagerSetupDataMain(s32 ft_kind);
void func_ovl2_800D7710(s32 ft_kind);
void ftManagerSetupDataPlayables();
void ftManagerSetupDataKind(s32 ft_kind);
void* ftManagerAllocAnimHeapKind(s32 ft_kind);
void func_ovl2_800D78E8(GObj* fighter_gobj);
void func_ovl2_800D7994(GObj* fighter_gobj);
void func_ovl2_800D79F0(GObj* fighter_gobj, ftCreateDesc* spawn);
GObj* ftManagerMakeFighter(ftCreateDesc* spawn);

#endif
