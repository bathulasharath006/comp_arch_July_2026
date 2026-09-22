@ Computer: 4 + 5 - 19 and save result in r1

@ Simple yet suboptimal

mov r1, #4
mov r2, #5
add r3, r1, r2
mov r4, #19
sub r1, r3, r4


@ Optimal sol

mov r1, #4
add r1, r1, #5
sub r1, r1, #19

