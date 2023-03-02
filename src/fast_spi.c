#include "nrf.h"
#include "nrf_spim.h"
#include "fast_spi.h"
#include "nrf_gpio.h"

#define PIN_LCD_DC NRF_GPIO_PIN_MAP(0, 6 )
#define PIN_SPI_SCK NRF_GPIO_PIN_MAP(1, 9 )
#define PIN_SPI_MOSI NRF_GPIO_PIN_MAP(0, 12)
#define PIN_SPI_MISO 0xFF

void init_fast_spi() {

  NRF_SPIM3->ENABLE = SPIM_ENABLE_ENABLE_Disabled << SPIM_ENABLE_ENABLE_Pos;
  NRF_SPIM3->PSEL.SCK = PIN_SPI_SCK;;
  NRF_SPIM3->PSEL.MOSI = PIN_SPI_MOSI;
  NRF_SPIM3->PSEL.MISO = PIN_SPI_MISO;

  NRF_SPIM3->CONFIG = (SPIM_CONFIG_ORDER_MsbFirst << SPIM_CONFIG_ORDER_Pos) |
    (SPIM_CONFIG_CPOL_ActiveLow << SPIM_CONFIG_CPOL_Pos) |
    (SPIM_CONFIG_CPHA_Trailing << SPIM_CONFIG_CPHA_Pos);

  NRF_SPIM3->FREQUENCY = SPIM_FREQUENCY_FREQUENCY_M32 << SPIM_FREQUENCY_FREQUENCY_Pos;

  // setup CMD pin
  NRF_GPIOTE->CONFIG[1] = GPIOTE_CONFIG_MODE_Task << GPIOTE_CONFIG_MODE_Pos |
    GPIOTE_CONFIG_POLARITY_Toggle << GPIOTE_CONFIG_POLARITY_Pos |
    PIN_LCD_DC << GPIOTE_CONFIG_PSEL_Pos |
    GPIOTE_CONFIG_OUTINIT_Low << GPIOTE_CONFIG_OUTINIT_Pos;

  NRF_SPIM3->ENABLE = SPIM_ENABLE_ENABLE_Enabled << SPIM_ENABLE_ENABLE_Pos;

}

void write_fast_spi(const uint8_t* ptr, uint32_t len, bool mode) {

  if (mode)
    NRF_GPIOTE->TASKS_SET[1] = 1;
  else
    NRF_GPIOTE->TASKS_CLR[1] = 1;

  int v2 = 0;
  do
  {
    NRF_SPIM3->EVENTS_END = 0;
    NRF_SPIM3->EVENTS_ENDRX = 0;
    NRF_SPIM3->EVENTS_ENDTX = 0;
    NRF_SPIM3->TXD.PTR = (uint32_t)ptr + v2;
    if (len <= 0xFF)
    {
      NRF_SPIM3->TXD.MAXCNT = len;
      v2 += len;
      len = 0;
    }
    else
    {
      NRF_SPIM3->TXD.MAXCNT = 255;
      v2 += 255;
      len -= 255;
    }
    NRF_SPIM3->RXD.PTR = 0;
    NRF_SPIM3->RXD.MAXCNT = 0;
    NRF_SPIM3->TASKS_START = 1;
    while (NRF_SPIM3->EVENTS_END == 0);
    NRF_SPIM3->EVENTS_END = 0;
  } while (len);

  NRF_SPIM3->TASKS_STOP = 1;
  while (NRF_SPIM3->EVENTS_STOPPED == 0) __NOP();

}