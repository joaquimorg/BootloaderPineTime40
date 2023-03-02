#ifndef DISPLAY_H
#define DISPLAY_H

#include <stdbool.h>
#include <stdint.h>

void init_display(void);
void set_addr_display(uint32_t x, uint32_t y, uint32_t w, uint32_t h);
void draw_buffer(uint16_t x, uint16_t y, uint16_t w, uint16_t h, uint8_t *data);
void write_display(uint8_t* data, uint16_t len);

#endif /* DISPLAY_H */