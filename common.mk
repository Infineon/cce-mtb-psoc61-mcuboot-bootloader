################################################################################
# \file common.mk
# \version 1.0
#
# \brief
# Settings for all projects
#
################################################################################
# \copyright
# $ Copyright 2021-YEAR Cypress Semiconductor Apache2 $
################################################################################

# Target board/hardware (BSP).
# To change the target, it is recommended to use the Library manager
# ('make library-manager' from command line), which will also update Eclipse IDE launch
# configurations.
TARGET=APP_CY8CKIT-062S2-43012

# Name of toolchain to use. Options include:
#
# GCC_ARM -- GCC provided with ModusToolbox software
# ARM     -- ARM Compiler (must be installed separately)
# IAR     -- IAR Compiler (must be installed separately)
#
# See also: CY_COMPILER_GCC_ARM_DIR in common_app.mk
TOOLCHAIN=GCC_ARM

# Default build configuration. Options include:
#
# Debug -- build with minimal optimizations, focus on debugging.
# Release -- build with full optimizations
# Custom -- build with custom configuration, set the optimization flag in CFLAGS
#
# If CONFIG is manually edited, ensure to update or regenerate launch configurations
# for your IDE.
CONFIG=Debug

# Python path definition
CY_PYTHON_REQUIREMENT=true

# To ensure, CE is using GCC_ARM compiler only.
ifeq ($(TOOLCHAIN), GCC_ARM)
# actions
else
$(error Only GCC_ARM is supported at this moment)
endif

include ../common_app.mk
