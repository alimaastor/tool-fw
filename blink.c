
#include <avr/io.h>
#include <util/delay.h>

void delayms(uint16_t millis)
{
    while ( millis )
    {
        _delay_ms( 1 );
        millis--;
    }
}

int main( void ) {
    DDRC |= 1 << DDC7;
    while (1) {
        PORTC &= ~( 1 << PORTC7 );
        delayms( 900 );
        PORTC |= 1 << PORTC7;
        delayms( 100 );
    }
    return 0;
}

