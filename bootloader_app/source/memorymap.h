#ifndef MEMORYMAP_H
#define MEMORYMAP_H

/* AUTO-GENERATED FILE, DO NOT EDIT. ALL CHANGES WILL BE LOST! */
#include "flash_map_backend.h"

extern struct flash_area flash_areas[];
extern struct flash_area *boot_area_descs[];
#define FLASH_AREA_BOOTLOADER          ( 0u)

#define FLASH_AREA_IMG_1_PRIMARY       ( 1u)
#define FLASH_AREA_IMG_1_SECONDARY     ( 2u)

#define FLASH_AREA_IMAGE_SCRATCH       ( 3u)
#define FLASH_AREA_IMAGE_SWAP_STATUS   ( 7u)

#endif /* MEMORYMAP_H */