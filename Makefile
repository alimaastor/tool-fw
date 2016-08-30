
CC          = avr-gcc
PART       ?= m32u4
MMCU       ?= atmega32u4
FREQ_CPU   ?= 16000000UL
PROGRAMMER ?= usbtiny
CFLAGS     += -g -Os -Wall -Werror -mcall-prologues -mmcu=$(MMCU) -DF_CPU=$(FREQ_CPU)
OBJ2HEX     = avr-objcopy
AVRDUDE    ?= avrdude
TARGET     ?= blink

.PHONY: program
program: $(TARGET).hex
	$(AVRDUDE) -c $(PROGRAMMER) -p $(PART) -e
	$(AVRDUDE) -c $(PROGRAMMER) -p $(PART) -U flash:w:$(TARGET).hex

%.obj: %.o
	$(CC) $(CFLAGS) $< -o $@

%.hex : %.obj
	$(OBJ2HEX) -R .eeprom -O ihex $< $@

.PHONY: clean
clean:
	rm -f *.hex *.obj *.o

