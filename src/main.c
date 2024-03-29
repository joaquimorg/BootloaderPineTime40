

#include <stdint.h>
#include "pinetime_board.h"
#include "nrf_mbr.h"
#include "nrf_bootloader.h"
#include "nrf_bootloader_app_start.h"
#include "nrf_bootloader_dfu_timers.h"
#include "nrf_dfu.h"
#include "nrf_log.h"
#include "nrf_log_ctrl.h"
#include "nrf_log_default_backends.h"
#include "app_error.h"
#include "app_error_weak.h"
#include "nrf_bootloader_info.h"
#include "nrf_delay.h"

//#define DFU_MAGIC_OTA_RESET             0xA8
//bool ota_dfu = false;

static void on_error(void)
{
    NVIC_SystemReset();
}


void app_error_handler(uint32_t error_code, uint32_t line_num, const uint8_t * p_file_name)
{
    //NRF_LOG_ERROR("%s:%d", p_file_name, line_num);
    on_error();
}


void app_error_fault_handler(uint32_t id, uint32_t pc, uint32_t info)
{
    //NRF_LOG_ERROR("Received a fault! id: 0x%08x, pc: 0x%08x, info: 0x%08x", id, pc, info);
    on_error();
}


void app_error_handler_bare(uint32_t error_code)
{
    //NRF_LOG_ERROR("Received an error: 0x%08x!", error_code);
    on_error();
}

uint8_t anim = 1;

/**
 * @brief Function notifies certain events in DFU process.
 */
static void dfu_observer(nrf_dfu_evt_type_t evt_type)
{
    switch (evt_type)
    {
        case NRF_DFU_EVT_DFU_FAILED:
        case NRF_DFU_EVT_DFU_ABORTED:
            lcd_print(10, 160, "DFU ERROR", RGB2COLOR(128, 0, 0), true);
            break;
        case NRF_DFU_EVT_DFU_INITIALIZED:
        case NRF_DFU_EVT_TRANSPORT_DEACTIVATED:
            lcd_print(10, 100, "BLE DFU MODE", RGB2COLOR(255, 255, 0), true);
            lcd_print(10, 160, "WAITING...", RGB2COLOR(0, 255, 255), true);
            break;
        case NRF_DFU_EVT_TRANSPORT_ACTIVATED:
            lcd_print(10, 160, "CONNECTED", RGB2COLOR(0, 255, 0), true);
            break;
        case NRF_DFU_EVT_DFU_STARTED:
            lcd_print(10, 160, "STARTED", RGB2COLOR(0, 255, 0), true);
            break;
        case NRF_DFU_EVT_DFU_COMPLETED:
            lcd_print(10, 160, "COMPLETED", RGB2COLOR(0, 255, 0), true);
            break;
        case NRF_DFU_EVT_OBJECT_RECEIVED:
            anim++;
            if (anim > 4) anim = 1;
            switch (anim)
            {
            case 1:
                lcd_print(10, 160, "RECEIVING", RGB2COLOR(0, 255, 0), true);
                break;
            case 2:
                lcd_print(10, 160, "RECEIVING.", RGB2COLOR(0, 255, 0), true);
                break;
            case 3:
                lcd_print(10, 160, "RECEIVING..", RGB2COLOR(0, 255, 0), true);
                break;
            case 4:
                lcd_print(10, 160, "RECEIVING...", RGB2COLOR(0, 255, 0), true);
                break;            
            default:
                break;
            }
            
            break;
        default:
            break;
    }
}


/**@brief Function for application main entry. */
int main(void)
{
    uint32_t ret_val;

    //uint32_t const gpregret = NRF_POWER->GPREGRET;

    hardware_init();

    lcd_print(10, 100, "STARTING", RGB2COLOR(0, 255, 0), true);
    nrf_delay_ms(1000);

    /*if (button_pressed(KEY_ACTION)) {
        ota_dfu = true;
        nrf_delay_ms(1000);
    } 
    
    // Start Bootloader in BLE OTA mode
    ota_dfu = (gpregret == DFU_MAGIC_OTA_RESET);

    if (ota_dfu) NRF_POWER->GPREGRET = 0;*/

    // Must happen before flash protection is applied, since it edits a protected page.
    nrf_bootloader_mbr_addrs_populate();

    // Protect MBR and bootloader code from being overwritten.
    ret_val = nrf_bootloader_flash_protect(0, MBR_SIZE);
    APP_ERROR_CHECK(ret_val);
    
    ret_val = nrf_bootloader_flash_protect(BOOTLOADER_START_ADDR, BOOTLOADER_SIZE);
    APP_ERROR_CHECK(ret_val);

     (void) NRF_LOG_INIT(NULL);
    //NRF_LOG_DEFAULT_BACKENDS_INIT();

    //NRF_LOG_INFO("Inside main");
    //st7789_fill(0, 0, 240, 240, RGB2COLOR(0, 0, 0));
    lcd_print(10, 100, "BOOTING...", RGB2COLOR(255, 255, 0), true);
    
    ret_val = nrf_bootloader_init(dfu_observer);
    APP_ERROR_CHECK(ret_val);

    //NRF_LOG_FLUSH();

    //NRF_LOG_ERROR("After main, should never be reached.");
    //NRF_LOG_FLUSH();

    APP_ERROR_CHECK_BOOL(false);
}

/**
 * @}
 */
