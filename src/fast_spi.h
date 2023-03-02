#ifndef FAST_SPI_H
#define FAST_SPI_H

void init_fast_spi();
void write_fast_spi(const uint8_t* ptr, uint32_t len, bool mode);

#endif // FAST_SPI_H