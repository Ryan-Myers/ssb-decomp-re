#include "sys/om.h"

#include "sys/crash.h"
#include "sys/gtl.h"
#include "sys/obj_renderer.h"
#include "sys/rdp_reset.h"
#include "sys/system_03_1.h"

#include <sys/obj.h>

#include <macros.h>
#include <ssb_types.h>
#include <stddef.h>

#include <PR/mbi.h>
#include <PR/os.h>
#include <PR/sp.h>
#include <PR/ultratypes.h>

// TODOs:
// permutter on alloc_om_ etc functions

// structs
/// List that connects lists of stack nodes of `size` bytes
struct OMThreadStackList {
    /* 0x00 */ struct OMThreadStackList *next;
    /* 0x04 */ struct OMThreadStackNode *stack;
    /* 0x08 */ u32 size;
}; // size == 0x0C

// data

OSId sProcessThreadID = 10000000;

s32 D_8003B874 = 0;

Mtx6f D_8003B878 = { NULL, { 0.0F, 30.0F, 4.0F / 3.0F, 100.0F, 12800.0F, 1.0F } };

Mtx7f D_8003B894 = { NULL, { -160.0F, 160.0F, -120.0F, 120.0F, 100.0F, 12800.0F, 1.0F } };

CameraVec D_8003B8B4 = { NULL, { 0.0F, 0.0F, 1500.0F }, { 0.0F, 0.0F, 0.0F }, { 0.0F, 1.0F, 0.0F } };

OMMtxVec3 D_8003B8DC = { NULL, { 0.0F, 0.0F, 0.0F } };

OMMtxVec4 D_8003B8EC = { NULL, 0.0F, { 0.0F, 0.0F, 1.0F } };

OMMtxVec4 D_8003B900 = { NULL, 0.0F, { 0.0F, 0.0F, 0.0F } };

OMMtxVec3 D_8003B914 = { NULL, { 1.0F, 1.0F, 1.0F } };

// bss

GObjThread *sOMObjThreadHead;
u32 sOMObjThreadsActive;
u32 sThreadStacksActive;
u32 sThreadStackSize;
u32 sUnkUnusedSetup;
OMThreadStackList *sThreadStackHead;
void (*sOMObjProcessCallback)(GObjProcess*);
GObjProcess *sOMObjProcessHead;
GObjProcess *sObjProcessQueue[6];
u32 sOMObjProcessesActive;
GObj *gOMObjCommonLinks[OM_COMMON_MAX_LINKS];
GObj *sOMObjCommonLinks[OM_COMMON_MAX_LINKS];
GObj *sOMObjCommonHead;
GObj *gOMObjCommonDLLinks[OM_COMMON_MAX_DL_LINKS];
GObj *sOMObjCommonDLLinks[OM_COMMON_MAX_DL_LINKS];
s32 sOMObjCommonsActive;
u16 sObjCommonSize;
s16 sMaxNumObjCommon;
OMMtx *sOMMtxHead;
u32 sOMMtxActive;
void (*sDObjDataCleanup)(DObjDynamicStore*);
AObj *sAObjHead;
u32 sAObjsActive;
MObj *sMObjHead;
u32 sMObjsActive;

DObj *sDObjHead;
u32 sDObjsActive;
u16 sDObjSize;

SObj *sSObjHead;
u32 sSObjsActive;
u16 sSObjSize;

Camera *sCameraHead;
u32 sCamerasActive;
u16 sCameraSize;
struct GObjCommon *D_80046A54;
struct GObjCommon *D_80046A58;
struct GObjCommon *D_80046A5C;
GObjProcess *D_80046A60;
u32 D_80046A64;
OSMesg sOMMsg[1];
OSMesgQueue gOMMq;
// u8 D_80046A88[1280];
struct Unk80046A88 D_80046A88[64];
u8 D_80046F88[24];

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunknown-pragmas"

GObjThread* omGetGObjThread(void)
{
    GObjThread *gobjthread;

    if (sOMObjThreadHead == NULL) 
    {
        sOMObjThreadHead = hlMemoryAlloc(sizeof(GObjThread), 0x8);

        sOMObjThreadHead->next = NULL;
    }

    if (sOMObjThreadHead == NULL) 
    {
        gsFatalPrintF("om : couldn't get GObjThread\n");
        while (TRUE); // { }
    }

    gobjthread = sOMObjThreadHead;
    sOMObjThreadHead = sOMObjThreadHead->next;
    sOMObjThreadsActive++;

    return gobjthread;
}

void omSetGObjThreadPrevAlloc(GObjThread *gobjthread) 
{
    gobjthread->next = sOMObjThreadHead;
    sOMObjThreadHead = gobjthread;
    sOMObjThreadsActive--;
}

OMThreadStackNode* omGetStackOfSize(u32 size)
{
    OMThreadStackList *curr;
    OMThreadStackList *prev;
    OMThreadStackNode *ret;

    curr = sThreadStackHead;
    prev = NULL;

    while (curr != NULL) 
    {
        if (curr->size == size)
        {
            break;
        }
        prev = curr;
        curr = curr->next;
    }

    if (curr == NULL) 
    {
        curr        = hlMemoryAlloc(sizeof(OMThreadStackList), 4);
        curr->next  = NULL;
        curr->stack = NULL;
        curr->size  = size;

        if (prev != NULL) 
        {
            prev->next = curr;
        } 
        else sThreadStackHead = curr;
    }

    if (curr->stack != NULL) 
    {
        ret = curr->stack;

        curr->stack = curr->stack->next;
    } 
    else
    {
        ret = hlMemoryAlloc(size + offsetof(struct OMThreadStackNode, stack), 8);

        ret->stackSize = size;
    }

    ret->next = NULL;
    sThreadStacksActive++;
    return ret;
}

OMThreadStackNode* omGetDefaultStack(void)
{
    return omGetStackOfSize(sThreadStackSize);
}

void omEjectStackNode(OMThreadStackNode *node)
{
    OMThreadStackList *parent = sThreadStackHead;

    while (parent != NULL) 
    {
        if (parent->size == node->stack_size)
        { 
            break; 
        }
        parent = parent->next;
    }
    if (parent == NULL) 
    {
        gsFatalPrintF("om : Illegal GObjThreadStack Link\n");
        while (TRUE); // { }
    }

    node->next    = parent->stack;
    parent->stack = node;
    sThreadStacksActive--;
}

GObjProcess* omGetGObjProcess(void)
{
    GObjProcess *gobjproc;

    if (sOMObjProcessHead == NULL) 
    {
        sOMObjProcessHead = hlMemoryAlloc(sizeof(struct GObjProcess), 4);

        sOMObjProcessHead->unk00 = NULL;
    }

    if (sOMObjProcessHead == NULL) 
    {
        gsFatalPrintF("om : couldn't get GObjProcess\n");
        while (TRUE); // {}
    }

    gobjproc          = sOMObjProcessHead;
    sOMObjProcessHead = sOMObjProcessHead->unk_gobjproc_0x0;
    sOMObjProcessesActive++;

    return gobjproc;
}

// 0x80007680
void omLinkGObjProcess(GObjProcess *gobjproc)
{
    GObj *parent_gobj = gobjproc->parent_gobj;
    s32 link_id = gobjproc->parent_gobj->link_id;
    GObj *prev_gobj = gobjproc->parent_gobj;

    while (TRUE)
    {
        while (prev_gobj != NULL)
        {
            GObjProcess *prev_gobjproc = prev_gobj->gobjproc_prev;

            while (prev_gobjproc != NULL)
            {
                if (prev_gobjproc->priority == gobjproc->priority)
                {
                    gobjproc->unk_gobjproc_0x8 = prev_gobjproc->unk_gobjproc_0x8;
                    prev_gobjproc->unk_gobjproc_0x8 = gobjproc;
                    gobjproc->unk_gobjproc_0xC = prev_gobjproc;

                    goto loop_exit;
                }
                prev_gobjproc = prev_gobjproc->unk_gobjproc_0x4;
            }
            prev_gobj = prev_gobj->link_prev;
        }
        if (link_id != 0)
        {
            prev_gobj = sOMObjCommonLinks[--link_id];
        }
        else
        {
            gobjproc->unk_gobjproc_0x8 = sObjProcessQueue[gobjproc->priority];
            sObjProcessQueue[gobjproc->priority] = gobjproc;
            gobjproc->unk_gobjproc_0xC = NULL;
            break;
        }
    }
loop_exit:
    if (gobjproc->unk_gobjproc_0x8 != NULL)
    {
        gobjproc->unk_gobjproc_0x8->unk_gobjproc_0xC = gobjproc;
    }
    if (parent_gobj->gobjproc_prev != NULL)
    {
        parent_gobj->gobjproc_prev->unk_gobjproc_0x0 = gobjproc;
    }
    else parent_gobj->gobjproc_next = gobjproc;

    gobjproc->unk_gobjproc_0x4 = parent_gobj->gobjproc_prev;
    gobjproc->unk_gobjproc_0x0 = NULL;
    parent_gobj->gobjproc_prev = gobjproc;
}

// 0x80007758
void omSetGObjProcessPrevAlloc(GObjProcess *gobjproc)
{
    gobjproc->unk_gobjproc_0x0 = sOMObjProcessHead;
    sOMObjProcessHead = gobjproc;
    sOMObjProcessesActive--;
}

// 0x80007784
void func_80007784(GObjProcess *gobjproc) 
{
    if (gobjproc->unk_gobjproc_0xC != NULL) 
    {
        gobjproc->unk_gobjproc_0xC->unk_gobjproc_0x8 = gobjproc->unk_gobjproc_0x8;
    } 
    else sObjProcessQueue[gobjproc->priority] = gobjproc->unk_gobjproc_0x8;

    if (gobjproc->unk_gobjproc_0x8 != NULL)
    { 
        gobjproc->unk_gobjproc_0x8->unk_gobjproc_0xC = gobjproc->unk_gobjproc_0xC;
    }
}

// 0x800077D0
void func_800077D0(GObjProcess *gobjproc)
{
    GObj *gobj = gobjproc->parent_gobj;

    func_80007784(gobjproc);

    if (gobjproc->unk_gobjproc_0x4 != NULL) 
    {
        gobjproc->unk_gobjproc_0x4->unk_gobjproc_0x0 = gobjproc->unk_gobjproc_0x0;
    }
    else gobj->gobjproc_next = gobjproc->unk_gobjproc_0x0;
    
    if (gobjproc->unk_gobjproc_0x0 != NULL) 
    {
        gobjproc->unk_gobjproc_0x0->unk_gobjproc_0x4 = gobjproc->unk_gobjproc_0x4;
    }
    else gobj->gobjproc_prev = gobjproc->unk_gobjproc_0x4;
}

// 0x80007840
GObjProcess* unref_80007840(void) 
{
    return D_80046A60;
}

// 0x8000784C
u64* unref_8000784C(GObjProcess *gobjproc) 
{
    if (gobjproc == NULL) 
    {
        gobjproc = D_80046A60;
    }
    if ((gobjproc != NULL) && (gobjproc->kind == 0))
    { 
        return gobjproc->gobjthread->osstack;
    }
    else return NULL;
}

// 0x800007884
u32 unref_80007884(GObjProcess *gobjproc) 
{
    if (gobjproc == NULL) 
    { 
        gobjproc = D_80046A60; 
    }

    if ((gobjproc != NULL) && (gobjproc->kind == 0)) 
    {
        return gobjproc->gobjthread->stack_size;
    }
    else return 0;
}

// 0x800078BC
void unref_800078BC(void (*proc)(GObjProcess*))
{
    sOMObjProcessCallback = proc;
}

// 0x800078C8
s32 omGetGObjActiveCount(void)
{
    GObj *gobj = sOMObjCommonHead;
    s32 i                   = 0;

    while (gobj != NULL)
    {
        i++;
        gobj = gobj->link_next;
    }

    return i + sOMObjCommonsActive;
}

// 0x800078FC
GObj* omGetGObjSetNextAlloc(void) 
{
    GObj *gobj;

    if (sMaxNumObjCommon == -1 || sOMObjCommonsActive < sMaxNumObjCommon)
    {
        gobj = sOMObjCommonHead;

        if (gobj == NULL) 
        {
            sOMObjCommonHead = hlMemoryAlloc(sObjCommonSize, 0x8);
            sOMObjCommonHead->link_next = NULL;
            gobj = sOMObjCommonHead;
        }
    }
    else return NULL;

    if (gobj == NULL) 
    {
        return NULL;
    }

    sOMObjCommonHead = gobj->link_next;
    sOMObjCommonsActive++;

    return gobj;
}

// 0x800079A8
void omSetGObjPrevAlloc(GObj *gobj) 
{
    gobj->link_next = sOMObjCommonHead;
    sOMObjCommonHead = gobj;
    sOMObjCommonsActive--;
}

// 0x800079D4
void omAppendGObjToLinkedList(GObj *this_gobj, GObj *link_gobj)
{
    this_gobj->link_prev = link_gobj;

    if (link_gobj != NULL) 
    {
        this_gobj->link_next = link_gobj->link_next;
        link_gobj->link_next = this_gobj;
    } 
    else 
    {
        this_gobj->link_next = gOMObjCommonLinks[this_gobj->link_id];
        gOMObjCommonLinks[this_gobj->link_id] = this_gobj;
    }
    if (this_gobj->link_next != NULL) 
    {
        this_gobj->link_next->link_prev = this_gobj;
    } 
    else sOMObjCommonLinks[this_gobj->link_id] = this_gobj;
}

// 0x80007A3C
void omLinkGObjTail(GObj *this_gobj)
{
    GObj *current_gobj = sOMObjCommonLinks[this_gobj->link_id];

    while (current_gobj != NULL && current_gobj->link_order < this_gobj->link_order)
    {
        current_gobj = current_gobj->link_prev;
    }
    omAppendGObjToLinkedList(this_gobj, current_gobj);
}

// 0x80007AA8
void omLinkGObjHead(GObj *this_gobj)
{
    GObj *current_gobj = gOMObjCommonLinks[this_gobj->link_id];
    GObj *found_gobj;

    while (current_gobj != NULL && this_gobj->link_order < current_gobj->link_order)
    {
        current_gobj = current_gobj->link_next;
    }
    if (current_gobj != NULL)
    {
        found_gobj = current_gobj->link_prev;
    } 
    else found_gobj = sOMObjCommonLinks[this_gobj->link_id];
   
    omAppendGObjToLinkedList(this_gobj, found_gobj);
}

// 0x80007B30
void omRemoveGObjFromLinkedList(GObj *this_gobj)
{
    if (this_gobj->link_prev != NULL) 
    {
        this_gobj->link_prev->link_next = this_gobj->link_next;
    }
    else gOMObjCommonLinks[this_gobj->link_id] = this_gobj->link_next;
    
    if (this_gobj->link_next != NULL)
    {
        this_gobj->link_next->link_prev = this_gobj->link_prev;
    } 
    else sOMObjCommonLinks[this_gobj->link_id] = this_gobj->link_prev;
}

// 0x80007B98
void omAppendGObjToDLLinkedList(GObj *this_gobj, GObj *dl_link_gobj)
{
    this_gobj->dl_link_prev = dl_link_gobj;

    if (dl_link_gobj != NULL)
    {
        this_gobj->dl_link_next = dl_link_gobj->dl_link_next;
        dl_link_gobj->dl_link_next = this_gobj;
    } 
    else 
    {
        this_gobj->dl_link_next = gOMObjCommonDLLinks[this_gobj->dl_link_id];
        gOMObjCommonDLLinks[this_gobj->dl_link_id] = this_gobj;
    }

    if (this_gobj->dl_link_next != NULL)
    {
        this_gobj->dl_link_next->dl_link_prev = this_gobj;
    } 
    else sOMObjCommonDLLinks[this_gobj->dl_link_id] = this_gobj;
}

// 0x80007C00
void omDLLinkGObjTail(GObj *this_gobj) 
{
    GObj *current_gobj = sOMObjCommonDLLinks[this_gobj->dl_link_id];

    while (current_gobj != NULL && current_gobj->dl_link_order < this_gobj->dl_link_order)
    { 
        current_gobj = current_gobj->dl_link_prev;
    }
    omAppendGObjToDLLinkedList(this_gobj, current_gobj);
}

// 0x80007C6C
void omDLLinkGObjHead(GObj *this_gobj) 
{
    GObj *current_gobj = gOMObjCommonDLLinks[this_gobj->dl_link_id];
    GObj *found_gobj;

    while (current_gobj != NULL && this_gobj->dl_link_order < current_gobj->dl_link_order)
    { 
        current_gobj = current_gobj->dl_link_next;
    }
    if (current_gobj != NULL) 
    {
        found_gobj = current_gobj->dl_link_prev;
    }
    else found_gobj = sOMObjCommonDLLinks[this_gobj->dl_link_id];

    omAppendGObjToDLLinkedList(this_gobj, found_gobj);
}

// 0x80007CF4
void omRemoveGObjFromDLLinkedList(GObj *this_gobj)
{
    if (this_gobj->dl_link_prev != NULL) 
    {
        this_gobj->dl_link_prev->dl_link_next = this_gobj->dl_link_next;
    }
    else gOMObjCommonDLLinks[this_gobj->dl_link_id] = this_gobj->unk20;

    if (this_gobj->dl_link_next != NULL)
    {
        this_gobj->dl_link_next->dl_link_prev = this_gobj->dl_link_prev;
    }
    else sOMObjCommonDLLinks[this_gobj->dl_link_id] = this_gobj->dl_link_prev;
}

OMMtx* omGetOMMtxSetNextAlloc(void)
{
    OMMtx *ommtx;

    if (sOMMtxHead == NULL)
    {
        sOMMtxHead = hlMemoryAlloc(sizeof(OMMtx), 0x8);

        sOMMtxHead->next = NULL;
    }

    if (sOMMtxHead == NULL)
    {
        gsFatalPrintF("om : couldn't get OMMtx\n");
        while (TRUE); // {}
    }

    ommtx = sOMMtxHead;
    sOMMtxHead = sOMMtxHead->next;
    sOMMtxActive++;

    return ommtx;
}

// 0x80007DD8
void omSetOMMtxPrevAlloc(OMMtx *ommtx) 
{
    ommtx->next = sOMMtxHead;
    sOMMtxHead  = ommtx;
    sOMMtxActive--;
}

// 0x80007E04
AObj* omGetAObjSetNextAlloc(void) 
{
    AObj *aobj;

    if (sAObjHead == NULL) 
    {
        sAObjHead = hlMemoryAlloc(sizeof(AObj), 0x4);

        sAObjHead->next = NULL;
    }

    if (sAObjHead == NULL)
    {
        gsFatalPrintF("om : couldn't get AObj\n");
        while (TRUE); // {}
    }
    aobj = sAObjHead;
    sAObjHead = sAObjHead->next;
    sAObjsActive++;

    return aobj;
}

void omAppendAObjToDObj(DObj *dobj, AObj *aobj) 
{
    aobj->next  = dobj->aobj;
    dobj->aobj = aobj;
}

// 0x80007E90
void omAppendAObjToMObj(MObj *mobj, AObj *aobj)
{
    aobj->next  = mobj->aobj;
    mobj->aobj = aobj;
}

// 0x80007EA0
void omAppendAObjToCamera(Camera *cam, AObj *aobj)
{
    aobj->next = cam->aobj;
    cam->aobj = aobj;
}

void omSetAObjPrevAlloc(struct AObj *a) 
{
    a->next = sAObjHead;
    sAObjsActive--;
    sAObjHead = a;
}

MObj* omGetMObjSetNextAlloc(void) 
{
    MObj *mobj;

    if (sMObjHead == NULL)
    {
        sMObjHead = hlMemoryAlloc(sizeof(MObj), 0x4);

        sMObjHead->next = NULL;
    }

    if (sMObjHead == NULL) 
    {
        gsFatalPrintF("om : couldn't get MObj\n");
        while (TRUE); // {}
    }

    mobj = sMObjHead;
    sMObjHead = sMObjHead->next;
    sMObjsActive++;

    return mobj;
}

void omSetMObjPrevAlloc(MObj *mobj)
{
    mobj->next = sMObjHead;
    sMObjsActive--;
    sMObjHead = mobj;
}

DObj* omGetDObjSetNextAlloc(void)
{
    DObj *dobj;

    if (sDObjHead == NULL) 
    {
        sDObjHead = hlMemoryAlloc(sDObjSize, 0x8);

        sDObjHead->alloc_free = NULL;
    }

    if (sDObjHead == NULL)
    {
        gsFatalPrintF("om : couldn't get DObj\n");
        while (TRUE); // {}
    }

    dobj = sDObjHead;
    sDObjHead = sDObjHead->alloc_free;
    sDObjsActive++;

    return dobj;
}

void omSetDObjPrevAlloc(DObj *dobj) 
{
    dobj->alloc_free = sDObjHead;
    sDObjsActive--;
    sDObjHead = dobj;
}

SObj* omGetSObjSetNextAlloc(void) 
{
    SObj *sobj;

    if (sSObjHead == NULL) 
    {
        sSObjHead = hlMemoryAlloc(sSObjSize, 0x8);

        sSObjHead->alloc_free = NULL;
    }

    if (sSObjHead == NULL)
    {
        gsFatalPrintF("om : couldn't get SObj\n");
        while (TRUE); // {}
    }

    sobj = sSObjHead;
    sSObjHead = sSObjHead->alloc_free;
    sSObjsActive++;

    return sobj;
}

void omSetSObjPrevAlloc(SObj *sobj)
{
    sobj->alloc_free = sSObjHead;
    sSObjsActive--;
    sSObjHead = sobj;
}

Camera* omGetCameraSetNextAlloc(void)
{
    Camera *cam;

    if (sCameraHead == NULL) 
    {
        sCameraHead       = hlMemoryAlloc(sCameraSize, 0x8);
        sCameraHead->next = NULL;
    }

    if (sCameraHead == NULL) 
    {
        gsFatalPrintF("om : couldn't get Camera\n");
        while (TRUE); // {}
    }

    cam = sCameraHead;
    sCameraHead = sCameraHead->next;
    sCamerasActive++;

    return cam;
}

void omSetCameraPrevAlloc(Camera *cam) 
{
    cam->next = sCameraHead;
    sCamerasActive--;
    sCameraHead = cam;
}

GObjProcess* omAddGObjCommonProc(GObj *gobj, void (*proc)(GObj*), u8 kind, u32 priority)
{
    OMThreadStackNode *stack_node;
    GObjThread *gobjthread;
    GObjProcess *gobjproc;

    if (gobj == NULL)
    {
        gobj = D_80046A54;
    }
    gobjproc = omGetGObjProcess();

    if (priority >= 6)
    {
        gsFatalPrintF("om : GObjProcess's priority is bad value\n");
        while (TRUE); // {}
    }
    gobjproc->priority = priority;
    gobjproc->kind = kind;
    gobjproc->unk_gobjproc_0x15 = 0;
    gobjproc->parent_gobj = gobj;
    gobjproc->proc_common = proc;

    switch (kind)
    {
        case GObjProcess_Kind_OSThread:
        {
            gobjthread             = omGetGObjThread();
            gobjproc->gobjthread   = gobjthread;

            stack_node             = omGetDefaultStack();
            gobjthread->osstack    = stack_node->stack;
            gobjthread->stack_size = sThreadStackSize;

            osCreateThread
            (
                &gobjthread->osthread,
                sProcessThreadID++,
                proc,
                gobj,
                &thread->osStack[sThreadStackSize / sizeof(u64)],
                51
            );

            gobjthread->osstack[7] = 0xFEDCBA98;

            if (sProcessThreadID >= 20000000) 
            {
                sProcessThreadID = 10000000;
            }
            break;
        }
        case GObjProcess_Kind_Proc:
        {
            gobjproc->proc_thread = proc;
            break;
        }
        default:
        {
            gsFatalPrintF("om : GObjProcess's kind is bad value\n");
            while (TRUE); // {}
        }
    }
    omLinkGObjProcess(gobjproc);

    return gobjproc;
}

GObjProcess* unref_80008304
(
    GObj *gobj,
    void (*proc)(GObj*),
    u32 pri,
    s32 thread_id,
    u32 stack_size
)
{
    GObjProcess *gobjproc; // s0
    GObjThread *gobjthread;   // v1 / sp28
    OMThreadStackNode *stacknode;
    OSId tid;

    if (gobj == NULL)
    {
        gobj = D_80046A54;
    }

    gobjproc = omGetGObjProcess();

    if (pri >= 6) 
    {
        gsFatalPrintF("om : GObjProcess's priority is bad value\n");
        while (TRUE); // {}
    }

    gobjproc->priority = pri;
    gobjproc->unk_gobjproc_0x15 = 0;
    gobjproc->parent_gobj = gobj;
    gobjproc->proc_common = proc;

    gobjproc->gobjthread = gobjthread = omGetGObjThread();
    gobjproc->kind                    = GObjProcess_Kind_OSThread;

    stacknode              = stack_size == 0 ? omGetDefaultStack() : omGetStackOfSize(stack_size);
    gobjthread->osstack   = stacknode->stack;
    gobjthread->stack_size = stack_size == 0 ? sThreadStackSize : stack_size;
    tid                    = thread_id != -1 ? thread_id : sProcessThreadID++;

    osCreateThread(&gobjthread->osthread, tid, proc, gobj, &gobjthread->osstack[gobjthread->stack_size / sizeof(u64)], 51);

    gobjthread->osstack[7] = 0xFEDCBA98;

    if (sProcessThreadID >= 20000000) 
    {
        sProcessThreadID = 10000000; 
    }
    omLinkGObjProcess(gobjproc);
    return gobjproc;
}

void func_8000848C(GObjProcess *gobjproc)
{
    OMThreadStackNode *tnode;

    if ((gobjproc == NULL) || (gobjproc == D_80046A60))
    {
        D_80046A64 = 1;

        if (D_80046A60->kind == GObjProcess_Kind_OSThread)
        {
            gsStopCurrentProcess(1); 
        }
        return;
    }

    if (sOMObjProcessCallback != NULL)
    {
        sOMObjProcessCallback(gobjproc); 
    }

    switch (gobjproc->kind)
    {
    case GObjProcess_Kind_OSThread:
        osDestroyThread(&gobjproc->gobjthread->osthread);
        // cast from stack pointer back to stack node
        tnode = (void*)((uintptr_t)(gobjproc->gobjthread->osstack) - offsetof(OMThreadStackNode, stack));
        omEjectStackNode(tnode);
        omSetGObjThreadPrevAlloc(gobjproc->gobjthread);
        break;

    case GObjProcess_Kind_Proc:
        break;
    }

    func_800077D0(gobjproc);
    omSetGObjProcessPrevAlloc(gobjproc);
}

// 0x8000855C
OMMtx* omAddOMMtxForDObjVar(DObj *dobj, u8 kind, u8 arg2, s32 ommtx_id)
{
    uintptr_t csr;
    OMMtxVec3 *v3fi;
    OMMtxVec4 *v4f;
    OMMtxVec3 *v3f;
    OMMtx *ommtx;
    s32 i;

    if (dobj->ommtx_len == ARRAY_COUNT(dobj->ommtx))
    {
        gsFatalPrintF("om : couldn\'t add OMMtx for DObj\n");
        while (TRUE);
    }
    if (dobj->dynstore != NULL)
    {
        csr = (uintptr_t)dobj->dynstore->data;

        for (i = 0; i < ARRAY_COUNT(dobj->dynstore->kinds); i++)
        {
            switch (dobj->dynstore->kinds[i])
            {
            case OMMtxVec_Kind_None:
                break;

            case OMMtxVec_Kind_Vec3fi:
                v3fi = (OMMtxVec3*)csr;
                csr += sizeof(OMMtxVec3);
                break;

            case OMMtxVec_Kind_Vec4f:
                v4f = (OMMtxVec4*)csr;
                csr += sizeof(OMMtxVec4);
                break;

            case OMMtxVec_Kind_Vec3f:
                v3f = (OMMtxVec3*)csr;
                csr += sizeof(OMMtxVec3);
                break;
            }
        }
    }
    for (i = dobj->ommtx_len; i > ommtx_id; i--)
    {
        dobj->ommtx[i] = dobj->ommtx[i - 1];
    }
    dobj->ommtx_len++;

    dobj->ommtx[ommtx_id] = ommtx = omGetOMMtxSetNextAlloc();
    ommtx->kind = kind;

    switch (kind)
    {
    case 18:
    case 34:
    case 36:
    case 38:
    case 40:
    case 55:
        dobj->translate = D_8003B8DC;
        dobj->translate.mtx = ommtx;
        break;

    case 19:
    case 23:
        dobj->rotate = D_8003B8EC;
        dobj->rotate.mtx = ommtx;
        break;

    case 20:
    case 24:
        dobj->translate = D_8003B8DC;
        dobj->rotate = D_8003B8EC;
        dobj->translate.mtx = ommtx;
        dobj->rotate.mtx = ommtx;
        break;

    case 21:
    case 26:
    case 29:
        dobj->rotate = D_8003B900;
        dobj->rotate.mtx = ommtx;
        break;

    case 22:
    case 27:
    case 30:
    case 51:
    case 52:
        dobj->translate = D_8003B8DC;
        dobj->rotate = D_8003B900;
        dobj->translate.mtx = ommtx;
        dobj->rotate.mtx = ommtx;
        break;

    case 25:
        dobj->translate = D_8003B8DC;
        dobj->rotate = D_8003B8EC;
        dobj->scale = D_8003B914;
        dobj->translate.mtx = ommtx;
        dobj->rotate.mtx = ommtx;
        dobj->scale.mtx = ommtx;
        break;

    case 28:
    case 31:
    case 54:
        dobj->translate = D_8003B8DC;
        dobj->rotate = D_8003B900;
        dobj->scale = D_8003B914;
        dobj->translate.mtx = ommtx;
        dobj->rotate.mtx = ommtx;
        dobj->scale.mtx = ommtx;
        break;

    case 32:
    case 43:
    case 44:
    case 47:
    case 48:
    case 49:
    case 50:
    case 53:
        dobj->scale = D_8003B914;
        dobj->scale.mtx = ommtx;
        break;

    case 45:
    case 46:
        dobj->rotate = D_8003B8EC;
        dobj->scale = D_8003B914;
        dobj->rotate.mtx = ommtx;
        dobj->scale.mtx = ommtx;
        break;

    case 56:
        *v3fi = D_8003B8DC;
        v3fi->mtx = ommtx;
        break;

    case 57:
        *v4f = D_8003B8EC;
        v4f->mtx = ommtx;
        break;

    case 58:
        *v4f = D_8003B900;
        v4f->mtx = ommtx;
        break;

    case 59:
        *v3f = D_8003B914;
        v3f->mtx = ommtx;
        break;

    case 60:
        *v3fi = D_8003B8DC;
        *v4f = D_8003B8EC;

        v3fi->mtx = v4f->mtx = ommtx;
        break;

    case 61:
        *v3fi = D_8003B8DC;
        *v4f = D_8003B8EC;
        *v3f = D_8003B914;

        v3fi->mtx = v4f->mtx = v3f->mtx = ommtx;
        break;

    case 62:
        *v3fi = D_8003B8DC;
        *v4f = D_8003B900;

        v3fi->mtx = v4f->mtx = ommtx;
        break;

    case 63:
        *v3fi = D_8003B8DC;
        *v4f = D_8003B900;
        *v3f = D_8003B914;

        v3fi->mtx = v4f->mtx = v3f->mtx = ommtx;
        break;

    case 1:
    case 17:
        break;
    }
    ommtx->unk05 = arg2;

    return ommtx;
}

// This actually returns omAddOMMtxForDObjVar, see https://decomp.me/scratch/nIQ4X
OMMtx* omAddOMMtxForDObjFixed(DObj *dobj, u8 kind, u8 arg2)
{ 
    return omAddOMMtxForDObjVar(dobj, kind, arg2, dobj->ommtx_len);
}

// 0x80008CF0
OMMtx* omAddOMMtxForCamera(Camera *cam, u8 kind, u8 arg2) 
{
    OMMtx *ommtx;

    if (cam->ommtx_len == ARRAY_COUNT(cam->ommtx)) 
    {
        gsFatalPrintF("om : couldn't add OMMtx for Camera\n");
        while (TRUE); // {}
    }
    // L80008D2C
    ommtx = omGetOMMtxSetNextAlloc();

    cam->ommtx[cam->ommtx_len] = ommtx;
    cam->ommtx_len++;
    ommtx->kind = kind;

    switch (kind)
    {
        case 3:
        case 4:
            cam->projection.f6     = D_8003B878;
            cam->projection.f6.mtx = ommtx;
            break;

        case 5:
            cam->projection.f7     = D_8003B894;
            cam->projection.f7.mtx = ommtx;
            break;
        
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:
        case 13:
        case 14:
        case 15:
        case 16:
        case 17:
            cam->vec     = D_8003B8B4;
            cam->vec.mtx = ommtx;
            break;

        case 1:
        case 2:
            break;
    }

    ommtx->unk05 = arg2;
    return ommtx;
}

AObj* omAddAObjForDObj(DObj *dobj, u8 index)
{
    AObj *aobj = omGetAObjSetNextAlloc();

    aobj->unk_aobj_0x4 = index;
    aobj->unk_aobj_0x5 = 0;
    aobj->interpolate = NULL;
    aobj->unk_aobj_0x1C = 0.0F;
    aobj->unk_aobj_0x18 = 0.0F;
    aobj->unk_aobj_0x14 = 0.0F;
    aobj->unk_aobj_0x10 = 0.0F;
    aobj->unk_aobj_0xC = 0.0F;
    aobj->unk_aobj_0x8 = 1.0F;

    omAppendAObjToDObj(dobj, aobj);

    return aobj;
}

// 0x80008EE4
void omRemoveAObjFromDObj(DObj *dobj)
{
    AObj *current_aobj;
    AObj *next_aobj;

    current_aobj = dobj->aobj;

    while (current_aobj != NULL)
    {
        next_aobj = current_aobj->next;
        omSetAObjPrevAlloc(current_aobj);
        current_aobj = next_aobj;
    }
    dobj->aobj = NULL;
    dobj->dobj_f0 = AOBJ_FRAME_NULL;
}

AObj* omAddAObjForMObj(MObj *mobj, u8 index) 
{
    AObj *aobj = omGetAObjSetNextAlloc();

    aobj->unk_aobj_0x4 = index;
    aobj->unk_aobj_0x5 = 0;
    aobj->interpolate = NULL;
    aobj->unk_aobj_0x1C = 0.0F;
    aobj->unk_aobj_0x18 = 0.0F;
    aobj->unk_aobj_0x14 = 0.0F;
    aobj->unk_aobj_0x10 = 0.0F;
    aobj->unk_aobj_0xC = 0.0F;
    aobj->unk_aobj_0x8 = 1.0F;

    omAppendAObjToMObj(mobj, aobj);

    return aobj;
}

// free struct AObj list at unk90
void omRemoveAObjFromMObj(MObj *mobj)
{
    AObj *current_aobj;
    AObj *next_aobj;

    current_aobj = mobj->aobj;

    while (current_aobj != NULL)
    {
        next_aobj = current_aobj->next;
        omSetAObjPrevAlloc(current_aobj);
        current_aobj = next_aobj;
    }
    mobj->aobj = NULL;
    mobj->mobj_f0 = AOBJ_FRAME_NULL;
}

// 0x80009010
AObj* omAddAObjForCamera(Camera *cam, u8 index)
{
    AObj *aobj = omGetAObjSetNextAlloc();

    aobj->unk_aobj_0x4 = index;
    aobj->unk_aobj_0x5 = 0;
    aobj->interpolate = NULL;
    aobj->unk_aobj_0x1C = 0.0F;
    aobj->unk_aobj_0x18 = 0.0F;
    aobj->unk_aobj_0x14 = 0.0F;
    aobj->unk_aobj_0x10 = 0.0F;
    aobj->unk_aobj_0xC = 0.0F;
    aobj->unk_aobj_0x8 = 1.0F;

    omAppendAObjToCamera(cam, aobj);

    return aobj;
}

// 0x8000907C
void omRemoveAObjFromCamera(Camera *cam) 
{
    AObj *current_aobj;
    AObj *next_aobj;

    current_aobj = cam->aobj;

    while (current_aobj != NULL)
    {
        next_aobj = current_aobj->next;
        omSetAObjPrevAlloc(current_aobj);
        current_aobj = next_aobj;
    }
    cam->aobj = NULL;
    cam->cam_f0 = AOBJ_FRAME_NULL;
}

// 0x800090DC
MObj* omAddMObjForDObj(DObj *dobj, MObjSub *mobjsub)
{
    MObj *mobj = omGetMObjSetNextAlloc();

    if (dobj->mobj != NULL)
    {
        MObj *curr = dobj->mobj->next;
        MObj *prior = dobj->mobj;

        while (curr != NULL)
        {
            prior = curr;
            curr = curr->next;
        }
        prior->next = mobj;
    }
    else dobj->mobj = mobj;

    mobj->next = NULL;
    mobj->unk_mobj_0x84 = mobjsub->unkcolor1.r / 255.0F;
    mobj->sub = *mobjsub;

    mobj->sub.unk24 = mobjsub->unk14;
    mobj->sub.unk28 = mobjsub->unk1C;
    mobj->image_id = 0;
    mobj->unk_mobj_0x82 = 0;
    mobj->image_frame = 0;
    mobj->aobj = NULL;
    mobj->actor.p = NULL;
    mobj->mobj_f0 = AOBJ_FRAME_NULL;
    mobj->mobj_f1 = 1.0F;
    mobj->mobj_f2 = 0.0F;

    return mobj;
}

// 0x800091F4
void omRemoveMObjFromDObj(DObj *dobj)
{
    MObj *current_mobj;
    MObj *next_mobj;
    AObj *current_aobj;
    AObj *next_aobj;

    current_mobj = dobj->mobj;

    while (current_mobj != NULL) 
    {
        current_aobj = current_mobj->aobj;

        while (current_aobj != NULL)
        {
            next_aobj = current_aobj->next;
            omSetAObjPrevAlloc(current_aobj);
            current_aobj = next_aobj;
        }
        next_mobj = current_mobj->next;
        omSetMObjPrevAlloc(current_mobj);
        current_mobj = next_mobj;
    }
    dobj->mobj = NULL;
}

// 0x8000926C
void omInitDObj(DObj *dobj)
{
    s32 i;

    dobj->dynstore = NULL;
    dobj->flags = 0;
    dobj->unk_dobj_0x55 = 0;
    dobj->ommtx_len = 0;

    for (i = 0; i < ARRAY_COUNT(dobj->ommtx); i++)
    {
        dobj->ommtx[i] = NULL;
    }
    dobj->aobj = NULL;
    dobj->actor.p = NULL;
    dobj->dobj_f0 = AOBJ_FRAME_NULL;
    dobj->dobj_f1 = 1.0F;
    dobj->dobj_f2 = 0.0F;
    dobj->mobj = NULL;
    dobj->user_data.p = NULL;
}

// 0x800092D0
DObj* omAddDObjForGObj(GObj *gobj, void *dl)
{
    DObj *new_dobj;
    DObj *current_dobj;

    if (gobj == NULL)
    { 
        gobj = D_80046A54;
    }
    new_dobj = omGetDObjSetNextAlloc();

    if (gobj->obj != NULL)
    {
        current_dobj = DObjGetStruct(gobj);

        while (current_dobj->sib_next != NULL)
        {
            current_dobj = current_dobj->sib_next;
        }
        current_dobj->sib_next = new_dobj;
        new_dobj->sib_prev = current_dobj;
    } 
    else
    {
        gobj->obj_kind  = GObj_ObjKind_DObj;
        gobj->obj = new_dobj;
        new_dobj->sib_prev = NULL;
    }

    new_dobj->parent_gobj  = gobj;
    new_dobj->parent = DOBJ_PARENT_NULL;
    new_dobj->sib_next  = NULL;
    new_dobj->child = NULL;
    new_dobj->display_list = dl;

    omInitDObj(new_dobj);

    return new_dobj;
}

// 0x80009380
DObj* omAddSiblingForDObj(DObj *dobj, void *dl)
{
    DObj *new_dobj = omGetDObjSetNextAlloc();

    if (dobj->sib_next != NULL)
    { 
        dobj->sib_next->sib_prev = new_dobj;
    }
    new_dobj->sib_prev    = dobj;
    new_dobj->sib_next    = dobj->sib_next;
    dobj->sib_next        = new_dobj;
    new_dobj->parent_gobj = dobj->parent_gobj;
    new_dobj->parent      = dobj->parent;

    new_dobj->child = NULL;
    new_dobj->display_list = dl;

    omInitDObj(new_dobj);

    return new_dobj;
}

// 0x800093F4
DObj* omAddChildForDObj(DObj *dobj, void *dl)
{
    DObj *new_dobj = omGetDObjSetNextAlloc();
    DObj *current_dobj;

    if (dobj->child != NULL)
    {
        current_dobj = dobj->child;

        while (current_dobj->sib_next != NULL) 
        { 
            current_dobj = current_dobj->sib_next;
        }

        current_dobj->sib_next = new_dobj;
        new_dobj->sib_prev = current_dobj;
    }
    else 
    {
        dobj->child = new_dobj;
        new_dobj->sib_prev = NULL;
    }

    new_dobj->parent_gobj = dobj->parent_gobj;
    new_dobj->parent = dobj;
    new_dobj->child = NULL;
    new_dobj->sib_next  = NULL;
    new_dobj->display_list = dl;

    omInitDObj(new_dobj);

    return new_dobj;
}

// drop_dobj, cleanup_dobj, omSetDObjPrevAlloc?
void omEjectDObj(DObj *dobj)
{
    s32 i;
    AObj *current_aobj;
    AObj *next_aobj;
    MObj *current_mobj;
    MObj *next_mobj;

    while (dobj->child != NULL)
    { 
        omEjectDObj(dobj->child);
    }
    if ((uintptr_t)dobj->unk14 == 1) 
    {
        if (dobj == DObjGetStruct(dobj->parent_gobj)) 
        {
            dobj->parent_gobj->obj = dobj->sib_next;

            if (DObjGetStruct(dobj->parent_gobj) == NULL)
            { 
                dobj->parent_gobj->obj_kind = GObj_ObjKind_None;
            }
        }
    } 
    else if (dobj == dobj->parent->child)
    {
        dobj->parent->child = dobj->sib_next;
    }

    if (dobj->sib_prev != NULL) 
    {
        dobj->sib_prev->sib_next = dobj->sib_next;
    }

    if (dobj->sib_next != NULL) 
    { 
        dobj->sib_next->sib_prev = dobj->sib_prev;
    }

    for (i = 0; i < ARRAY_COUNT(dobj->ommtx); i++) 
    {
        if (dobj->ommtx[i] != NULL)
        { 
            omSetOMMtxPrevAlloc(dobj->ommtx[i]); 
        }
    }

    if ((dobj->dynstore != NULL) && (sDObjDataCleanup != NULL))
    {
        sDObjDataCleanup(dobj->dynstore);
    }
    current_aobj = dobj->aobj;

    while (current_aobj != NULL) 
    {
        next_aobj = current_aobj->next;
        omSetAObjPrevAlloc(current_aobj);
        current_aobj = next_aobj;
    }

    // Why not just call omRemoveMObjFromDObj?
    current_mobj = dobj->mobj;

    while (current_mobj != NULL) 
    {
        current_aobj = current_mobj->aobj;

        while (current_aobj != NULL) 
        {
            next_aobj = current_aobj->next;
            omSetAObjPrevAlloc(current_aobj);
            current_aobj = next_aobj;
        }
        next_mobj = current_mobj->next;
        omSetMObjPrevAlloc(current_mobj);
        current_mobj = next_mobj;
    }

    omSetDObjPrevAlloc(dobj);
}

// 0x80009614
SObj* omAddSObjForGObj(GObj *gobj, Sprite *sprite)
{
    SObj *new_sobj;

    if (gobj == NULL)
    { 
        gobj = D_80046A54;
    }
    new_sobj = omGetSObjSetNextAlloc();

    if (SObjGetStruct(gobj) != NULL)
    {
        SObj *tail_sobj = SObjGetStruct(gobj);

        while (tail_sobj->next != NULL) 
        { 
            tail_sobj = tail_sobj->next; 
        }
        tail_sobj->next = new_sobj;
        new_sobj->prev = tail_sobj;
    } 
    else
    {
        gobj->obj_kind = GObj_ObjKind_SObj;
        gobj->obj = new_sobj;
        new_sobj->prev = NULL;
    }
    new_sobj->parent_gobj = gobj;
    new_sobj->next = NULL;

    if (sprite != NULL)
    {
        new_sobj->sprite = *sprite; 
    }
    new_sobj->user_data.p = NULL;

    return new_sobj;
}

// 0x800096EC
void omEjectSObj(SObj *sobj) 
{
    if (sobj == SObjGetStruct(sobj->parent_gobj))
    {
        sobj->parent_gobj->obj = sobj->next;

        if (SObjGetStruct(sobj->parent_gobj) == NULL)
        { 
            sobj->parent_gobj->obj_kind = GObj_ObjKind_None;
        }
    }
    if (sobj->prev != NULL)
    {
        sobj->prev->next = sobj->next;
    }
    if (sobj->next != NULL)
    { 
        sobj->next->prev = sobj->prev;
    }
    omSetSObjPrevAlloc(sobj);
}

// 0x80009760
Camera* omAddCameraForGObj(GObj *gobj)
{
    s32 i;
    Camera *new_cam;

    if (gobj == NULL)
    {
        gobj = D_80046A54;
    }
    gobj->obj_kind = GObj_ObjKind_Camera;

    new_cam = omGetCameraSetNextAlloc();
    gobj->obj = new_cam;
    new_cam->parent_gobj = gobj;

    setup_viewport(&new_cam->viewport);

    new_cam->ommtx_len = 0;

    for (i = 0; i < ARRAY_COUNT(new_cam->ommtx); i++)
    { 
        new_cam->ommtx[i] = NULL;
    }
    new_cam->flags = 0;
    new_cam->color = GPACK_RGBA8888(0x00, 0x00, 0x00, 0x00);
    new_cam->proc_camera = NULL;
    new_cam->unk_camera_0x8C = 0;

    new_cam->aobj = NULL;
    new_cam->actor.p = NULL;

    new_cam->cam_f0 = AOBJ_FRAME_NULL;
    new_cam->cam_f1 = 1.0F;
    new_cam->cam_f2 = 0.0F;

    return new_cam;
}

// 0x80009810
void omEjectCamera(Camera *cam) 
{
    GObj *gobj;
    s32 i;
    AObj *current_aobj;
    AObj *next_aobj;

    gobj = cam->parent_gobj;
    gobj->obj_kind = GObj_ObjKind_None;
    gobj->obj = NULL;

    for (i = 0; i < ARRAY_COUNT(cam->ommtx); i++) 
    {
        if (cam->ommtx[i] != NULL)
        {
            omSetOMMtxPrevAlloc(cam->ommtx[i]);
        }
    }
    current_aobj = cam->aobj;

    while (current_aobj != NULL)
    {
        next_aobj = current_aobj->next;
        omSetAObjPrevAlloc(current_aobj);
        current_aobj = next_aobj;
    }
    omSetCameraPrevAlloc(cam);
}

GObj* omInitGObjCommon(u32 id, void (*proc_eject)(GObj*), u8 link, u32 order)
{
    GObj *new_gobj;

    if (link >= ARRAY_COUNT(gOMObjCommonLinks)) 
    {
        gsFatalPrintF("omGAddCommon() : link num over : link = %d : id = %d\n", link, id);
        while (TRUE) { }
    }

    new_gobj = omGetGObjSetNextAlloc();

    if (new_gobj == NULL)
    { 
        return NULL;
    }

    new_gobj->gobj_id = id;
    new_gobj->link_id = link;
    new_gobj->link_order = order;
    new_gobj->proc_eject = proc_eject;
    new_gobj->gobjproc_next = NULL;
    new_gobj->gobjproc_prev = NULL;
    new_gobj->unk_gobj_0x70 = 0;
    new_gobj->obj_renderflags = GOBJ_RENDERFLAG_NONE;

    new_gobj->obj_kind = GObj_ObjKind_None;
    new_gobj->obj = NULL;

    new_gobj->dl_link_id = ARRAY_COUNT(gOMObjCommonDLLinks);
    new_gobj->anim_frame = 0.0F;
    new_gobj->dobjproc = NULL;
    new_gobj->user_data.p = NULL;

    return com;
}

// from 64remix: render.create_object
GObj* omMakeGObjCommon(u32 id, void (*proc_eject)(GObj*), u8 link, u32 order)
{
    GObj *new_gobj = omInitGObjCommon(id, proc_eject, link, order);

    if (new_gobj == NULL)
    {
        return NULL; 
    }
    omLinkGObjTail(new_gobj);

    return new_gobj;
}

// 0x800099A8
GObj* func_800099A8(u32 id, void (*proc_eject)(GObj*), u8 link, u32 order)
{
    GObj *new_gobj = omInitGObjCommon(id, proc_eject, link, order);

    if (new_gobj == NULL)
    {
        return NULL;
    }
    omLinkGObjHead(new_gobj);

    return new_gobj;
}

// 0x800099E8
GObj* unref_800099E8(u32 id, void (*proc_eject)(GObj*), GObj *link_gobj) 
{
    GObj *new_gobj = omInitGObjCommon(id, proc_eject, link_gobj->link_id, link_gobj->link_order);

    if (new_gobj == NULL)
    {
        return NULL; 
    }
    omAppendGObjToLinkedList(new_gobj, link_gobj);

    return new_gobj;
}

// 0x80009A34
GObj* unref_80009A34(u32 id, void (*proc_eject)(GObj *), GObj *link_gobj)
{
    GObj *new_gobj = omInitGObjCommon(id, proc_eject, link_gobj->link_id, link_gobj->link_order);

    if (new_gobj == NULL)
    {
        return NULL;
    }
    omAppendGObjToLinkedList(new_gobj, link_gobj->link_prev);

    return new_gobj;
}

void omEjectGObjCommon(GObj *gobj)
{
    if (gobj == NULL || gobj == D_80046A54) 
    {
        D_80046A64 = 2;
        return;
    }

    func_8000B39C(gobj);

    switch (gobj->obj_kind)
    {
    case GObj_ObjKind_DObj:
        func_8000B70C(gobj); 
        break;

    case GObj_ObjKind_SObj:
        func_8000B760(gobj); 
        break;

    case GObj_ObjKind_Camera:
        omEjectCamera(CameraGetStruct(gobj));
        break;
    }

    if (gobj->dl_link_id != ARRAY_COUNT(gOMObjCommonDLLinks))
    { 
        omRemoveGObjFromDLLinkedList(gobj); 
    }
    omRemoveGObjFromLinkedList(gobj);
    omSetGObjPrevAlloc(gobj);
}

void omMoveGObjCommon(s32 sw, GObj *this_gobj, u8 link, u32 order, GObj *other_gobj)
{
    GObjProcess *current_gobjproc;
    GObjProcess *orig_gobjproc;
    GObjProcess *next_gobjproc;

    if (link >= ARRAY_COUNT(gOMObjCommonLinks))
    {
        gsFatalPrintF("omGMoveCommon() : link num over : link = %d : id = %d\n", link, this_gobj->gobj_id);

        while (TRUE); // {}
    }

    if (this_gobj == NULL) 
    {
        this_gobj = D_80046A54; 
    }

    orig_gobjproc = this_gobj->gobjproc_next;

    this_gobj->gobjproc_next = NULL;
    this_gobj->gobjproc_prev = NULL;

    current_gobjproc = orig_gobjproc;

    while (current_gobjproc != NULL)
    {
        func_80007784(current_gobjproc);
        current_gobjproc = current_gobjproc->unk_gobjproc_0x0;
    }
    omRemoveGObjFromLinkedList(this_gobj);

    this_gobj->link_id = link;
    this_gobj->link_order = order;

    switch (sw)
    {
    case 0:
        omLinkGObjTail(this_gobj);
        break;

    case 1:
        omLinkGObjHead(this_gobj);
        break;

    case 2:
        omAppendGObjToLinkedList(this_gobj, other_gobj);
        break;

    case 3:
        omAppendGObjToLinkedList(this_gobj, other_gobj->link_prev);
        break;
    }

    current_gobjproc = orig_gobjproc;

    while (current_gobjproc != NULL)
    {
        next_gobjproc = current_gobjproc->unk_gobjproc_0x0;
        omLinkGObjProcess(current_gobjproc);
        current_gobjproc = next_gobjproc;
    }
}

// 0x80009C90
void func_80009C90(GObj *gobj, u8 link, u32 order)
{
    omMoveGObjCommon(0, gobj, link, order, NULL);
}

// 0x80009CC8
void func_80009CC8(GObj *gobj, u8 link, u32 order)
{
    omMoveGObjCommon(1, gobj, link, order, NULL);
}

// 0x80009D00
void unref_80009D00(GObj *this_gobj, GObj *other_gobj) 
{
    omMoveGObjCommon(2, this_gobj, other_gobj->link_id, other_gobj->link_order, other_gobj);
}

// 0x80009D3C
void unref_80009D3C(GObj *this_gobj, GObj *other_gobj) 
{
    omMoveGObjCommon(3, this_gobj, other_gobj->link_id, other_gobj->link_order, other_gobj);
}

void omLinkGObjDLCommon(GObj *gobj, void (*proc_render)(GObj*), u8 dl_link, u32 dl_order, s32 arg4) 
{
    if (dl_link >= ARRAY_COUNT(gOMObjCommonDLLinks) - 1)
    {
        gsFatalPrintF("omGLinkObjDLCommon() : dl_link num over : dl_link = %d : id = %d\n", dl_link, gobj->gobj_id);
        while (TRUE); // {}
    }

    gobj->dl_link_id = dl_link;
    gobj->dl_link_order = dl_order;
    gobj->proc_render = proc_render;
    gobj->unk_gobj_0x38 = arg4;
    gobj->unk_gobj_0xE = D_8003B6E8.word - 1;
}

void omAddGObjRenderProc(GObj *gobj, void (*proc_render)(GObj*), u8 dl_link, u32 order, s32 arg4) 
{
    if (gobj == NULL)
    { 
        gobj = D_80046A54;
    }
    omLinkGObjDLCommon(gobj, proc_render, dl_link, order, arg4);
    omDLLinkGObjTail(gobj);
}

void unref_80009E38(GObj *gobj, void (*proc_render)(GObj*), u8 dl_link, u32 order, s32 arg4)
{
    if (gobj == NULL)
    { 
        gobj = D_80046A54;
    }
    omLinkGObjDLCommon(gobj, proc_render, dl_link, order, arg4);
    omDLLinkGObjHead(gobj);
}

void unref_80009E7C(GObj *this_gobj, void (*proc_render)(GObj*), s32 arg2, GObj *other_gobj) 
{
    if (this_gobj == NULL)
    { 
        this_gobj = D_80046A54;
    }
    omLinkGObjDLCommon(this_gobj, proc_render, other_gobj->dl_link_id, other_gobj->dl_link_order, arg2);
    omAppendGObjToDLLinkedList(this_gobj, other_gobj);
}

void unref_80009ED0(GObj *this_gobj, void (*proc_render)(GObj*), s32 arg2, GObj *other_gobj)
{
    if (this_gobj == NULL)
    {
        this_gobj = D_80046A54;
    }
    omLinkGObjDLCommon(this_gobj, proc_render, other_gobj->dl_link_id, other_gobj->dl_link_order, arg2);
    omAppendGObjToDLLinkedList(this_gobj, other_gobj->link_prev);
}

// 0x80009F28
void func_80009F28(GObj *gobj, void (*proc_render)(GObj*), u32 order, u64 arg3, s32 arg4) 
{
    gobj->dl_link_id = ARRAY_COUNT(gOMObjCommonDLLinks) - 1;
    gobj->dl_link_order = order;
    gobj->proc_render = proc_render;
    gobj->unk_gobj_0x30 = arg3;
    gobj->unk_gobj_0x38 = arg4;
    gobj->unk_gobj_0x40 = 0;
    gobj->unk_gobj_0xE = D_8003B6E8.word - 1;
}

// 0x80009F74
void func_80009F74(GObj *gobj, void (*proc_render)(GObj*), u32 order, u64 arg3, s32 arg4) 
{
    if (gobj == NULL)
    { 
        gobj = D_80046A54;
    }
    func_80009F28(gobj, proc_render, order, arg3, arg4);
    omDLLinkGObjTail(gobj);
}

// 0x80009FC0
void unref_80009FC0(GObj *gobj, void (*proc_render)(GObj *), u32 order, u64 arg3, s32 arg4)
{
    if (gobj == NULL)
    {
        gobj = D_80046A54;
    }
    func_80009F28(gobj, proc_render, order, arg3, arg4);
    omDLLinkGObjHead(gobj);
}

// 0x8000A00C
void unref_8000A00C(GObj *this_gobj, void (*proc_render)(GObj*), u64 arg2, s32 arg3, GObj *other_gobj) 
{
    if (this_gobj == NULL) 
    {
        this_gobj = D_80046A54;
    }
    func_80009F28(this_gobj, proc_render, other_gobj->dl_link_order, arg2, arg3);
    omAppendGObjToDLLinkedList(this_gobj, other_gobj);
}

// 0x8000A06C
void unref_8000A06C(GObj *this_gobj, void (*proc_render)(GObj*), u64 arg2, s32 arg3, GObj *other_gobj)
{
    if (this_gobj == NULL)
    {
        this_gobj = D_80046A54;
    }
    func_80009F28(this_gobj, proc_render, other_gobj->dl_link_order, arg2, arg3);
    omAppendGObjToDLLinkedList(this_gobj, other_gobj->link_prev);
}

// 0x8000A0D0
void omMoveGObjDL(GObj *gobj, u8 dl_link, u32 order)
{
    if (dl_link >= ARRAY_COUNT(gOMObjCommonDLLinks) - 1) 
    {
        gsFatalPrintF("omGMoveObjDL() : dl_link num over : dl_link = %d : id = %d\n", dl_link, gobj->gobj_id);
        while (TRUE); // {}
    }
    omRemoveGObjFromDLLinkedList(gobj);

    gobj->dl_link_id = dl_link;
    gobj->dl_link_order = order;

    omDLLinkGObjTail(gobj);
}

void omMoveGObjDLHead(GObj *gobj, u8 dl_link, u32 order)
{
    if (dl_link >= ARRAY_COUNT(gOMObjCommonDLLinks) - 1)
    {
        gsFatalPrintF("omGMoveObjDLHead() : dl_link num over : dl_link = %d : id = %d\n", dl_link, gobj->gobj_id);
        while (TRUE); // {}
    }
    omRemoveGObjFromDLLinkedList(gobj);

    gobj->dl_link_id = dl_link;
    gobj->dl_link_order = order;

    omDLLinkGObjHead(gobj);
}

void unref_8000A1C8(struct GObjCommon *arg0, struct GObjCommon *arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk0D = arg1->unk0D;
    arg0->unk28 = arg1->unk28;
    omAppendGObjToDLLinkedList(arg0, arg1);
}

void unref_8000A208(struct GObjCommon *arg0, struct GObjCommon *arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk0D = arg1->unk0D;
    arg0->unk28 = arg1->unk28;
    omAppendGObjToDLLinkedList(arg0, arg1->unk24);
}

void func_8000A24C(struct GObjCommon *arg0, u32 arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk28 = arg1;
    omDLLinkGObjTail(arg0);
}

void unref_8000A280(struct GObjCommon *arg0, u32 arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk28 = arg1;
    omDLLinkGObjHead(arg0);
}

void func_8000A2B4(struct GObjCommon *arg0, struct GObjCommon *arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk28 = arg1->unk28;
    omAppendGObjToDLLinkedList(arg0, arg1);
}

void unref_8000A2EC(struct GObjCommon *arg0, struct GObjCommon *arg1) {
    omRemoveGObjFromDLLinkedList(arg0);
    arg0->unk28 = arg1->unk28;
    omAppendGObjToDLLinkedList(arg0, arg1->unk08);
}

void set_max_obj_commons(s32 n) {
    sMaxNumObjCommon = n;
}

s16 get_max_obj_commons(void) {
    return sMaxNumObjCommon;
}

void func_8000A340(void) {
    s32 i;
    s32 v1;
    struct GObjCommon *s0;

    D_80046A58 = NULL;
    D_80046A5C = NULL;

    // clang-format off
    for (i = 0, v1 = D_8003B6E8.word - 1; i < ARRAY_COUNT(D_80046A88); i++) { 
        D_80046A88[i].unk00 = v1; 
    }
    // clang-format on

    s0 = gOMObjCommonDLLinks[OM_COMMON_MAX_DL_LINKS - 1];
    while (s0 != NULL) {
        if (!(s0->unk7C & 1)) {
            D_8003B874 = 3;
            D_80046A58 = s0;
            s0->unk2C(s0);
            D_8003B874 = 0;
        }
        s0 = s0->unk20;
    }
}

struct GObjCommon *func_8000A40C(struct GObjCommon *arg0) {
    struct GObjCommon *ret;

    D_8003B874 = 1;
    D_80046A54 = arg0;
    arg0->unk14(arg0);
    ret        = arg0->unk04;
    D_80046A54 = NULL;
    D_8003B874 = 0;

    switch (D_80046A64) {
        case 0: break;
        case 2:
            D_80046A64 = 0;
            omEjectGObjCommon(arg0);
            break;
        default: D_80046A64 = 0; break;
    }

    return ret;
}

struct GObjProcess *func_8000A49C(struct GObjProcess *proc) {
    struct GObjProcess *ret;

    D_8003B874 = 2;
    D_80046A54 = proc->unk18;
    D_80046A60 = proc;

    switch (proc->unk14) {
        case 0:
        {
            osStartThread(&proc->unk1C.thread->osThread);
            osRecvMesg(&gOMMq, NULL, OS_MESG_BLOCK);
            break;
        }
        case 1:
        {
            proc->unk1C.cb(proc->unk18);
            break;
        }
    }

    ret = proc->unk08;

    D_80046A54 = NULL;
    D_80046A60 = NULL;
    D_8003B874 = 0;

    switch (D_80046A64) {
        case 2:
        {
            D_80046A64 = 0;
            while (ret != NULL && ret->unk18 == proc->unk18) { ret = ret->unk08; }

            omEjectGObjCommon(proc->unk18);
            break;
        }
        case 1:
        {
            D_80046A64 = 0;
            func_8000848C(proc);
            break;
        }
        case 0: break;
        default: D_80046A64 = 0; break;
    }

    return ret;
}

void func_8000A5E4(void) {
    s32 i;
    struct GObjCommon *comm;
    struct GObjProcess *proc;

    D_80046A64 = 0;
    D_80046A54 = NULL;
    D_80046A60 = NULL;

    for (i = 0; i < OM_COMMON_MAX_LINKS; i++) {
        comm = gOMObjCommonLinks[i];
        while (comm != NULL) {
            if (!(comm->unk7C & 0x40) && comm->unk14 != NULL) {
                comm = func_8000A40C(comm);
            } else {
                comm = comm->unk04;
            }
        }
    }

    for (i = ARRAY_COUNT(sObjProcessQueue) - 1; i >= 0; i--) {
        proc = sObjProcessQueue[i];
        while (proc != NULL) {
            if (proc->unk15 == 0) {
                proc = func_8000A49C(proc);
            } else {
                proc = proc->unk08;
            }
        }
    }
}

void set_up_object_manager(struct OMSetup *setup) {
    s32 i;

    sThreadStackSize = setup->threadStackSize;
    sUnkUnusedSetup  = setup->unk14;

    if (setup->numThreads != 0) {
        struct GObjThread *csr;
        sOMObjThreadHead = csr = setup->threads;

        for (i = 0; i < setup->numThreads - 1; i++) {
            struct GObjThread *next = csr + 1;

            csr->next = next;
            csr       = next;
        }
        csr->next = NULL;
    } else {
        sOMObjThreadHead = NULL;
    }

    if (setup->numStacks != 0 && setup->threadStackSize != NULL) 
    {
        struct OMThreadStackNode *csr;

        sThreadStackHead        = hlMemoryAlloc(sizeof(struct OMThreadStackList), 4);
        sThreadStackHead->next  = NULL;
        sThreadStackHead->size  = sThreadStackSize;
        sThreadStackHead->stack = csr = setup->stacks;

        for (i = 0; (u32)i < setup->numStacks - 1; i++) {
            csr->next =
                (void
                     *)((uintptr_t)csr + sThreadStackSize + offsetof(struct OMThreadStackNode, stack));
            csr->stackSize = sThreadStackSize;
            csr =
                (void
                     *)((uintptr_t)csr + sThreadStackSize + offsetof(struct OMThreadStackNode, stack));
        }

        csr->stackSize = sThreadStackSize;
        csr->next      = NULL;
    } else {
        sThreadStackHead = NULL;
    }

    if (setup->numProcesses != 0) {
        struct GObjProcess *csr;
        sOMObjProcessHead = csr = setup->processes;

        for (i = 0; i < setup->numProcesses - 1; i++) {
            struct GObjProcess *next = csr + 1;

            csr->unk00 = next;
            csr        = next;
        }

        csr->unk00 = NULL;
    } else {
        sOMObjProcessHead = NULL;
    }

    for (i = 0; i < ARRAY_COUNT(sObjProcessQueue); i++) { sObjProcessQueue[i] = NULL; }

    if (setup->numCommons != 0) {
        struct GObjCommon *csr;
        sOMObjCommonHead = csr = setup->commons;

        // todo: is this the purest form?
        for (i = 0; i < setup->numCommons - 1; i++) {
            csr->unk04 = (void *)((uintptr_t)csr + setup->commonSize);
            csr        = csr->unk04;
        }
        csr->unk04 = NULL;

    } else {
        sOMObjCommonHead = NULL;
    }

    sObjCommonSize   = setup->commonSize;
    sMaxNumObjCommon = -1;
    sDObjDataCleanup = setup->cleanupFn;

    if (setup->numMatrices != 0) {
        struct OMMtx *csr;

        sOMMtxHead = csr = setup->matrices;

        for (i = 0; i < setup->numMatrices - 1; i++) {
            struct OMMtx *next = csr + 1;

            csr->next = next;
            csr       = next;
        }
        csr->next = NULL;
    } else {
        sOMMtxHead = NULL;
    }

    if (setup->numAObjs != 0) {
        struct AObj *csr;

        sAObjHead = csr = setup->aobjs;

        for (i = 0; i < setup->numAObjs - 1; i++) {
            struct AObj *next = csr + 1;

            csr->next = next;
            csr       = next;
        }
        csr->next = NULL;
    } else {
        sAObjHead = NULL;
    }

    if (setup->numMObjs != 0) {
        struct MObj *csr;

        sMObjHead = csr = setup->mobjs;

        for (i = 0; i < setup->numMObjs - 1; i++) {
            struct MObj *next = csr + 1;

            csr->next = next;
            csr       = next;
        }
        csr->next = NULL;

    } else {
        sMObjHead = NULL;
    }

    if (setup->numDObjs != 0) {
        struct DObj *csr;
        sDObjHead = csr = setup->dobjs;

        for (i = 0; i < setup->numDObjs - 1; i++) {
            csr->unk0 = (void *)((uintptr_t)csr + setup->dobjSize);
            csr       = csr->unk0;
        }

        csr->unk0 = NULL;
    } else {
        sDObjHead = NULL;
    }
    sDObjSize = setup->dobjSize;

    if (setup->numSObjs != 0) {
        struct SObj *csr;
        sSObjHead = csr = setup->sobjs;

        for (i = 0; i < setup->numSObjs - 1; i++) {
            csr->next = (void *)((uintptr_t)csr + setup->sobjSize);
            csr       = csr->next;
        }

        csr->next = NULL;
    } else {
        sSObjHead = NULL;
    }
    sSObjSize = setup->sobjSize;

    if (setup->numCameras != 0) {
        struct Camera *csr;
        sCameraHead = csr = setup->cameras;

        for (i = 0; i < setup->numCameras - 1; i++) {
            csr->next = (void *)((uintptr_t)csr + setup->cameraSize);
            csr       = csr->next;
        }

        csr->next = NULL;
    } else {
        sCameraHead = NULL;
    }
    // L8000ABA0
    sCameraSize = setup->cameraSize;

    for (i = 0; i < OM_COMMON_MAX_LINKS; i++) {
        sOMObjCommonLinks[i] = NULL;
        gOMObjCommonLinks[i]      = NULL;
    }

    for (i = 0; i < OM_COMMON_MAX_DL_LINKS; i++) {
        sOMObjCommonDLLinks[i] = NULL;
        gOMObjCommonDLLinks[i]   = NULL;
    }

    func_80014430();
    osCreateMesgQueue(&gOMMq, sOMMsg, ARRAY_COUNT(sOMMsg));

    sThreadStacksActive = sOMObjThreadsActive = sOMObjProcessesActive = sOMObjCommonsActive =
        sOMMtxActive = sAObjsActive = sDObjsActive = sSObjsActive = sCamerasActive = 0;

    sOMObjProcessCallback = NULL;
    func_80017830(0);
    D_8003B874 = 0;
}
