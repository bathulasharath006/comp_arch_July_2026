@ Compute: 12^3 + 1 and save the result in r3

mov r0, #12        @ r0 = 12
mov r1, #1         @ r1 = 1
mul r2, r0, r0     @ r2 = 12^2
mla r3, r2, r0, r1 @ r3 = 12^2 x 12 + 1

