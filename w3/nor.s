@ Compute: (A OR B)'  where A, B are 1 bit Boolean vals.

@ Assume A=0, B=1 and save the result in r0.

mov r0, #0x0
orr r0, r0, #0x1
mvn r0, r0

