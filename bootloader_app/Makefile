################################################################################
# \file Makefile
# \version 1.0
#
# \brief
# Top-level application make file.
#
################################################################################
# \copyright
# $ Copyright 2020-YEAR Cypress Semiconductor Apache2 $
################################################################################

# Include the user configuration make file
include ../user_config.mk

################################################################################
# Basic Configuration
################################################################################

MTB_TYPE=PROJECT

# Name of application (used to derive name of final linked file).
APPNAME=bootloader_app

# If set to "true" or "1", display full command-lines when building.
VERBOSE=

################################################################################
# MCUboot Specific Configuration
################################################################################

.PHONY: generate_flashmap_bootloader

# Python command to generate flashmap header file from flashmap JSON file
PLATFORM=PSOC_061_512K
ifneq ($(FLASH_MAP), )
generate_flashmap_bootloader:
	@echo -e "\n============================================================="
	@echo -e "= Generating memorymap.h, memorymap.c and memorymap.mk ="
	@echo -e "============================================================="
	$(CY_PYTHON_PATH) ../scripts/memorymap_psoc6.py -p $(PLATFORM) -m -i ../flashmap/$(FLASH_MAP) -o ./source/memorymap.c -a ./source/memorymap.h > ./memorymap.mk
	@echo -e "=============================================================\n"
-include ./memorymap.mk
DEFINES+=CY_FLASH_MAP_JSON
endif

# Include the common library make file
include ../common_libs.mk

# Can be set at `MCUBOOT_LOG_LEVEL_DEBUG` to enable the verbose output of MCUBootApp.
MCUBOOT_LOG_LEVEL=MCUBOOT_LOG_LEVEL_INFO
USE_SHARED_SLOT=0
FIH_PROFILE_LEVEL_LIST:=OFF LOW MEDIUM HIGH
FIH_PROFILE_LEVEL?=MEDIUM

# Check FIH profile param
ifneq ($(filter $(FIH_PROFILE_LEVEL), $(FIH_PROFILE_LEVEL_LIST)),)
ifneq ($(FIH_PROFILE_LEVEL), OFF)
DEFINES+=MCUBOOT_FIH_PROFILE_ON
DEFINES+=MCUBOOT_FIH_PROFILE_$(FIH_PROFILE_LEVEL)
endif
else
$(error Wrong FIH_PROFILE_LEVEL param)
endif

# use USE_OVERWRITE = 1 for overwrite only mode
# use USE_OVERWRITE = 0 for swap upgrade mode
ifeq ($(USE_OVERWRITE), )
USE_OVERWRITE?=$(PLATFORM_DEFAULT_USE_OVERWRITE)
endif

# 1. Add defines to enable image overwrite operation
# 2. To enable downgrade prevention
# 3. To enable bootstarp
ifeq ($(USE_OVERWRITE), 1)
DEFINES+=MCUBOOT_OVERWRITE_ONLY
ifeq ($(USE_SW_DOWNGRADE_PREV), 1)
DEFINES+=MCUBOOT_DOWNGRADE_PREVENTION
endif
else
ifeq ($(USE_BOOTSTRAP), 1)
DEFINES+=MCUBOOT_BOOTSTRAP
endif
endif

# Add defines to enable usage of external flash for secondary or both images (XIP)
ifeq ($(USE_EXTERNAL_FLASH), 1)
ifeq ($(USE_XIP), 1)
DEFINES+=USE_XIP
endif
DEFINES+=CY_BOOT_USE_EXTERNAL_FLASH
DEFINES+=CY_MAX_EXT_FLASH_ERASE_SIZE=$(PLATFORM_CY_MAX_EXT_FLASH_ERASE_SIZE)
endif

# Below flag is automatically set/unset by memorymap.mk.
ifeq ($(USE_HW_ROLLBACK_PROT), 1)
DEFINES+=MCUBOOT_HW_ROLLBACK_PROT
endif

# Below flag is automatically set/unset by memorymap.mk.
ifeq ($(USE_MEASURED_BOOT), 1)
DEFINES+=MCUBOOT_MEASURED_BOOT
DEFINES+=MAX_BOOT_RECORD_SZ=512
DEFINES+=MCUBOOT_SHARED_DATA_BASE=0x08000800
DEFINES+=MCUBOOT_SHARED_DATA_SIZE=0x200
endif

# Below flag is automatically set/unset by memorymap.mk.
ifeq ($(USE_DATA_SHARING), 1)
DEFINES+=MCUBOOT_DATA_SHARING
DEFINES+=MAX_BOOT_RECORD_SZ=512
DEFINES+=MCUBOOT_SHARED_DATA_BASE=0x08000800
DEFINES+=MCUBOOT_SHARED_DATA_SIZE=0x200
endif

################################################################################
# MBEDTLS Files
################################################################################

MBEDTLS_PATH=$(MCUBOOT_PATH)/ext/mbedtls

SOURCES+=$(wildcard $(MBEDTLS_PATH)/library/*.c)

INCLUDES+=\
     $(MBEDTLS_PATH)/include\
     $(MBEDTLS_PATH)/include/mbedtls\
     $(MBEDTLS_PATH)/include/psa\
     $(MBEDTLS_PATH)/library

################################################################################
# Advanced Configuration
################################################################################

# Enable optional code that is ordinarily disabled by default.
#
# Available components depend on the specific targeted hardware and firmware
# in use. In general, if you have
#
#    COMPONENTS=foo bar
#
# ... then code in directories named COMPONENT_foo and COMPONENT_bar will be
# added to the build
#

# Do not define PSOC6HAL component as HAL is not supported for CM0+
COMPONENTS=

# Like COMPONENTS, but disable optional code that was enabled by default.
ifeq ($(FAMILY), PSOC6)
DISABLE_COMPONENTS=CM0P_SLEEP CM0P_SECURE CM0P_CRYPTO CM0P_BLESS
endif

# Set this application to run at the CM0+
CORE=CM4
CORE_NAME=CM4_0

SOURCES+=\
    $(wildcard $(MCUBOOT_PATH)/boot/bootutil/src/*.c)\
    $(MCUBOOTAPP_PATH)/keys.c

ifeq ($(USE_EXTERNAL_FLASH), 1)
SOURCES+=\
    $(MCUBOOTAPP_PATH)/cy_serial_flash_prog.c
endif

INCLUDES+=\
    $(MCUBOOT_PATH)/boot/bootutil/include/bootutil/crypto\
    $(MCUBOOTAPP_PATH)/os

# The following defines describe the flash map used by MCUBoot
DEFINES+=CY_BOOT_BOOTLOADER_SIZE=$(BOOTLOADER_SIZE)\
         CY_BOOT_SCRATCH_SIZE=$(MCUBOOT_SCRATCH_SIZE)\
         MCUBOOT_LOG_LEVEL=$(MCUBOOT_LOG_LEVEL)

# The following defines used by MCUBoot
DEFINES+=MBEDTLS_CONFIG_FILE='"mcuboot_crypto_config.h"'\
         ECC256_KEY_FILE='"$(SIGN_KEY_FILE).pub"'\
         MCUBOOT_IMAGE_NUMBER=$(MCUBOOT_IMAGE_NUMBER)\
         USE_SHARED_SLOT=$(USE_SHARED_SLOT)\
         MCUBOOT_PLATFORM_CHUNK_SIZE=$(PLATFORM_CHUNK_SIZE)\
         MEMORY_ALIGN=$(PLATFORM_MEMORY_ALIGN)\
         PLATFORM_MAX_TRAILER_PAGE_SIZE=$(PLATFORM_MAX_TRAILER_PAGE_SIZE)\
         MCUBOOT_MAX_IMG_SECTORS=$(MAX_IMG_SECTORS)\
         BOOT_$(CORE)\
         APP_$(CORE)\
         APP_CORE_ID=0\
         $(PLATFORM)\
         $(FAMILY)

# Select softfp or hardfp floating point. Default is softfp.
VFP_SELECT=hardfp

# Additional / custom C compiler flags.
#
# NOTE: Includes and defines should use the INCLUDES and DEFINES variable
# above.
CFLAGS=

# Additional / custom C++ compiler flags.
#
# NOTE: Includes and defines should use the INCLUDES and DEFINES variable
# above.
CXXFLAGS=

# Additional / custom assembler flags.
#
# NOTE: Includes and defines should use the INCLUDES and DEFINES variable
# above.
ASFLAGS=

# Toolchain specific linker flags
ifeq ($(TOOLCHAIN), GCC_ARM)
LINKER_SCRIPT=./linker/linker_bootloader.ld
else
$(error Only GCC_ARM is supported at this moment)
endif

# Additional / custom linker flags.
# Pass variables to linker script and overwrite path to it, if custom is required
LDFLAGS+=-Wl,--defsym,BOOTLOADER_FLASH_SIZE=$(BOOTLOADER_SIZE)
LDFLAGS+=-Wl,--defsym,BOOTLOADER_RAM_SIZE=$(BOOTLOADER_APP_RAM_SIZE)

# Additional / custom libraries to link in to the application.
LDLIBS=

# Custom pre-build commands to run.
# MCUboot uses submodules and "make getlibs" currently does not support
# fetching submodules.
# The PREBUILD command fetches the submodules only if the content of the
# "mcuboot/ext/mbedtls" directory is empty.
PREBUILD_VAR=+\
@if [ -n "$$(ls -A $(MBEDTLS_PATH) 2>/dev/null)" ]; then\
    echo "Git submodules for MCUboot exist. Skipping this step...";\
    else\
    echo "Initializing Git Submodules for MCUboot";\
    cd libs/mcuboot;git submodule update --init --recursive;\
fi;\
rm -f ./source/memorymap.c;\
rm -f ./source/memorymap.h;\
rm -f ./memorymap.mk;\
$(MAKE) generate_flashmap_bootloader;

PREBUILD=$(PREBUILD_VAR)

# Custom post-build commands to run.
POSTBUILD=

################################################################################
# Paths
################################################################################

# Relative path to the project directory (default is the Makefile's directory).
#
# This controls where automatic source code discovery looks for code.
CY_APP_PATH=

# Relative path to the shared repo location.
#
# All .mtb files have the format, <URI>#<COMMIT>#<LOCATION>. If the <LOCATION> field
# begins with $$ASSET_REPO$$, then the repo is deposited in the path specified by
# the CY_GETLIBS_SHARED_PATH variable. The default location is one directory level
# above the current app directory.
# This is used with CY_GETLIBS_SHARED_NAME variable, which specifies the directory name.
CY_GETLIBS_SHARED_PATH=../..

# Directory name of the shared repo location.
#
CY_GETLIBS_SHARED_NAME=mtb_shared

include $(CY_TOOLS_DIR)/make/start.mk
