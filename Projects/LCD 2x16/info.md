# 2x16 LCD
## What
This is a code for 2x16 Character LCD.
## How
There steps to initialize a 2x16 LCD and then Command it to show the characters we want.
Each Step is a State(init,f1,f2,f3,clr,d_con,em,setDDRAM,do) in the FSM that is responsible for the whole work. The reason of each state can be found on the datasheet of 2x16 Character LCD.
The input clock is 36MHz. It is easily compatible with any other frequencies with a bit of change(Line 33 is F/1000 and Line 38 is F/500, these numbers are for timing of the counter and the LCD.).