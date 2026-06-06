# DC Motor Driver (PWM)
## What
This is a code for PWM(Pulse Width Modulation) that start a DC Motor.
## How
First we get the data(from 0 to 255(2^7)) from adc(can be any kind of input not just adc). Then with a simple comparator we make the PWM. The resolution can be easily changed.
There is also a testbench to test the code in isim.