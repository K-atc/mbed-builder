#include "mbed.h"

static DigitalOut ledu(P6_12);                                  // LED-User

int main(void)
{
    while(1){
        wait(1.0);
        ledu = 0.0;
        wait(1.0);
        ledu = 1.0;
    }
}
