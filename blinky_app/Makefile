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
#
# If APPNAME is edited, ensure to update or regenerate launch
# configurations for your IDE.
APPNAME=blinky_app

# If set to "true" or "1", display full command-lines when building.
VERBOSE=

################################################################################
# MCUboot Specific Configuration
###############################################################################

.PHONY: generate_flashmap_blinky_app

# Python command to generate flashmap header file from flashmap JSON file
PLATFORM=PSOC_061_512K
ifneq ($(FLASH_MAP), )
generate_flashmap_blinky_app:
	@echo -e "\n============================================================="
	@echo -e "= Generating memorymap.h, memorymap.c and memorymap.mk ="
	@echo -e "============================================================="
	$(CY_PYTHON_PATH) ../scripts/memorymap_psoc6.py -p $(PLATFORM) -m -i ../flashmap/$(FLASH_MAP) -o ./source/memorymap.c -a ./source/memorymap.h -d $(IMG_ID) > ./memorymap.mk
	@echo -e "=============================================================\n"

-include ./memorymap.mk
DEFINES+=CY_FLASH_MAP_JSON
endif

# Include the common library make file
include ../common_libs.mk

# use USE_OVERWRITE = 1 for overwrite only mode
# use USE_OVERWRITE = 0 for swap upgrade mode
ifeq ($(USE_OVERWRITE), )
USE_OVERWRITE?=$(PLATFORM_DEFAULT_USE_OVERWRITE)
endif

# 1. Define the image type.
# 2. Ignore the build directory(if any) of other build mode to avoid linker error.
# 3. Disabling the encrpyt image support while signing the boot image
# 4. Add flag, if not using swap for upgrade
ifeq ($(IMG_TYPE), BOOT)
DEFINES+=BOOT_IMAGE
CY_IGNORE+=build/UPGRADE
ENC_IMG=0
else ifeq ($(IMG_TYPE), UPGRADE)
DEFINES+=UPGRADE_IMAGE
CY_IGNORE+=build/BOOT
DEFINES+=SWAP_DISABLED=$(USE_OVERWRITE)
endif

# Set the version of the app using the following three variables.
# This version information is passed to the Python module "imgtool" or "cysecuretools" while
# signing the image in the post build step. Default values are set as follows.
ifeq ($(IMG_TYPE), BOOT)
APP_VERSION_MAJOR?=1
APP_VERSION_MINOR?=0
APP_VERSION_BUILD?=0
else ifeq ($(IMG_TYPE), UPGRADE)
APP_VERSION_MAJOR?=2
APP_VERSION_MINOR?=0
APP_VERSION_BUILD?=0
endif

# Add flag to imgtool if not using swap for upgrade
ifeq ($(USE_OVERWRITE), 1)
UPGRADE_TYPE:=--overwrite-only
DEFINES+=MCUBOOT_OVERWRITE_ONLY
endif

# Add image type, version and core name metadata to image
IMG_VER_ARG=$(APP_VERSION_MAJOR).$(APP_VERSION_MINOR).$(APP_VERSION_BUILD)
DEFINES+=IMG_VER_MSG='"$(IMG_VER_ARG)"'
DEFINES+=IMG_TYPE_MSG='"$(IMG_TYPE)"'
DEFINES+=CORE_NAME_MSG='"$(CORE_NAME)"'

# Override the value from memorymap.mk
ifeq ($(USE_XIP), 0)
ifeq ($(IMG_TYPE), BOOT)
USE_EXTERNAL_FLASH=0
endif
endif

# Enable the external flash and XIP
ifeq ($(USE_EXTERNAL_FLASH), 1)
ifeq ($(USE_XIP), 1)
DEFINES+=USE_XIP
LD_SUFFIX=_xip
endif
DEFINES+=CY_BOOT_USE_EXTERNAL_FLASH
endif

# Flash erase value
# Possible values are 0 and 0xff
ifeq ($(FAMILY), PSOC6)
ifeq ($(USE_EXTERNAL_FLASH), 1)
ERASED_VALUE=0xff
else
ERASED_VALUE=0
endif
endif

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
COMPONENTS=

# Like COMPONENTS, but disable optional code that was enabled by default.
ifeq ($(FAMILY), PSOC6)
DISABLE_COMPONENTS=CM0P_SLEEP CM0P_SECURE CM0P_CRYPTO CM0P_BLESS
endif

# Set this application to run at the CM4
CORE=CM4
CORE_NAME=CM4_0

# By default the build system automatically looks in the Makefile's directory
# tree for source code and builds it. The SOURCES variable can be used to
# manually add source code to the build process from a location not searched
# by default, or otherwise not found by the build system.
# Include confirmation flag setting (img_ok) implementation
ifeq ($(IMG_TYPE), UPGRADE)
ifeq ($(USE_OVERWRITE), 0)
SOURCES+=$(MCUBOOT_CY_PATH)/platforms/img_confirm/$(FAMILY)/set_img_ok.c
INCLUDES+=$(MCUBOOT_CY_PATH)/platforms/img_confirm
endif
endif

# The following defines used for firmware upgrade
DEFINES+=MCUBOOT_IMAGE_NUMBER=$(MCUBOOT_IMAGE_NUMBER)\
         USER_APP_START=$(PRIMARY_IMG_START)\
         USER_APP_SIZE=$(SLOT_SIZE)\
         PRIMARY_IMG_START=$(PRIMARY_IMG_START)\
         MEMORY_ALIGN=$(PLATFORM_MEMORY_ALIGN)\
         PLATFORM_MAX_TRAILER_PAGE_SIZE=$(PLATFORM_MAX_TRAILER_PAGE_SIZE)\
         APP_$(CORE)\
         BOOT_$(CORE)\
         APP_CORE_ID=0\
         $(PLATFORM_DEFINES_APP)\
         $(FAMILY)\
         $(PLATFORM)

DEFINES+=APP_VERSION_MAJOR=$(APP_VERSION_MAJOR)\
         APP_VERSION_MINOR=$(APP_VERSION_MINOR)\
         APP_VERSION_BUILD=$(APP_VERSION_BUILD)

# Add additional defines to the build process (without a leading -D).
DEFINES+=CY_RETARGET_IO_CONVERT_LF_TO_CRLF

# Select softfp or hardfp floating point. Default is softfp.
VFP_SELECT=

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
LINKER_SCRIPT=./linker/linker_app.ld
else
$(error Only GCC_ARM is supported at this moment)
endif

# Additional / custom linker flags.
LDFLAGS+=-Wl,--defsym,MCUBOOT_HEADER_SIZE=$(MCUBOOT_HEADER_SIZE)
LDFLAGS+=-Wl,--defsym,BOOTLOADER_RAM_SIZE=$(BOOTLOADER_APP_RAM_SIZE)
LDFLAGS+=-Wl,--defsym,USER_APP_SIZE=$(SLOT_SIZE)
LDFLAGS+=-Wl,--defsym,USER_APP_START=$(PRIMARY_IMG_START)

# Additional / custom libraries to link in to the application.
LDLIBS=

CY_ELF_TO_HEX_TOOL=$(MTB_TOOLCHAIN_GCC_ARM__BASE_DIR)/bin/arm-none-eabi-objcopy
CY_ELF_TO_HEX_OPTIONS=-O ihex

# Set build directory for BOOT and UPGRADE images
CY_BUILD_LOCATION=./build/$(IMG_TYPE)
BINARY_OUT_PATH=$(CY_BUILD_LOCATION)/$(TARGET)/$(CONFIG)/$(APPNAME)

# Imgtool path
IMGTOOL_PATH=$(SEARCH_mcuboot)/scripts/imgtool.py

# Commands to sign the BOOT and UPGRADE images
PSOC6_PLATFORM_SIGN_ARGS=sign --header-size $(MCUBOOT_HEADER_SIZE) --pad-header --align 8 -M 512 -v $(IMG_VER_ARG)\
               -d "($(IMG_ID), $(IMG_VER_ARG))" -S $(SLOT_SIZE) -R $(ERASED_VALUE) $(UPGRADE_TYPE) -k $(SIGN_KEY_FILE_PATH)/$(SIGN_KEY_FILE).pem

# Starting address of the CM4 app or the offset at which the header of an image
# will begin. Image = Header + App + TLV + Trailer. See MCUboot documenation for
# details.
# New relocated address = ORIGIN + HEADER_OFFSET
# Padding the image for UPGRADE image.
ifeq ($(IMG_TYPE), BOOT)
HEADER_OFFSET?=0
HEX_START_ADDR?=$(PRIMARY_IMG_START)
else ifeq ($(IMG_TYPE), UPGRADE)
PSOC6_PLATFORM_SIGN_ARGS+= --pad
HEADER_OFFSET?=$(shell expr $$(( $(SECONDARY_IMG_START) - $(PRIMARY_IMG_START) )) )
HEX_START_ADDR?=$(SECONDARY_IMG_START)
endif

# Custom pre-build commands to run.
PREBUILD_VAR=+\
rm -f ./source/memorymap.c;\
rm -f ./source/memorymap.h;\
rm -f ./memorymap.mk;\
$(MAKE) generate_flashmap_blinky_app;

PREBUILD=$(PREBUILD_VAR)

# Custom post-build commands to run.
# 1. Take a backup of the original hex file (_raw.hex)
# 2. Delete the original hex
# 3. Relocate the starting address based on HEADER_OFFSET and also convert
#    .elf to _unsigned.hex
# 4. Sign the image using imgtool (.hex)
#
# Step 3 is done so that programmer tools can place the image directly into
# secondary slot. This step is not required if an application (e.g. OTA) is
# going to write the image into secondary slot.
#
# Note that the final file should be $(APPNAME).hex so that Eclipse and
# Make CLI can locate the file for programming.
ifeq ($(FAMILY), PSOC6)
POSTBUILD_VAR=+\
cp -f $(BINARY_OUT_PATH).hex $(BINARY_OUT_PATH)_raw.hex;\
rm -f $(BINARY_OUT_PATH).hex;\
$(CY_ELF_TO_HEX_TOOL) --change-addresses=$(HEADER_OFFSET) $(CY_ELF_TO_HEX_OPTIONS) $(BINARY_OUT_PATH).elf $(BINARY_OUT_PATH)_unsigned.hex;\
$(CY_PYTHON_PATH) $(IMGTOOL_PATH) $(PSOC6_PLATFORM_SIGN_ARGS) $(BINARY_OUT_PATH)_unsigned.hex $(BINARY_OUT_PATH).hex;
endif

POSTBUILD=$(POSTBUILD_VAR)

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
