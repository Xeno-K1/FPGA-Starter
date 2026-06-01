#2x16 LCD
##What
This is a code for 2x16 LCD.
##How
There steps to initialize a 2x16 LCD and then Command it to show the characters we want.
Each Step is a State in the FSM that is responsible for the whole work.
The input clock is 36MHz. It is easily compatible with any other frequencies with a bit of change(Line 33 is F/1000 and F/500, these numbers are for timing of the counter and the LCD.).