#ifndef _ITPORYGON_H_
#define _ITPORYGON_H_

#include <ssb_types.h>
#include <sys/objdef.h>
#include <it/itdef.h>

extern void itPorygonSDefaultUpdateHitParty(GObj *item_gobj);
extern sb32 itPorygonSDefaultProcUpdate(GObj *item_gobj);
extern GObj* itPorygonMakeItem(GObj *spawn_gobj, Vec3f *pos, Vec3f *vel, u32 flags);

#endif
