PROJECT_NAME     := bootloader_pinetime40
TARGETS          := bootloader_pinetime40
OUTPUT_DIRECTORY := _build

NRFUTIL := d:/Work/Pinetime/nRF52832/nrfutil
#SDK_ROOT := /mnt/d/Work/PineTime/nRF5_SDK_17.1.0_ddde560
SDK_ROOT := d:/Work/PineTime/nRF5_SDK_17.1.0_ddde560

PROJ_DIR := ./src

SOFT_DEVICE := s113
SOFT_DEVICE_HEX := s113_nrf52_7.3.0_softdevice.hex

SOFT_DEVICE_UC := S113

$(OUTPUT_DIRECTORY)/bootloader_pinetime40.out: \
	LINKER_SCRIPT  := secure_bootloader_gcc_nrf52.ld

# Source files common to all targets
SRC_FILES += \
	$(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52840.S \
	$(SDK_ROOT)/modules/nrfx/mdk/system_nrf52840.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
	$(SDK_ROOT)/components/libraries/util/app_error_weak.c \
	$(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
	$(SDK_ROOT)/components/libraries/util/app_util_platform.c \
	$(SDK_ROOT)/components/libraries/crc32/crc32.c \
	$(SDK_ROOT)/components/libraries/mem_manager/mem_manager.c \
	$(SDK_ROOT)/components/libraries/util/nrf_assert.c \
	$(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
	$(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
	$(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_nvmc.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
	$(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
	$(SDK_ROOT)/components/libraries/queue/nrf_queue.c \
	$(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
	$(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
	$(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
	$(SDK_ROOT)/components/libraries/sha256/sha256.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdsa.c \
	$(SDK_ROOT)/modules/nrfx/hal/nrf_nvmc.c \
	$(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_init.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_shared.c \
	$(SDK_ROOT)/components/ble/common/ble_srv_common.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start_final.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_dfu_timers.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_fw_activation.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_info.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_wdt.c \
	$(SDK_ROOT)/external/nano-pb/pb_common.c \
	$(SDK_ROOT)/external/nano-pb/pb_decode.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw/nrf_sw_backend_hash.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/dfu-cc.pb.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu.c \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu/nrf_dfu_ble.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_flash.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_handling_error.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_mbr.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_req_handler.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_settings.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_settings_svci.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_transport.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_utils.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_validation.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_ver_validation.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci_handler.c \
	$(SDK_ROOT)/components/libraries/svc/nrf_svc_handler.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c \
	$(PROJ_DIR)/dfu_public_key.c \
	$(PROJ_DIR)/fast_spi.c \
	$(PROJ_DIR)/display.c \
	$(PROJ_DIR)/main.c \


# Include folders common to all targets
INC_FOLDERS += \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc \
	$(SDK_ROOT)/components/softdevice/$(SOFT_DEVICE)/headers \
	$(SDK_ROOT)/components/libraries/memobj \
	$(SDK_ROOT)/components/libraries/sha256 \
	$(SDK_ROOT)/components/libraries/crc32 \
	$(SDK_ROOT)/components/libraries/experimental_section_vars \
	$(SDK_ROOT)/components/libraries/mem_manager \
	$(SDK_ROOT)/components/libraries/fstorage \
	$(SDK_ROOT)/components/libraries/util \
	$(SDK_ROOT)/modules/nrfx \
	$(SDK_ROOT)/external/nrf_oberon/include \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon \
	$(SDK_ROOT)/components/libraries/crypto/backend/cifra \
	$(SDK_ROOT)/components/libraries/atomic \
	$(SDK_ROOT)/integration/nrfx \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310_bl \
	$(SDK_ROOT)/components/softdevice/$(SOFT_DEVICE)/headers/nrf52 \
	$(SDK_ROOT)/components/libraries/log/src \
	$(SDK_ROOT)/components/libraries/bootloader/dfu \
	$(SDK_ROOT)/components/ble/common \
	$(SDK_ROOT)/components/libraries/delay \
	$(SDK_ROOT)/components/libraries/svc \
	$(SDK_ROOT)/components/libraries/stack_info \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw \
	$(SDK_ROOT)/components/libraries/log \
	$(SDK_ROOT)/external/nrf_oberon \
	$(SDK_ROOT)/components/libraries/strerror \
	$(SDK_ROOT)/components/libraries/crypto/backend/mbedtls \
	$(SDK_ROOT)/components/boards \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310 \
	$(SDK_ROOT)/components/libraries/bootloader \
	$(SDK_ROOT)/external/fprintf \
	$(SDK_ROOT)/components/libraries/crypto \
	$(SDK_ROOT)/components/libraries/crypto/backend/optiga \
	$(SDK_ROOT)/components/libraries/scheduler \
	$(SDK_ROOT)/modules/nrfx/hal \
	$(SDK_ROOT)/components/toolchain/cmsis/include \
	$(SDK_ROOT)/components/libraries/balloc \
	$(SDK_ROOT)/components/libraries/atomic_fifo \
	$(SDK_ROOT)/external/micro-ecc/micro-ecc \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw \
	$(SDK_ROOT)/modules/nrfx/mdk \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
	$(SDK_ROOT)/components/softdevice/common \
	$(SDK_ROOT)/external/nano-pb \
	$(SDK_ROOT)/components/libraries/queue \
	$(SDK_ROOT)/components/libraries/ringbuf \
	./config \
	$(PROJ_DIR) \

# Libraries common to all targets
LIB_FILES += \
	$(SDK_ROOT)/external/nrf_oberon/lib/cortex-m4/hard-float/liboberon_3.0.8.a \
	$(SDK_ROOT)/external/micro-ecc/nrf52hf_armgcc/armgcc/micro_ecc_lib_nrf52.a \

# Optimization flags
OPT = -Os -g3 -fno-exceptions -fno-non-call-exceptions
# Uncomment the line below to enable link time optimization
OPT += -flto

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += -DCFG_DEBUG=0
CFLAGS += -DBLE_STACK_SUPPORT_REQD
CFLAGS += -DBOARD_PCA10056
CFLAGS += -DCONFIG_GPIO_AS_PINRESET
CFLAGS += -DFLOAT_ABI_HARD
CFLAGS += -DNRF52840_XXAA
CFLAGS += -DNRF_DFU_SETTINGS_VERSION=2
CFLAGS += -DNRF_DFU_SVCI_ENABLED
CFLAGS += -DNRF_SD_BLE_API_VERSION=7
CFLAGS += -D$(SOFT_DEVICE_UC)
CFLAGS += -DSOFTDEVICE_PRESENT
CFLAGS += -DSVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
CFLAGS += -DuECC_ENABLE_VLI_API=0
CFLAGS += -DuECC_OPTIMIZATION_LEVEL=3
CFLAGS += -DuECC_SQUARE_FUNC=0
CFLAGS += -DuECC_SUPPORT_COMPRESSED_POINT=0
CFLAGS += -DuECC_VLI_NATIVE_LITTLE_ENDIAN=1
CFLAGS += -mcpu=cortex-m4
CFLAGS += -mthumb -mabi=aapcs
CFLAGS += -Wall -Werror
CFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums

# C++ flags common to all targets
CXXFLAGS += $(OPT)
# Assembler flags common to all targets
ASMFLAGS += -g3
ASMFLAGS += -mcpu=cortex-m4
ASMFLAGS += -mthumb -mabi=aapcs
ASMFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
ASMFLAGS += -DBLE_STACK_SUPPORT_REQD
ASMFLAGS += -DBOARD_PCA10056
ASMFLAGS += -DCONFIG_GPIO_AS_PINRESET
ASMFLAGS += -DFLOAT_ABI_HARD
ASMFLAGS += -DNRF52840_XXAA
ASMFLAGS += -DNRF_DFU_SETTINGS_VERSION=2
ASMFLAGS += -DNRF_DFU_SVCI_ENABLED
ASMFLAGS += -DNRF_SD_BLE_API_VERSION=7
ASMFLAGS += -D$(SOFT_DEVICE_UC)
ASMFLAGS += -DSOFTDEVICE_PRESENT
ASMFLAGS += -DSVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
ASMFLAGS += -DuECC_ENABLE_VLI_API=0
ASMFLAGS += -DuECC_OPTIMIZATION_LEVEL=3
ASMFLAGS += -DuECC_SQUARE_FUNC=0
ASMFLAGS += -DuECC_SUPPORT_COMPRESSED_POINT=0
ASMFLAGS += -DuECC_VLI_NATIVE_LITTLE_ENDIAN=1

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += -mthumb -mabi=aapcs -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
LDFLAGS += -mcpu=cortex-m4
LDFLAGS += -mfloat-abi=hard -mfpu=fpv4-sp-d16
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs

bootloader_pinetime40: CFLAGS += -D__HEAP_SIZE=0
bootloader_pinetime40: ASMFLAGS += -D__HEAP_SIZE=0

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm


.PHONY: default help softdevice erase

# Default target - first one defined
default: bootloader_pinetime40

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		bootloader_pinetime40
	@echo		softdevice - make .hex from softdevice and bootloader


TEMPLATE_PATH := $(SDK_ROOT)/components/toolchain/gcc

include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

softdevice:
	@echo	** Program Pinetime with Softdevice and bootloader
	python scripts/hexmerge.py --overlap=replace ./softdevice/$(SOFT_DEVICE_HEX) $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).hex -o $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).sd.hex
	openocd.exe -c "tcl_port disabled" -c "gdb_port 3333" -c "telnet_port 4444" -f interface/stlink.cfg -c 'transport select hla_swd' -f target/nrf52.cfg -c "program $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).sd.hex" -c reset -c shutdown

erase:
	@echo	** Erase Pinetime flash
	openocd.exe -f interface/stlink.cfg -c 'transport select hla_swd' -f target/nrf52.cfg -c init -c 'reset halt' -c 'nrf5 mass_erase' -c reset -c shutdown

settings:
	@echo	** Generating Settings
	D:\tools\nrfutil.exe settings generate --family NRF52840 --key-file d:/Work/PineTime/nordic_pem_keys/pinetime.pem --bootloader-version 2 --application-version 1 --bl-settings-version 2 --app-boot-validation NO_VALIDATION --application ./pkg/PinetimeNew40.ino.hex  ./pkg/bl_settings.hex

flash: default
	@echo	** Program Pinetime with $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).app.hex
	python scripts/hexmerge.py --overlap=replace ./pkg/bl_settings.hex $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).hex -o ./pkg/$(PROJECT_NAME)_settings.hex
	openocd.exe -c "tcl_port disabled" -c "gdb_port 3333" -c "telnet_port 4444" -f interface/stlink.cfg -c 'transport select hla_swd' -f target/nrf52.cfg -c "program ./pkg/$(PROJECT_NAME)_settings.hex" -c reset -c shutdown

dfu-zip:
	@echo	** Bootloader DFU zip
	python scripts/hexmerge.py --overlap=replace ./pkg/bl_settings.hex $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).hex -o ./pkg/$(PROJECT_NAME)_settings.hex
	D:\tools\nrfutil.exe pkg generate --key-file d:/Work/PineTime/nordic_pem_keys/pinetime.pem --bootloader ./pkg/$(PROJECT_NAME)_settings.hex --hw-version 52 --sd-req 0x125 --bootloader-version 2 ./pkg/$(PROJECT_NAME).zip

dfu-softdevice:
	@echo	** Bootloader DFU zip
#	D:\tools\nrfutil.exe settings generate --family NRF52840 --bootloader-version 2 --bl-settings-version 2 --softdevice ./softdevice/$(SOFT_DEVICE_HEX) ./pkg/bl_settings.hex
#	python scripts/hexmerge.py --overlap=replace ./pkg/bl_settings.hex ./softdevice/$(SOFT_DEVICE_HEX) -o ./pkg/sd_settings.hex
	D:\tools\nrfutil.exe pkg generate --key-file d:/Work/PineTime/nordic_pem_keys/pinetime.pem --softdevice ./softdevice/$(SOFT_DEVICE_HEX) --hw-version 52 --sd-req 0x125 ./pkg/sd.zip

app-zip:
	@echo	** Bootloader DFU zip
#	D:\tools\nrfutil.exe settings generate --family NRF52840 --bootloader-version 2 --bl-settings-version 2 ./pkg/bl_settings.hex
#	python scripts/hexmerge.py --overlap=replace ./pkg/bl_settings.hex $(OUTPUT_DIRECTORY)/$(PROJECT_NAME).hex -o ./pkg/$(PROJECT_NAME)_settings.hex
	D:\tools\nrfutil.exe pkg generate --key-file d:/Work/PineTime/nordic_pem_keys/pinetime.pem --application ./pkg/PinetimeNew40.ino.hex --hw-version 52 --sd-req 0x125 --application-version 1 ./pkg/PinetimeNew40.zip


#.PHONY: flash flash_softdevice erase

# Flash the program
#flash: default
#	@echo Flashing: $(OUTPUT_DIRECTORY)/nrf52832_xxaa_s132.hex
#	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/nrf52832_xxaa_s132.hex --sectorerase
#	nrfjprog -f nrf52 --reset

# Flash softdevice
#flash_softdevice:
#	@echo Flashing: s132_nrf52_7.2.0_softdevice.hex
#	nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/s132/hex/s132_nrf52_7.2.0_softdevice.hex --sectorerase
#	nrfjprog -f nrf52 --reset

#erase:
#	nrfjprog -f nrf52 --eraseall

