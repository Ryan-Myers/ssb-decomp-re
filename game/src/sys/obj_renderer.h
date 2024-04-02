#ifndef SYS_OBJ_RENDERER_H
#define SYS_OBJ_RENDERER_H

#include "objtypes.h"

extern Gfx *gDisplayListHead[4];

#define hlMtxStoreGbi(mtx_store, mtx_heap) \
(mtx_store.gbi = mtx_heap.ptr, mtx_heap.ptr = (Mtx*)mtx_heap.ptr + 1) \

// should be a concrete pointer type
struct MtxProcTemp 
{
    s32(*unk00)();
    s32(*unk04)();
};

// gbi Mtx * ? pointer to some sort of matrix
extern Mtx *D_80046FA0;
extern f32 gSpriteLayerScale;
extern Mtx44f D_80046FA8;
extern struct MtxProcTemp *D_800470AC;

extern s32 odRenderDObjMain(Gfx **dl, DObj *dobj);
extern void odRenderMObjForDObj(DObj *dobj, Gfx **dl_head);
extern void odRenderDObjForGObj(GObj *gobj, Gfx **dl_head);
extern void odRenderDObjDLHead0(GObj *gobj);
extern void odRenderDObjDLHead1(GObj *gobj);
extern void unref_80013EB0(GObj *gobj);
extern void unref_80013ED4(GObj *gobj);
extern void odRenderDObjTree(DObj *this_dobj);
extern void odRenderDObjTreeForGObj(GObj *gobj);
extern void odRenderDObjDLLinks(DObj *dobj, DObjDLLink *dl_link);
extern void odRenderDObjDLLinksForGObj(GObj *gobj);
extern void func_80014430(void);
extern void odRenderDObjTreeDLLinks(DObj *dobj);
extern void odRenderDObjTreeDLLinksForGObj(GObj *gobj);
extern f32 odGetDObjDistFromEye(DObj *dobj);
extern void odRenderDObjTreeMultiList(DObj *dobj);
extern void unref_800147E0(GObj *gobj);
extern void unref_80014A84(GObj *gobj);
extern void unref_80014C38(GObj *gobj);
extern void func_80014CD0(DObj *dobj);
extern void unref_80014FFC(GObj *gobj);
extern void odRenderDObjTreeDLArray(DObj *dobj);
extern void unref_800154F0(GObj *gobj);
extern void odRenderDObjTreeMultiList(DObj *dobj);
extern void unref_80015860(GObj *gobj);
extern void odRenderDObjTreeDLDoubleArray(DObj *dobj);
extern void unref_80015A58(GObj *gobj);
extern void func_80015C0C(DObj *dobj);
extern void unref_80015F6C(GObj *gobj);
extern void unref_800162C8(GObj *gobj);
extern void func_80016338(Gfx **dls, Camera *cam, s32 arg2);
extern void func_8001663C(Gfx **dls, Camera *cam, s32 arg2);
extern void unref_80016AE4(Gfx **dls, Camera *cam, s32 arg2, void *image, s32 max_lrx, s32 max_lry, void *depth);
extern void odRenderCameraMain(Gfx **dls, Camera *cam);
extern void func_80017830(s32 val);
extern void func_8001783C(Camera *cam, s32 arg);
extern void func_80017868(GObj *this_gobj, s32 link_id, s32 arg2);
extern void func_80017978(GObj *gobj, s32 index, s32 arg2);
extern void func_80017AAC(s32 index);
extern void func_80017B80(GObj *gobj, s32 arg1);
extern void func_80017CC8(Camera *cam);
extern void func_80017D3C(GObj *gobj, Gfx **dls, s32 index);
extern void func_80017DBC(GObj *gobj);
extern void unref_80017DE4(GObj *gobj);
extern void unref_80017E0C(GObj *gobj);
extern void unref_80017E34(GObj *gobj);
extern void unref_80017E5C(void);
extern void func_80017EC0(GObj *gobj);
extern void unref_8001810C(void);
extern void func_80018300(GObj *gobj);

#endif /* SYS_OBJ_RENDERER_H */
