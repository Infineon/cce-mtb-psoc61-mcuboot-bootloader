# MCUboot based Basic Bootloader for PSoC 61

*Disclaimer: This is a community code example (CCE) released for the benefit of the community users. These projects have only been tested for the listed BSPs, tools versions, and toolchains documented in this readme. They are intended to demonstrate how a solution / concept / use-case can be achieved on a particular device. For official code examples, please click [here](https://github.com/Infineon/Code-Examples-for-ModusToolbox-Software)*

This community code example (CCE) demonstrates the implementation of [MCUBoot](https://www.mcuboot.com/) based bootloader for [PSoC&trade; 61 MCU](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-61/) devices. This CCE is derived from [mtb-example-psoc6-mcuboot-basic](https://github.com/Infineon/mtb-example-psoc6-mcuboot-basic) and PSoC61 support to run both Application and Bootloader from CM4 CPU is added.

In order to test this sample you need target board with PSoC61. You can replace the PSoC6 IC on one of the [PSoC™ 6 development kits](https://documentation.infineon.com/html/psoc6/hsg1651214227031.html) with [PSoC&trade; 61 MCU](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-61/) IC.

## Requirements

- [ModusToolbox&trade; software](https://www.Infineon.com/cms/en/design-support/tools/sdk/modustoolbox-software/) v3.0 (tested with MTB V3.0)
- Board support package (BSP) minimum required version: 4.0.0
- Programming language: C
- Associated parts: [PSoC&trade; 61 MCU](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-61/)
  *Note:* Only [CY8C6136BZI-F34](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/cy8c6136bzi-f34/) is tested in this CCE.

## Supported toolchains (make variable 'TOOLCHAIN')

- GNU Arm® embedded compiler v10.3.1 (GCC_ARM) - Default value of `TOOLCHAIN`

## Supported Kit

- This code example uses a customized **PSOC 62** KIT with [PSoC&trade; 61 MCU](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-61/) IC mounted on it.

- Any one of the [PSoC™ 6 development kits](https://documentation.infineon.com/html/psoc6/hsg1651214227031.html) can be used by replacing the IC on the board with [PSoC&trade; 61 MCU](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-61/) IC.
  This document uses [PSoC&trade; 62S2 Wi-Fi Bluetooth&reg; pioneer kit](https://www.infineon.com/cms/en/product/evaluation-boards/cy8ckit-062s2-43012) (`CY8CKIT-062S2-43012`) with *PSOC 61* [CY8C6136BZI-F34](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/cy8c6136bzi-f34/) custom mounted on it as a reference for all the discussions

 **Note:** Though this code example talks about customizing the `CY8CKIT-062S2-43012`, any other PSoC62 KIT can be used. Or user may decide to build his own KIT with PSoC61 and test this code example. Care must be taken to configure the BSP correctly in such cases. Please refer [BSP Assistant User Guide](https://www.infineon.com/dgdl/Infineon-ModusToolbox_BSP_Assistant_1.0_User_Guide-UserManual-v02_00-EN.pdf?fileId=8ac78c8c8386267f0183a972f45c59af) to create your own BSP.

 Before using this code example, make sure that the board is upgraded to KitProg3. The tool and instructions are available in the [Firmware Loader](https://github.com/Infineon/Firmware-loader) GitHub repository. If you do not upgrade, you will see an error like "unable to find CMSIS-DAP device" or "KitProg firmware is out of date".


## Software setup

Install a terminal emulator if you don't have one. Instructions in this document use [Tera Term](https://ttssh2.osdn.jp/index.html.en).

Python is shipped as part of the ModusToolbox™ installation. Add the python installation path from the ModusToolbox™ installation directory to the top of the system path in environmental variables.

## Using the code example

It is recommended to use a new workspace.
Create the project and open it using one of the following:

<details><summary><b>In Eclipse IDE for ModusToolbox&trade; software</b></summary>

1. Click the **New Application** link in the **Quick Panel** (or, use **File** > **New** > **ModusToolbox&trade; Application**). This launches the [Project Creator](https://www.Infineon.com/ModusToolboxProjectCreator) tool.

2. Pick a kit supported by the code example from the list shown in the **Project Creator - Choose Board Support Package (BSP)** dialog.

   When you select a supported kit, the example is reconfigured automatically to work with the kit. To work with a different supported kit later, use the [Library Manager](https://www.Infineon.com/ModusToolboxLibraryManager) to choose the BSP for the supported kit. You can use the Library Manager to select or update the BSP and firmware libraries used in this application. To access the Library Manager, click the link from the **Quick Panel**.

   You can also just start the application creation process again and select a different kit.

   If you want to use the application for a kit not listed here, you may need to update the source files. If the kit does not have the required resources, the application may not work.

   **Note:** In this step, please create the application picking a any known Kit like `CY8CKIT-062S2-43012` This is because, there are no offcial PSoC&trade; 61 Kit and hence the BSP. You will have build your own BSP; which will be discussed in next steps.

3. In the **Project Creator - Select Application** dialog, choose the example by enabling the checkbox.

4. (Optional) Change the suggested **New Application Name**.

5. The **Application(s) Root Path** defaults to the Eclipse workspace which is usually the desired location for the application. If you want to store the application in a different location, you can change the *Application(s) Root Path* value. Applications that share libraries should be in the same root path.

6. Click **Create** to complete the application creation process.

For more details, see the [Eclipse IDE for ModusToolbox&trade; software user guide](https://www.Infineon.com/MTBEclipseIDEUserGuide) (locally available at *{ModusToolbox&trade; software install directory}/ide_{version}/docs/mt_ide_user_guide.pdf*).

</details>

<details><summary><b>In command-line interface (CLI)</b></summary>

ModusToolbox&trade; software provides the Project Creator as both a GUI tool and the command line tool, "project-creator-cli". The CLI tool can be used to create applications from a CLI terminal or from within batch files or shell scripts. This tool is available in the *{ModusToolbox&trade; software install directory}/tools_{version}/project-creator/* directory.

Use a CLI terminal to invoke the "project-creator-cli" tool. On Windows, use the command line "modus-shell" program provided in the ModusToolbox&trade; software installation instead of a standard Windows command-line application. This shell provides access to all ModusToolbox&trade; software tools. You can access it by typing `modus-shell` in the search box in the Windows menu. In Linux and macOS, you can use any terminal application.

This tool has the following arguments:

Argument | Description | Required/optional
---------|-------------|-----------
`--board-id` | Defined in the `<id>` field of the [BSP](https://github.com/Infineon?q=bsp-manifest&type=&language=&sort=) manifest | Required
`--app-id`   | Defined in the `<id>` field of the [CE](https://github.com/Infineon?q=ce-manifest&type=&language=&sort=) manifest | Required
`--target-dir`| Specify the directory in which the application is to be created if you prefer not to use the default current working directory | Optional
`--user-app-name`| Specify the name of the application if you prefer to have a name other than the example's default name | Optional

<br>

The following example will clone the "[MCUBoot Bootloader for PSoC61](https://github.com/Infineon/cce-mtb-psoc61-mcuboot-bootloader)" application with the desired name "cce-mtb-psoc61-mcuboot-bootloader" configured for the *CY8CKIT-062S2-43012* BSP into the specified working directory, *C:/mtb_projects*:

   ```
   project-creator-cli --board-id CY8CKIT-062S2-43012 --app-id cce-mtb-psoc61-mcuboot-bootloader --user-app-name cce-mtb-psoc61-mcuboot-bootloader --target-dir "C:/mtb_projects"
   ```

**Note:** The project-creator-cli tool uses the `git clone` and `make getlibs` commands to fetch the repository and import the required libraries. For details, see the "Project creator tools" section of the [ModusToolbox&trade; software user guide](https://www.Infineon.com/ModusToolboxUserGuide) (locally available at *{ModusToolbox&trade; software install directory}/docs_{version}/mtb_user_guide.pdf*).

</details>

<details><summary><b>In third-party IDEs</b></summary>

Use one of the following options:

- **Use the standalone [Project Creator](https://www.Infineon.com/ModusToolboxProjectCreator) tool:**

   1. Launch Project Creator from the Windows Start menu or from *{ModusToolbox&trade; software install directory}/tools_{version}/project-creator/project-creator.exe*.

   2. In the initial **Choose Board Support Package** screen, select the BSP, and click **Next**.

   3. In the **Select Application** screen, select the appropriate IDE from the **Target IDE** drop-down menu.

   4. Click **Create** and follow the instructions printed in the bottom pane to import or open the exported project in the respective IDE.

<br>

- **Use command-line interface (CLI):**

   1. Follow the instructions from the **In command-line interface (CLI)** section to create the application, and then import the libraries using the `make getlibs` command.

   2. Export the application to a supported IDE using the `make <ide>` command.

   3. Follow the instructions displayed in the terminal to create or import the application as an IDE project.

For a list of supported IDEs and more details, see the "Exporting to IDEs" section of the [ModusToolbox&trade; software user guide](https://www.Infineon.com/ModusToolboxUserGuide) (locally available at *{ModusToolbox&trade; software install directory}/docs_{version}/mtb_user_guide.pdf*).

</details>

Now this example project has been created for *CY8CKIT-062S2-43012* KIT with PSoC62. Customize the BSP for *PSoC61* as below.

## Custom BSP for PSoC61
Following section describes how to customize the BSP for PSoC61 in the context of this code example. Please refer to [BSP Assistant User Guide](https://www.infineon.com/dgdl/Infineon-ModusToolbox_BSP_Assistant_1.0_User_Guide-UserManual-v02_00-EN.pdf?fileId=8ac78c8c8386267f0183a972f45c59af) for detailed instructions.

1. Right-click on the project name in ModusToolbox Project Explorer Window and open *BSP Assistant* by clicking on **ModuToolbox** > **BSP Assistant 1.0**)
Open the BSP Assistant Tool, and open the BSP that you have created during project creation.
**Note:** When UI version of the BSP assistant is used from the ModusToolbox UI, active BSP will be automatically picked by the BSP Assistant.

    **Figure 1. Open BSP Assistant 1.0**

    ![](images/open_bsp_assistant.png)

2. Change the device to [CY8C6136BZI-F34](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/cy8c6136bzi-f34/) and **Apply** changes and close the BSP Assistant.

   **Note:** [CY8C6136BZI-F34](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/cy8c6136bzi-f34/) is PSoC61 device.

    **Figure 2. Change the device to PSoC61**

    ![](images/select-dev.png)

3. Scroll up to Configurators and open *Device Configurator*. Save the configurations by clicking on **File** > **Save**.

    This step may generate some error or warning. Close the dialogue box by clicking *OK*.

    Check the *Notice List*, Two errors will be listed as shown in below figure.

    Fix the error corresponding to `Error: 'srss[0].clock[0].pathmux[5]' does not exist on the device`, by ***left click* on *fix and Disable the clock***.

    Igonre the other errors/warnings regarding `Error: There may be an inconsistency between the *.modus file and the makefile target configuration device sets.` It will be **fixed automatically on next step**.

    ![](images/devicecfg-save.png)

4. Open the terminal, go to < application > and execute the `make eclipse` command to Generates launch configs and project files.
   ```
   make eclipse
   ```

**Note:** You can use CLI version of the BSP Assistant Tool for the above configurations. Please refer [BSP Assistant User Guide](https://www.infineon.com/dgdl/Infineon-ModusToolbox_BSP_Assistant_1.0_User_Guide-UserManual-v02_00-EN.pdf?fileId=8ac78c8c8386267f0183a972f45c59af)

**Note:** Above steps are to customize an existing BSP for PSoC61. You can also create your own BSP from scratch as described in [BSP Assistant User Guide](https://www.infineon.com/dgdl/Infineon-ModusToolbox_BSP_Assistant_1.0_User_Guide-UserManual-v02_00-EN.pdf?fileId=8ac78c8c8386267f0183a972f45c59af).

## Operation

This document expects you to be familiar with MCUboot and its concepts. See [MCUboot documentation](https://github.com/mcu-tools/mcuboot) to learn more.

This example bundles two applications - the bootloader and the blinky app run by CM4. You need to build and program the applications in the following order. Do not start building the applications yet: follow the [Step-by-step instructions](#step-by-step-instructions).

1. *Build and program the bootloader app* - On the next reset, CM4 runs the bootloader and prints a message that no valid image has been found.

2. *Build and program the blinky app in BOOT mode (default)* - On the next reset, the bootloader will let CM4 run the blinky app from the primary slot. This application toggles the user LED at a 1-second interval.

3. *Build and program the blinky app in UPGRADE mode by setting the make variable `IMG_TYPE` to `UPGRADE`* - On the next reset, the bootloader will copy this new image from the secondary slot into the primary slot and let CM4 run the image from the primary slot. The application toggles the user LED at a 250-millisecond interval. The user has the option to make the upgrade image permanent in the primary slot or revert to the image that was in the primary slot on reset.

### Step-by-step instructions

1. Connect the board to your PC using the provided USB cable through the KitProg3 USB connector.

2. Open a terminal program and select the KitProg3 COM port. Set the serial port parameters to 8N1 and 115200 baud.

3. Install the dependent modules for the [imgtool](https://pypi.org/project/imgtool/) Python module for image signing and key management.

   MCUboot already includes this module, but not the dependent modules. Do the following:

   1. Open a CLI terminal and navigate to the *\<mtb_shared>/mcuboot/\<tag>/scripts* directory.

      On Windows, use the command line "modus-shell" program provided in the ModusToolbox&trade; installation instead of a standard Windows command line application. This shell provides access to all ModusToolbox&trade; tools. You can access it by typing `modus-shell` in the search box in the Windows menu.

      In Linux and macOS, you can use any terminal application.

   2. Run the following command to ensure that the required modules are installed or already present ("Requirement already satisfied:" is printed).

      ```
      python -m pip install -r requirements.txt
      ```
4. Build and program the bootloader application.

   <summary><b>Using CLI</b></summary>

     From the terminal, navigate to _< application >/bootloader and execute the `make program_proj` command to build and program the application using the default toolchain to the default target. The default toolchain and target are specified in the application's Makefile but you can override those values manually:

      ```
      make program_proj TOOLCHAIN=<toolchain>
      ```

      Example:
      ```
      make program_proj TOOLCHAIN=GCC_ARM
      ```

5. After programming, the bootloader starts automatically. Confirm that the UART terminal displays a message as shown follows:

    **Figure 5. Booting with no bootable image**

    ![](images/booting-with-no-bootable-image.png)

6. Build and program the blinky application in the BOOT mode.

   <summary><b>Using CLI</b></summary>

      From the terminal, navigate to _< application >/blinky_ directory and execute the `make program_proj` command to build and program the application using the default toolchain to the default target.

      ```
      make program_proj TOOLCHAIN=<toolchain>
      ```

      Example:
      ```
      make program_proj TOOLCHAIN=GCC_ARM
      ```

7. After programming, the bootloader starts automatically and lets CM4 run the blinky app. Confirm that the user LED toggles at a 1-second interval and the UART terminal displays a message as follows:

    **Figure 6. Booting with the blinky app in the BOOT mode**

    ![](images/booting-with-blinky-in-boot-mode.png)

8. Build (Do **not** program) the blinky application in the UPGRADE mode.

   <details open><summary><b>Using Eclipse IDE for ModusToolbox&trade; software</b></summary>

      1. Select the 'blinky' application in the project explorer.

      2. Edit the Makefile and update the value of the `IMG_TYPE` variable to `UPGRADE`.

      3. In the **Quick Panel**, scroll down, and click **Build \<Application name>**.
   </details>

   <details open><summary><b>Using CLI</b></summary>

      From the terminal, navigate to _< application >/blinky_ directory and execute the following command to build the application using the default toolchain to the default target:

      ```
      make build_proj -j8 IMG_TYPE=UPGRADE
      ```
   </details>

9. Program the UPGRADE image using CLI or through [Cypress&trade; Programmer](https://www.Infineon.com/cms/en/design-support/tools/programming-testing/psoc-programming-solutions/).

      <details open><summary><b>Using CLI</b></summary>

      From the terminal, navigate to _< application >/blinky_ directory and execute the following command to program the UPGRADE image using the default toolchain to the default target:

      ```
      make program_proj -j8 IMG_TYPE=UPGRADE
      ```

      </details>

      <details open><summary><b>Using Cypress&trade; Programmer</b></summary>

      1. Launch **Cypress Programmer** and select the probe or kit that you are using.

      2. Click on the **Open** icon and select the UPGRADE image hex file from *blinky/build/UPGRADE/\< BSP-NAME >/\<Build Config>* directory.

      3. If your UPGRADE image is built for an external flash, select and mark the **External Memory** checkbox.

      4. Click **Connect** and then **Program**.

      </details>

10. After programming, the bootloader starts automatically, upgrades the image by copying the image from the secondary slot into the primary slot, and lets CM4 run the blinky app. Confirm that the UART terminal displays the message as shown follows:

    **Figure 7. Booting with the blinky app in the UPGRADE mode**

    ![](images/booting-with-blinky-in-upgrade-mode.png)


**Note:** The user can build the combined image for bootloader and blinky using the `make build` CLI command in _< application >_ directory but during the linking stage there might be an error stating multiple definition of symbols for blinky for `BOOT` and `UPGRADE` image. Currently the solution to the problem has been addressed in the following code section of the _< application >/blinky/Makefile_ which ignores the build artifacts of the other `IMG_TYPE`. Ex: If `BOOT` is selected as `IMG_TYPE` then _< application >/blinky/build/UPGRADE/_ build directory artifacts will be ignored during the compilation and linking of `BOOT` image.

```
ifeq ($(IMG_TYPE), BOOT)
CY_IGNORE+=build/UPGRADE
else
ifeq ($(IMG_TYPE), UPGRADE)
CY_IGNORE+=build/BOOT
endif
endif
```

For programming the individual builds of bootloader app and blinky app use the `make program_proj` CLI command as mentioned in the above steps.

## Debugging

You can debug the example to step through the code. In the IDE, use the **\<Application Name> Debug (KitProg3_MiniProg4)** configuration in the **Quick Panel**. For details, see the "Program and debug" section in the [Eclipse IDE for ModusToolbox&trade; software user guide](https://www.Infineon.com/MTBEclipseIDEUserGuide).

**Note:** **(Only while debugging)** On the CM4 CPU, some code in `main()` may execute before the debugger halts at the beginning of `main()`. This means that some code executes twice – once before the debugger stops execution, and again after the debugger resets the program counter to the beginning of `main()`. See [KBA231071](https://community.Infineon.com/docs/DOC-21143) to learn about this and for the workaround.


## Design and implementation

As explained at the beginning of this document, this example bundles two applications - the bootloader app and the blinky app. The blinky app is directly programmed into the flash (internal or external depending on the build parameters) to quickly evaluate the MCUboot operation.

In a real scenario, an application that can download the upgrade image over a wired or wireless communication interface will write the image into the secondary slot. For example, [mtb-example-ota-mqtt](https://github.com/Infineon/mtb-example-ota-mqtt) is implemented using the [ota](https://github.com/Infineon/ota-update) middleware.

The MCUboot repo in [GitHub](https://github.com/mcu-tools/mcuboot/tree/v1.8.3-cypress/boot/cypress) also includes two apps - MCUbootApp and BlinkyApp - for PSoC&trade; 62 MCU devices. The functionality of this code example is the same as those apps. In this example, the bootloader app reuses a lot of source files (see *bootloader/app.mk* for the exact list of files) from MCUbootApp.

This code example uses ModusToolbox&trade; software resources such as BSPs and PSoC&trade; 6 MCU to provide a rich development experience that aligns well with other code examples based on ModusToolbox&trade; software.

Design and implementations are similar to that of [mtb-example-psoc6-mcuboot-basic] (https://github.com/Infineon/mtb-example-psoc6-mcuboot-basic) example; execpt both Bootloader and Applications are designed to run from CM4 CPU and tested on only PSoC61 device.

There are three types of swap modes supported in MCUboot - scratch, move, and using a status partition. Only swap mode using status partition can be used with PSoC&trade; 6 MCU devices because of the hardware restriction of the large minimum flash write/erase size. The MCUboot library is designed with the minimum flash to write/erase size to be 8 bytes or less. This is to ensure that data is not lost when writing to the flash sector status so that it is a single-cycle operation ensuring the robustness of the application.

Because PSoC&trade; 6 MCU devices have a large minimum flash write/erase size, swap using status partition has been implemented. Using this algorithm, a separate area in the internal flash is used to store swap status values and the image trailer data such as the swap size and info, boot image magic value, and the image ok field.

[MCUboot](https://github.com/mcu-tools/mcuboot) is a library that helps to implement secured bootloader applications for 32-bit MCUs.

See the "Swap status partition description" section of the [MCUbootApp documentation](https://github.com/mcu-tools/mcuboot/blob/v1.8.1-cypress/boot/cypress/MCUBootApp/MCUBootApp.md).

See [MCUboot design](https://github.com/mcu-tools/mcuboot/blob/v1.8.1-cypress/docs/design.md) documentation for details.

### Resources and settings

**Table 1. Application resources**

 Resource  |  Alias/object     |    Purpose
 :------- | :------------    | :------------
 UART (HAL)    |cy_retarget_io_uart_obj| UART HAL object used by Retarget-IO for Debug UART port
 UART (HAL)    |uart_modem_obj| UART HAL object used for communicating with LTE Modem
 GPIO (HAL)    | UART_MODEM_RESET       | User GPIO used to reset LTE Modem
 GPIO (HAL)    | CYBSP_USER_LED         | User LED controlled by the subscriber based on incoming MQTT messages
 GPIO (HAL)    | CYBSP_USER_BTN         | User button used to notify the publisher to publish MQTT messages

<br>


#### **Customizing and selecting the flash map**

A flash map for example is selected by changing the value of the `FLASH_MAP` variable in the *bootloader/shared_config.mk* file to the desired JSON file name. Supporting only *psoc6_swap_single.json* and *psoc6_overwrite_single.json* JSON files.

See [How to modify flash map](https://github.com/mcu-tools/mcuboot/blob/v1.8.1-cypress/boot/cypress/MCUBootApp/MCUBootApp.md#how-to-modify-flash-map) section to understand how to customize the flash map to your needs.

Before the pre-build stage, the flashmap JSON file is automatically parsed by the *bootloader/scripts/flashmap.py* python script to generate the following files:

   1. *flashmap.mk* and *source/cy_flash_map.h* files in the bootloader example.
   2. *flashmap.mk* file in the blinky example.

The parameters generated in the *flashmap.mk* file are used in the `DEFINES` and `LDFLAGS` variables of the application Makefile.

The structures generated in the *cy_flash_map.h* file are used by the *cy_flashmap.c* file in the MCUboot library.

### Configuring make variables

This section explains the important make variables that affect the MCUboot functionality. Some of these variables are autogenerated from the flashmap JSON file and some variables can be updated directly in the Makefile or passed along with the `make build` command.

#### **Common make variables**

These variables are common to both the bootloader and blinky apps and are configured via the *bootloader/shared_config.mk* file.

 Variable | Default value | Description
 -------- | ------------- |------------
 `SIGN_KEY_FILE`             | cypress-test-ec-p256 | Name of the private and public key files (the same name is used for both keys) |
 `BOOTLOADER_SIZE`           | Autogenerated       | Flash size of the bootloader app run by CM0+. <br>In the linker script for the bootloader app (CM0+), the `LENGTH` of the `flash` region is set to this value.<br>In the linker script for the blinky app (CM4), the `ORIGIN` of the `flash` region is offset to this value.
 `BOOTLOADER_APP_RAM_SIZE`   | 0x20000              | RAM size of the bootloader app run by CM0+. <br/>In the linker script for the bootloader app (CM0+), `LENGTH` of the `ram` region is set to this value.<br/>In the linker script for the blinky app (CM4), the `ORIGIN` of the `ram` region is offset to this value, and the `LENGTH` of the `ram` region is calculated based on this value.
 `SLOT_SIZE`                 | Autogenerated       | Size of the primary slot and secondary slot. i.e., flash size of the blinky app run by CM4.
 `MCUBOOT_HEADER_SIZE`       | 0x400                | Size of the MCUboot header. Must be a multiple of 1024 (see the following note).<br>Used in the following places:<br>1. In the linker script for the blinky app (CM4), the starting address of the`.text` section is offset by the MCUboot header size from the `ORIGIN` of the `flash` region. This is to leave space for the header that will be later inserted by the *imgtool* during post-build steps. <br/>2. Passed to the *imgtool* while signing the image. The *imgtool* fills the space of this size with zeroes (or 0xFF depending on internal or external flash) and then adds the actual header from the beginning of the image.
 `MAX_IMG_SECTORS`           | Autogenerated       | Maximum number of flash sectors (or rows) per image slot for which swap status is tracked in the image trailer.
 `MCUBOOT_IMAGE_NUMBER`      | Autogenerated       | The number of images supported in the case of multi-image bootloading.
 `PRIMARY_IMG_START`         | Autogenerated       | Starting address of primary slot.
 `SECONDARY_IMG_START`        | Autogenerated       | Starting address of secondary slot.


**Note:** The value of `MCUBOOT_HEADER_SIZE` must be a multiple of 1024 because the CM4 image begins immediately after the MCUboot header and it begins with the interrupt vector table. For PSoC&trade; 6 MCU, the starting address of the interrupt vector table must be 1024-bytes aligned.

`Number of bytes to be aligned to = Number of interrupt vectors x 4 bytes`

i.e., 1024 = 256 vectors x 4 bytes (32-bit address) per vector.

PSoC&trade; 6 MCU supports up to 240 external interrupts in addition to the 16 system exceptions provided by CM4. See the description of the CPUSS_CM4_VECTOR_TABLE_BASE register in [PSoC&trade; 6 registers technical reference manual](https://www.infineon.com/dgdl/Infineon-PSoC_6_MCU_PSoC_62_Register_Technical_Reference_Manual-AdditionalTechnicalInformation-v07_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0f9480c901dd&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-technical_reference_manual) and the description of the vector table offset register (VTOR) in Cortex&reg;-M4 (ARMv7-M) architecture technical reference manual for details.


#### **Bootloader app make variables**

These variables are configured via *bootloader/Makefile*.

 Variable             | Default value | Description
 -------------------- | ------------- | ----------------
 `USE_OVERWRITE`              | Autogenerated       | Value is 1 when scratch and status partitions are not defined in the flashmap JSON file.
 `USE_EXTERNAL_FLASH`         | Autogenerated       | Value is 1 when external flash is used for either primary or secondary slot.
 `USE_XIP`                    | Autogenerated       | Value is 1 when primary image is placed on external memory.

<br />

#### **Blinky app make variables**

These variables are configured via *blinky/Makefile*.

 Variable       | Default value    | Description
 -------------- | -----------------| -------------
 `IMG_TYPE`        | BOOT   | Valid values: BOOT, UPGRADE<br>**BOOT:** Use when the image is built for the primary slot. The `--pad` argument is not passed to the *imgtool*. <br/>**UPGRADE:** Use when the image is built for the secondary slot.  The `--pad` argument is passed to the *imgtool*.<br>Also, the blinky app defines the LED toggle delay differently depending on whether the image is BOOT type or UPGRADE type.
 `HEADER_OFFSET`   | Auto-calculated | The starting address of the CM4 app or the offset at which the header of an image will begin. Value equal to (`SECONDARY_IMG_START` - `PRIMARY_IMG_START`).
 `USE_OVERWRITE`              | Autogenerated       | Value is 1 when scratch and status partitions are not defined in the flashmap JSON file.
 `USE_EXTERNAL_FLASH`         | Autogenerated       | Value is 1 when an external flash is used for either primary or secondary slot.
 `USE_XIP`                    | Autogenerated       | Value is 1 when the primary image is placed on external memory.
 `KEY_FILE_PATH` | *../bootloader/keys* | Path to the private key file. Used with the *imgtool* for signing the image.
 `APP_VERSION_MAJOR`<br>`APP_VERSION_MINOR`<br>`APP_VERSION_BUILD` | 1.0.0 if `IMG_TYPE=BOOT`<br>2.0.0 if `IMG_TYPE=UPGRADE` | Passed to the *imgtool* with the `-v` option in *MAJOR.MINOR.BUILD* format, while signing the image. Also available as macros to the application with the same names.

<br />

### Usage of external flash

This section provides a quick overview of external flash support with MCUboot for PSoC&trade; 6 MCU. External flash support refers to placing the primary/secondary/both slots into an external flash. This helps to increase the available internal flash for the primary slot or to support update operation on MCUs with lower internal flash size.

MCUboot accesses the external NOR flash using the serial memory interface (SMIF) aka 'QSPI peripheral block' in PSoC&trade; 6 MCU. The SMIF block supports interfacing with QSPI devices; most of the PSoC&trade; 6 MCU development kits include a QSPI NOR flash. For example, the CY8CPROTO-062-4343W kit includes the [S25FL512S](https://www.infineon.com/dgdl/Infineon-S25FL512S_512_Mb_%2864_MB%29_3.0_V_SPI_Flash_Memory-DataSheet-v19_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ed046ae4b53&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-datasheet), which is a 64-MB (512-Mbit) QSPI NOR flash. MCUboot for PSoC&trade; 6 MCU uses the serial flash discoverable parameter (SFDP) standard to auto-discover the flash read/write commands and other parameters. Ensure that the NOR flash on your board supports this standard. See [ExternalMemory.md](https://github.com/mcu-tools/mcuboot/blob/master/boot/cypress/MCUBootApp/ExternalMemory.md) for more information on working with the external flash.

During post-build steps, the image address is relocated to begin from the external flash address using the following command:

```
arm-none-eabi-objcopy --change-addresses=HEADER_OFFSET -O ihex <input.elf> <output.hex>
```

**Note:** If you are placing more than one image in the external flash, ensure that the starting address of the images is aligned to the erase sector size of the NOR flash. For S25FL512S, the erase sector size is 256 KB (0x40000).


#### External flash programming

The programmer tool for PSoC&trade; 6 MCU (based on OpenOCD) programs the external flash with the data from the HEX file when the address of the data is 0x18000000 or higher. The programmer tool requires the configuration information (e.g., erase/read/program commands) about the external flash present on the board to be able to program the flash. This configuration is placed into the user area of the internal flash, and the address pointing to the configuration is placed into the TOC2 section of the supervisory flash (SFlash) area of the internal flash. The programmer tool understands the TOC2 structure and knows where to look for the address that points to the external flash configuration. See [PSoC&trade; 6 MCU programming specifications](https://www.infineon.com/dgdl/Infineon-PSoC_6_Programming_Specifications-Programming+Specifications-v12_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0f66d9bf5627&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-programming_specification) for more information on SFlash and TOC2.

The *mtb_shared/mcuboot/\<tag>/boot/cypress/MCUBootApp/cy_serial_flash_prog.c* file defines the TOC2 structure and the *cycfg_qspi_memslot.c./h* files under *bsps/TARGET_< BSP-NAME >/config/GeneratedSource* hold the external flash configuration structures. These files are autogenerated from *design.cyqspi* under *bsps/TARGET_< BSP-NAME >/config* using the [QSPI configurator](https://www.cypress.com/ModusToolboxQSPIConfig) tool.

**Note:** Initially the customized configuration files like - *design.cyqspi, design.cycapsense, design.modus* are present in the folder *templates/TARGET_< BSP-NAME >/config* and are copied automatically from this folder to *bsps/TARGET_< BSP-NAME >/config* during the library updates. The build system reads all these configurations from the *bsps/TARGET_< BSP-NAME >/config*.

**Note:** Although the bootloader app uses SFDP to autodiscover the external flash configuration, a static configuration must be present in the internal flash for programming to work. It is possible to program without storing the configuration in the internal flash. However, in that case, external memory programming is limited only to the PSoC&trade; 6 MCU + NOR flash device combinations that are on the PSoC&trade; 6 MCU development kits.


### Security

**Note:** This example simply demonstrates the image-signing feature of MCUboot. It does not implement root of trust (RoT)-based secured services such as secured boot and secured storage (to securely store and retrieve the keys). You must ensure that adequate security measures are implemented in your end product. See the [PSoC&trade; 64 line of secured MCUs](https://www.infineon.com/cms/en/product/microcontroller/32-bit-psoc-arm-cortex-microcontroller/psoc-6-32-bit-arm-cortex-m4-mcu/psoc-64) that offer those advanced security built-in features, and read this [whitepaper](https://www.infineon.com/dgdlac/Infineon-Security_Comparison_Between_PSoC_64_Secure_MCU_and_PSoC_62_63_MCU-Whitepaper-v01_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0fb27691270a&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-white_paper) that compares the security features between PSoC&trade; 64 'secure' MCU and PSoC&trade; 62/63 MCUs.

MCUboot checks the image integrity with SHA256, and image authenticity with digital signature verification. Multiple signature algorithms are supported; this example enables ECDSA SECP256R1 (EC256) by default. MCUboot uses the `Mbed TLS` library for cryptography.

PSoC&trade; 6 MCU supports hardware-accelerated cryptography based on the `Mbed TLS` library via a shim layer. The  [cy-mbedtls-acceleration](https://github.com/Infineon/cy-mbedtls-acceleration) library implements this layer. Hardware-accelerated cryptography shortens the boot time by more than four times compared to the software implementation (observation results).

**Note:** In the current version of the MCUBoot library (v1.8.1-cypress), hardware crypto acceleration is not supported.

MCUboot verifies the signature of the image in the primary slot every time before booting when `MCUBOOT_VALIDATE_PRIMARY_SLOT` is defined. In addition, it verifies the signature of the image in the secondary slot before copying it to the primary slot.

This example enables image authentication by uncommenting the following lines in the *bootloader/libs/mcuboot/boot/cypress/MCUbootApp/config/mcuboot_config/mcuboot_config.h* file:

```
#define MCUBOOT_SIGN_EC256
#define NUM_ECC_BYTES (256 / 8)
.
.
.
#define MCUBOOT_VALIDATE_PRIMARY_SLOT
```

When these options are enabled, the public key is embedded within the bootloader app. The blinky app is signed using the private key during the post-build steps. The *imgtool*  Python module included in the MCUboot repository is used for signing the image.

This example includes a sample key pair under the *bootloader/keys* directory. **You must not use this key pair in your end product.** See [Generating a key pair](#generating-a-key-pair) for generating a new key pair.


#### Generating a key pair

You can use the *imgtool* Python module to generate the keys.

1. Generate the private key:

   ```
   python imgtool.py keygen -k priv_key.pem -t ecdsa-p256
   ```

2. Extract the public key in the form of a C array:

   ```
   python imgtool.py getpub -k priv_key.pem >> pub_key.pub
   ```

### Pre- and post-build steps

#### **Bootloader app: Pre-build steps**

The pre-build steps are specified through the `PREBUILD` variable in *bootloader/Makefile*.

1. *Initialize the Git submodules for MCUboot:* This is required because the _library manager updates_ currently does not support initializing Git submodules while cloning a repo. This step executes only if the *libs/mcuboot/ext/mbedtls* directory (a submodule) does not exist or if the content of the directory is empty.

2. *Generate the external flash configuration files:* This step generates the *cycfg_qspi_memslot.c./h* files under the *bsps/TARGET_< BSP-NAME >/config/GeneratedSource* directory. This step is required because QSPI is not enabled in *design.modus*. This is done to avoid initializing the QSPI block in the generated source because it is initialized in the SFDP mode by the bootloader app in *main.c*. *psoc6make* autogenerates the source files from the configurator tools only if the peripheral is enabled in *design.modus*.

**Note:** Initially the customized configuration files like - *design.cyqspi, design.cycapsense, design.modus* are present in the folder *templates/TARGET_< BSP-NAME >/config* and are copied automatically from this folder to *bsps/TARGET_< BSP-NAME >/config* during the library updates. The build system reads all these configurations from the *bsps/TARGET_< BSP-NAME >/config*.

#### **Blinky app: Post-build steps**

The post-build steps are specified through the `POSTBUILD` variable in *blinky/Makefile*. These steps generate the signed version of the image in HEX format using the *imgtool* Python module. The `SIGN_ARGS` variable holds the arguments passed to the *imgtool*. The final image is in HEX format so that PSoC&trade; 6 MCU programmer tools can directly program the image into the device. If you are generating the image to use with a firmware update application running on the device, you may need to convert the image into binary (BIN) format.

1. Make a copy of the *\*.hex* file into a *\*_raw.hex* file.

2. Delete the *\*.hex* file because the final signed image will be generated with the same filename so that you can directly program the file either using the `make program_proj` command or using the launch configurations in the Eclipse IDE for ModusToolbox&trade; software.

3. Relocate the address and generate a new *\*_unsigned.hex* file from the *\*.elf* file using the *arm-none-eabi-objcopy* tool.

4. Sign the image using *imgtool* and generate the *\*.hex* file.


### **Bootloader app: Custom device configuration**

Initially the customized configuration files like - *design.cyqspi, design.cycapsense, design.modus* are present in the folder *templates/TARGET_< BSP-NAME >/config* and are copied automatically from this folder to *bsps/TARGET_< BSP-NAME >/config* during the library updates. The build system reads all these configurations from the *bsps/TARGET_< BSP-NAME >/config*. The custom configuration just enables the serial communication block (SCB) in the UART mode with the alias *CYBSP_UART*. *libs/mcuboot/boot/cypress/MCUbootApp/cy_retarget_io_pdl.c* uses this block to implement redirecting printf to UART.


### Design notes

1. Both the bootloader app and the blinky app implement redirecting printf to the serial port (UART). Both apps use the same SCB (UART) block to communicate with the USB-to-UART bridge provided by KitProg3. The bootloader app runs first, initializes the UART block, prints the messages, and then boots the blinky app which then again initializes the same UART block and prints messages. There is no conflict currently because the apps do not print simultaneously.

2. HAL drivers do not support CM0+. All codes written for the bootloader app use the PDL drivers only.

3. Bootloader app does not initialize the system clocks and resources; call `init_cycfg_system()` to let CM4 initialize them.


### Resources and settings

**Table 1. Bootloader app**

 Resource  |  Alias/object     |    Purpose
 :-------- | :-------------    | :------------
 SCB UART (PDL) |CYBSP_UART| Used for redirecting printf to UART port.
 SMIF (PDL) | QSPIPort | Used for interfacing with QSPI NOR flash.

<br />

**Table 2. Blinky app**

 Resource  |  Alias/object     |    Purpose
 :-------- | :-------------    | :------------
 UART (HAL)|cy_retarget_io_uart_obj| UART HAL object used by retarget-IO for debug UART port
 GPIO (HAL)    | CYBSP_USER_LED         | User LED

<br />

## Related resources


Resources  | Links
-----------|----------------------------------
Application notes  | [AN228571](https://www.infineon.com/dgdl/Infineon-AN228571_Getting_started_with_PSoC_6_MCU_on_ModusToolbox_software-ApplicationNotes-v06_00-EN.pdf?fileId=8ac78c8c7cdc391c017d0d36de1f66d1&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-an_vanitylink) – Getting started with PSoC&trade; 6 MCU on ModusToolbox&trade; software <br />  [AN215656](https://www.infineon.com/dgdl/Infineon-AN215656_PSoC_6_MCU_Dual-CPU_System_Design-ApplicationNotes-v09_00-EN.pdf?fileId=8ac78c8c7cdc391c017d0d3180c4655f&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-an_vanitylink) – PSoC&trade; 6 MCU: Dual-CPU system design <br />
Code examples  | [Using ModusToolbox&trade; software](https://github.com/Infineon/Code-Examples-for-ModusToolbox-Software) on GitHub <br /> [Using PSoC&trade; Creator](https://www.infineon.com/cms/en/design-support/software/code-examples/psoc-3-4-5-code-examples-for-psoc-creator)
Device documentation | [PSoC&trade; 6 MCU datasheets](https://www.infineon.com/cms/en/search.html#!view=downloads&term=psoc6&doc_group=Data%20Sheet) <br /> [PSoC&trade; 6 technical reference manuals](https://www.infineon.com/cms/en/search.html#!view=downloads&term=psoc6&doc_group=Additional%20Technical%20Information)<br />
Development kits | Select your kits from the [Evaluation board finder](https://www.infineon.com/cms/en/design-support/finder-selection-tools/product-finder/evaluation-board) page
Libraries on GitHub  | [mtb-pdl-cat1](https://github.com/Infineon/mtb-pdl-cat1) – PSoC&trade; 6 peripheral driver library (PDL)  <br /> [mtb-hal-cat1](https://github.com/Infineon/mtb-hal-cat1) – Hardware abstraction layer (HAL) library <br /> [retarget-io](https://github.com/Infineon/retarget-io) – Utility library to retarget STDIO messages to a UART port <br />
Middleware on GitHub  | [MCUboot](https://github.com/mcu-tools/mcuboot) – Open-source library enabling the development of secure bootloader applications for 32-bit MCUs<br />[capsense](https://github.com/Infineon/capsense) – CAPSENSE&trade; library and documents <br /> [psoc6-middleware](https://github.com/Infineon/modustoolbox-software#psoc-6-middleware-libraries) – Links to all PSoC&trade; 6 MCU middleware
Tools  | [Eclipse IDE for ModusToolbox&trade; software](https://www.infineon.com/modustoolbox) – ModusToolbox&trade; software is a collection of easy-to-use software and tools enabling rapid development with Infineon MCUs, covering applications from embedded sense and control to wireless and cloud-connected systems using AIROC&trade; Wi-Fi and Bluetooth® connectivity devices. <br /> [PSoC&trade; Creator](https://www.infineon.com/cms/en/design-support/tools/sdk/psoc-software/psoc-creator) – IDE for PSoC&trade; and FM0+ MCU development
<br />


## Other resources

Infineon provides a wealth of data at www.infineon.com to help you select the right device, and quickly and effectively integrate it into your design.

For PSoC&trade; 6 MCU devices, see [How to design with PSoC&trade; 6 MCU - KBA223067](https://community.infineon.com/docs/DOC-14644) in the Infineon community.


## Document history

Document title: *CCE236897* - *MCUboot based Basic Bootloader for PSoC 61*

 Version | Description of change
 ------- | ---------------------
 1.0.0   | New code example
 1.0.1   | Custom BSP for PSoC61: Updates on README
<br>

---------------------------------------------------------

© Cypress Semiconductor Corporation, 2020-2022. This document is the property of Cypress Semiconductor Corporation, an Infineon Technologies company, and its affiliates ("Cypress").  This document, including any software or firmware included or referenced in this document ("Software"), is owned by Cypress under the intellectual property laws and treaties of the United States and other countries worldwide.  Cypress reserves all rights under such laws and treaties and does not, except as specifically stated in this paragraph, grant any license under its patents, copyrights, trademarks, or other intellectual property rights.  If the Software is not accompanied by a license agreement and you do not otherwise have a written agreement with Cypress governing the use of the Software, then Cypress hereby grants you a personal, non-exclusive, nontransferable license (without the right to sublicense) (1) under its copyright rights in the Software (a) for Software provided in source code form, to modify and reproduce the Software solely for use with Cypress hardware products, only internally within your organization, and (b) to distribute the Software in binary code form externally to end users (either directly or indirectly through resellers and distributors), solely for use on Cypress hardware product units, and (2) under those claims of Cypress’s patents that are infringed by the Software (as provided by Cypress, unmodified) to make, use, distribute, and import the Software solely for use with Cypress hardware products.  Any other use, reproduction, modification, translation, or compilation of the Software is prohibited.
<br>
TO THE EXTENT PERMITTED BY APPLICABLE LAW, CYPRESS MAKES NO WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, WITH REGARD TO THIS DOCUMENT OR ANY SOFTWARE OR ACCOMPANYING HARDWARE, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  No computing device can be absolutely secure.  Therefore, despite security measures implemented in Cypress hardware or software products, Cypress shall have no liability arising out of any security breach, such as unauthorized access to or use of a Cypress product. CYPRESS DOES NOT REPRESENT, WARRANT, OR GUARANTEE THAT CYPRESS PRODUCTS, OR SYSTEMS CREATED USING CYPRESS PRODUCTS, WILL BE FREE FROM CORRUPTION, ATTACK, VIRUSES, INTERFERENCE, HACKING, DATA LOSS OR THEFT, OR OTHER SECURITY INTRUSION (collectively, "Security Breach").  Cypress disclaims any liability relating to any Security Breach, and you shall and hereby do release Cypress from any claim, damage, or other liability arising from any Security Breach.  In addition, the products described in these materials may contain design defects or errors known as errata which may cause the product to deviate from published specifications. To the extent permitted by applicable law, Cypress reserves the right to make changes to this document without further notice. Cypress does not assume any liability arising out of the application or use of any product or circuit described in this document. Any information provided in this document, including any sample design information or programming code, is provided only for reference purposes.  It is the responsibility of the user of this document to properly design, program, and test the functionality and safety of any application made of this information and any resulting product.  "High-Risk Device" means any device or system whose failure could cause personal injury, death, or property damage.  Examples of High-Risk Devices are weapons, nuclear installations, surgical implants, and other medical devices.  "Critical Component" means any component of a High-Risk Device whose failure to perform can be reasonably expected to cause, directly or indirectly, the failure of the High-Risk Device, or to affect its safety or effectiveness.  Cypress is not liable, in whole or in part, and you shall and hereby do release Cypress from any claim, damage, or other liability arising from any use of a Cypress product as a Critical Component in a High-Risk Device. You shall indemnify and hold Cypress, including its affiliates, and its directors, officers, employees, agents, distributors, and assigns harmless from and against all claims, costs, damages, and expenses, arising out of any claim, including claims for product liability, personal injury or death, or property damage arising from any use of a Cypress product as a Critical Component in a High-Risk Device. Cypress products are not intended or authorized for use as a Critical Component in any High-Risk Device except to the limited extent that (i) Cypress’s published data sheet for the product explicitly states Cypress has qualified the product for use in a specific High-Risk Device, or (ii) Cypress has given you advance written authorization to use the product as a Critical Component in the specific High-Risk Device and you have signed a separate indemnification agreement.
<br>
Cypress, the Cypress logo, and combinations thereof, WICED, ModusToolbox, PSoC, CapSense, EZ-USB, F-RAM, and Traveo are trademarks or registered trademarks of Cypress or a subsidiary of Cypress in the United States or in other countries. For a more complete list of Cypress trademarks, visit cypress.com. Other names and brands may be claimed as property of their respective owners.
