#ifndef _MNDEF_H_
#define _MNDEF_H_

typedef enum mnSoundTestOptions
{
    mnSoundTest_Option_Start,
    mnSoundTest_Option_Music = mnSoundTest_Option_Start,
    mnSoundTest_Option_Sound,
    mnSoundTest_Option_Voice,
    mnSoundTest_Option_End = mnSoundTest_Option_Voice,

    mnSoundTest_Option_EnumMax

} mnSoundTestOptions;

typedef enum mnDataOptions
{
    mnData_Option_Start,
    mnData_Option_Characters = mnData_Option_Start,
    mnData_Option_VSRecord,
    mnData_Option_SoundTest,
    mnData_Option_End = mnData_Option_SoundTest,

    mnData_Option_EnumMax

} mnDataOptions;

typedef enum mnOptionOptions
{
    mnOption_Option_Start,
    mnOption_Option_Sound = mnOption_Option_Start,
    mnOption_Option_ScreenAdjust,
    mnOption_Option_BackupClear,
    mnOption_Option_End = mnOption_Option_BackupClear,

    mnOption_Option_EnumMax

} mnOptionOptions;

typedef enum mnOptionTabStatus
{
    mnOptionTab_Status_Not,
    mnOptionTab_Status_Highlight,
    mnOptionTab_Status_Selected,
    mnOptionTab_Status_EnumMax

} mnOptionTabStatus;

typedef struct mnCongraFile             mnCongraFile;

#endif