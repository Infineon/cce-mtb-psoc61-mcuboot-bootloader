################################################################################
# \file Makefile
# \version 1.0
#
# \brief
# Top-level application make file.
#
################################################################################
# \copyright
# $ Copyright 2018-YEAR Cypress Semiconductor Apache2 $
################################################################################

################################################################################
# Basic Configuration
################################################################################

MTB_TYPE=APPLICATION

MTB_PROJECTS=bootloader_app blinky_app

include common_app.mk

include $(CY_TOOLS_DIR)/make/application.mk
