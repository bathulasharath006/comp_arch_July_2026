.global main

main:
    /* Set up for the calculation */
    movl $5, %ebx   /* Move integer 5 into EBX (32-bit register) */
    movl $7, %ecx   /* Move integer 7 into ECX (32-bit register) */

    /* The addition */
    addl %ebx, %ecx /* Add EBX to ECX. The result (12) is stored in ECX. */

    /* Exit the program, returning the result as the exit code */
    movl %ecx, %eax /* Move the result (12) from ECX to EAX (exit status register) */
    ret             /* Return from main (uses the value in EAX as the exit code) */

