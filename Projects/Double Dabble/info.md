# Double Dabble
## What
The double dabble algorithm is used to convert binary numbers into binary-coded decimal (BCD) notation.
## How
There are two parts for this code. one part is shift and second one is plus3. Each part gets done with one clock. One clock comes and the whole number shifts and then the next clock comes, it checks that any of our 4bit outputs is above 4 so to add 3 to it. So for a 16 bit input we have 65535 and we have 5 numbers. the output is gonna be a 20 bit number that each 4 bit shows a number.(The whole code can be written with variables but variables are hardware hungry and will use all resources.)