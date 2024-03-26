#include <sys/develop.h>
// #include <ft/ftdef.h>
// #include <ft/fighter.h>
#include <gm/battle.h>
#include <gr/ground.h>
#include <ovl0/reloc_data_mgr.h>
#include <results.h>

// ovl30 stuff
// extern RldmFileId D_ovl30_801344D0[5];

// extern intptr_t dMnStageBackgroundFileOffsets[9]; //0x8013452C
// extern rdFileNode dMnStageTrainingBackgroundFileNodes[3]; // 0x80134550
// extern s32 dMnStageTrainingBackgroundIDs[10]; // 0x80134568

// extern Lights1 D_ovl30_80134590 = gdSPDefLights1(0x20, 0x20, 0x20, 0xFF, 0xFF, 0xFF, 0x14, 0x14, 0x14); // 20202000 20202000 FFFFFF00 FFFFFF00 14141400 00000000
// extern Gfx D_ovl30_801345A8[/* */] =
// {
//     gsSPSetGeometryMode(G_LIGHTING),
//     gsSPSetLights1(D_ovl30_80134590),
//     gsSPEndDisplayList()
// };

// extern intptr_t dMnStageChrOffsets[29]; // 0x801345D0[29]

// extern s32 dMnStageIDOrder[10]; // 0x80134644[10];
// extern intptr_t dMnStageImageOffsets[10]; // 0x8013466C[10]
// extern Vec2f dMnStageNamePositions[9]; // 0x80134694[9];
// extern intptr_t dMnStageNameImageOffsets[9]; // 0x801346DC[9];
// extern Vec2f dMnStageLogoPositions[10]; // 0x801347E4[10]
// extern Vec2f dMnStageLogoOffsets[9]; // 0x80134834[9]
// extern f32 dMnStagePreviewScale[9]; // 0x80134858[9]
// extern Vec2f dMnStagePreviewTranslations[9]; // 0x8013487C[9]

// extern scUnkDataBounds D_ovl30_8013490C;
// extern scRuntimeInfo D_ovl30_80134928;

// extern s32 D_ovl30_801348E8[9]; // unused, probably stage_ids

// extern s32 gMnStageCursorSlotId; // 0x80134BD8
// extern GObj* gMnStageCursorGobj; // 0x80134BDC
// extern GObj* gMnStageNameLogoGobj; // 0x80134BE0
// extern GObj* gMnStageHeap0BackgroundGobj; // 0x80134BE4
// extern GObj* gMnStageHeap1BackgroundGobj; // 0x80134BE8
// extern GObj* gMnStageHeap0StageInfoArray[4]; // 0x80134BF0
// extern GObj* gMnStageHeap1StageInfoArray[4]; // 0x80134C00
// extern gmGroundInfo* gMnStageGroundInfo; // 0x80134C10
// extern Camera* gMnStagePreviewCam; // 0x80134C14;
// extern sb32 gMnStageIsTrainingMode; // 0x80134C18
// extern u8 gMnStageUnlockedMask; // 0x80134C1C; // flag indicating which bonus features are available
// extern s32 gMnStageCurrentHeap; // 0x80134C20

// extern s32 gMnStageFramesElapsed; // 0x80134C24; // frames elapsed on SSS
// extern s32 gMnStageScrollBuffer; // 0x80134C28; // frames until can move cursor again
// extern s32 gMnStageMaxFramesElapsed; // 0x80134C2C // frames to wait until exiting the SSS

// extern uintptr_t gMnStageModelHeap0Ptr; // 80134E24;
// extern uintptr_t gMnStageModelHeap1Ptr; // 80134E28;

// extern rdFileNode D_ovl30_80134D20;
// extern u32 D_ovl30_80134C30[240];
// extern uintptr_t D_NF_001AC870;
// extern uintptr_t D_NF_00000854;

// extern s32 gMnStageFilesArray[5]; // 0x80134E10[5]
// // // extern s32 gFile014; // 0x80134E10; // file 0x014 pointer
// // // extern s32 gFile015; // 0x80134E14; // file 0x015 pointer
// // // extern s32 gFile01E; // 0x80134E18; // file 0x01E pointer
// // // extern s32 gFile021; // 0x80134E1C; // file 0x021 pointer
// // // extern s32 gFile01A; // 0x80134E20; // file 0x01A pointer

// // // // Offsets
// extern intptr_t FILE_015_BACKGROUND_IMAGE_OFFSET = 0x440; // file 0x015 image offset for background tile

// extern intptr_t FILE_01A_TRAINING_BACKGROUND_IMAGE_OFFSET = 0x20718; // also file 0x1B and 0x1C

// extern intptr_t FILE_01E_CURSOR_IMAGE_OFFSET = 0x1AB8; // file 0x1E image offset for cursor
// extern intptr_t FILE_01E_SMASH_LOGO_IMAGE_OFFSET = 0x1DD8; // file 0x1E image offset for Smash logo
// extern intptr_t FILE_01E_STAGE_SELECT_IMAGE_OFFSET = 0x26A0; // file 0x1E image offset for wooden circle
// extern intptr_t FILE_01E_WOODEN_CIRCLE_IMAGE_OFFSET = 0x3840; // file 0x1E image offset for wooden circle
// extern intptr_t FILE_01E_YELLOW_OVAL_RIGHT_IMAGE_OFFSET = 0x3C68; // file 0x1E image offset for yellow oval right edge
// extern intptr_t FILE_01E_YELLOW_OVAL_CENTER_IMAGE_OFFSET = 0x3D68; // file 0x1E image offset for yellow oval center
// extern intptr_t FILE_01E_YELLOW_OVAL_LEFT_IMAGE_OFFSET = 0x3FA8; // file 0x1E image offset for yellow oval left edge
// extern intptr_t FILE_01E_STAGE_PREVIEW_PATTERNED_BG_IMAGE_OFFSET = 0xC728; // file 0x1E image offset for patterned stage preview bg texture
// extern intptr_t FILE_01E_RANDOM_IMAGE_OFFSET = 0xCB10; // file 0x1E image offset for Random stage image
// extern intptr_t FILE_01E_RANDOM_STAGE_PREVIEW_BG_IMAGE_OFFSET = 0xDE30; // file 0x1E image offset for Random stage image

// 0x80131B20
void mnResultsSetupDisplayList(Gfx **display_list)
{
    gSPSetGeometryMode(display_list[0]++, G_LIGHTING);
    ftRender_Lights_DisplayLightReflect(display_list, func_ovl1_8039051C(), func_ovl1_80390528());
}

// 0x80131B78
s32 mnResultsGetPlayerCount()
{
    return D_800A4D08.pl_count + D_800A4D08.cp_count;
}

// 0x80131B90
void mnResultsSaveDataToSRAM()
{
    struct gmSaveVSRecord* vs_record;
    s32 i, j;
    u8 ft_kind, opp_ft_kind;

    gSaveData.vsgame_total += 1;
    gSaveData.unlock_task_inishie |= 1 << D_800A4D08.gr_kind;

    if (gSaveData.unlock_task_itemswitch < 0xFF)
    {
        gSaveData.unlock_task_itemswitch += 1;
    }

    for (i = 0; i < 4; i++)
    {
        if (D_800A4D08.player_block[i].player_kind != 2)
        {
            ft_kind = D_800A4D08.player_block[i].character_kind;
            vs_record = &gSaveData.vs_records[ft_kind];

            vs_record->time_used += (D_800A4D08.match_time_current / 60);

            if (vs_record->time_used >= I_MIN_TO_FRAMES(1000))
            {
                vs_record->time_used = I_MIN_TO_FRAMES(1000) - 1;
            }

            vs_record->damage_dealt += D_800A4D08.player_block[i].total_damage_dealt;

            if (vs_record->damage_dealt >= 1000000)
            {
                vs_record->damage_dealt = 999999;
            }

            vs_record->damage_taken += D_800A4D08.player_block[i].total_damage_all;

            if (vs_record->damage_taken >= 1000000)
            {
                vs_record->damage_taken = 999999;
            }

            vs_record->self_destructs += D_800A4D08.player_block[i].total_self_destruct;

            if (vs_record->self_destructs >= 10000)
            {
                vs_record->self_destructs = 9999;
            }

            vs_record->games_played += 1;
            vs_record->player_count_tally += mnResultsGetPlayerCount();

            for (j = 0; j < 4; j++)
            {
                if ((i != j) && (D_800A4D08.player_block[j].player_kind != Pl_Kind_Not))
                {
                    opp_ft_kind = D_800A4D08.player_block[j].character_kind;

                    gSaveData.vs_records[ft_kind].ko_count[opp_ft_kind] += D_800A4D08.player_block[i].total_ko_player[j];
                    if (gSaveData.vs_records[ft_kind].ko_count[opp_ft_kind] >= 10000)
                    {
                        gSaveData.vs_records[ft_kind].ko_count[opp_ft_kind] = 9999;
                    }

                    gSaveData.vs_records[ft_kind].player_count_tallies[opp_ft_kind] += mnResultsGetPlayerCount();
                    gSaveData.vs_records[ft_kind].played_against[opp_ft_kind] += 1;
                }
            }
        }
    }

    lbMemory_SaveData_WriteSRAM();
}

// func_ovl31_80131E18

// func_ovl31_80131EB0

// func_ovl31_8013205C

// func_ovl31_801320B8

// func_ovl31_80132100

// func_ovl31_801321AC

// func_ovl31_8013234C

// func_ovl31_80132A2C

// func_ovl31_80132A68

// func_ovl31_80132B20

// func_ovl31_80132D84

// func_ovl31_80132EA8

// func_ovl31_80133134

// func_ovl31_80133148

// func_ovl31_8013315C

// func_ovl31_801331DC

// func_ovl31_801333E4

// func_ovl31_8013345C

// func_ovl31_801334CC

// func_ovl31_801334DC

// func_ovl31_80133684

// func_ovl31_80133718

// func_ovl31_80133810

// func_ovl31_801338EC

// func_ovl31_8013392C

// func_ovl31_801339F4

// func_ovl31_80133C58

// func_ovl31_80133E7C

// func_ovl31_80133F1C

// func_ovl31_80133F6C

// func_ovl31_8013423C

// func_ovl31_80134364

// func_ovl31_8013438C

// func_ovl31_80134480

// func_ovl31_80134540

// func_ovl31_8013457C

// func_ovl31_801345E8

// func_ovl31_80134688

// func_ovl31_801346C0

// func_ovl31_80134718

// func_ovl31_80134770

// func_ovl31_80134808

// func_ovl31_801348F8

// func_ovl31_80134AC4

// func_ovl31_80134C5C

// func_ovl31_80134DA0

// func_ovl31_80134DF4

// func_ovl31_80134E94

// func_ovl31_80134FD0

// func_ovl31_80135028

// func_ovl31_801350C8

// func_ovl31_80135204

// func_ovl31_8013525C

// func_ovl31_801352FC

// func_ovl31_801353F4

// func_ovl31_80135468

// func_ovl31_8013549C

// func_ovl31_80135670

// func_ovl31_8013569C

// func_ovl31_801358C4

// func_ovl31_801358F0

// func_ovl31_80135B78

// func_ovl31_80135D58

// func_ovl31_80135DB8

// func_ovl31_80135DCC

// func_ovl31_80135FF0

// func_ovl31_8013607C

// func_ovl31_80136100

// func_ovl31_801365B4

// func_ovl31_801365C0

// func_ovl31_801366F0

// func_ovl31_80136830

// func_ovl31_801368D0

// func_ovl31_801369B4

// func_ovl31_80136A9C

// func_ovl31_80136B1C

// func_ovl31_80136B9C

// func_ovl31_80136C08

// func_ovl31_80136C2C

// func_ovl31_80136D28

// func_ovl31_80136FB8

// func_ovl31_80137068

// func_ovl31_80137108

// func_ovl31_801371B8

// func_ovl31_801372F4

// func_ovl31_80137334

// func_ovl31_801373B4

// func_ovl31_80137454

// func_ovl31_801374F4

// func_ovl31_801375AC

// func_ovl31_80137698

// func_ovl31_801377C0

// func_ovl31_80137854

// func_ovl31_80137898

// func_ovl31_80137938

// func_ovl31_8013797C

// func_ovl31_801379C4

// func_ovl31_80137A1C

// func_ovl31_80137E34

// func_ovl31_80138130

// func_ovl31_80138548

// func_ovl31_801386BC

// func_ovl31_80138714

// func_ovl31_80138830

// func_ovl31_801388AC

// func_ovl31_80138B70

// vs_results_entry