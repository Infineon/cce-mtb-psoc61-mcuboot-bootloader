#include "./source/memorymap.h"
#include "flash_map_backend.h"

#include "flash_map_backend_platform.h"

struct flash_area flash_areas[] = {
    {
        .fa_id        = FLASH_AREA_BOOTLOADER,
        .fa_device_id = FLASH_DEVICE_INTERNAL_FLASH,
        .fa_off       = 0x0U,
        .fa_size      = 0x18000U
    },
    {
        .fa_id        = FLASH_AREA_IMG_1_PRIMARY,
        .fa_device_id = FLASH_DEVICE_INTERNAL_FLASH,
        .fa_off       = 0x18000U,
        .fa_size      = 0x10000U
    },
    {
        .fa_id        = FLASH_AREA_IMG_1_SECONDARY,
        .fa_device_id = FLASH_DEVICE_INTERNAL_FLASH,
        .fa_off       = 0x28000U,
        .fa_size      = 0x10000U
    }
};

struct flash_area *boot_area_descs[] = {
    &flash_areas[0U],
    &flash_areas[1U],
    &flash_areas[2U],
    NULL
};
