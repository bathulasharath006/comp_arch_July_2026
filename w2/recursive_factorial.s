/*   int factorial(int num)                 */
/*   {                                      */
/*           if (num <= 1) return 1;        */
/*           return num * factorial(num-1); */
/*   }                                      */
/*                                          */
/*                                          */
/*   void main()                            */
/*   {                                      */
/*           int result = factorial(10);    */
/*   }                                      */
/*                                          */

.factorial:
    cmp r0, 1            @ num <= 1
    beq .return
    bgt .continue
    b .return

.continue:
    sub sp, sp, 8       @ Create space on stack. Exa:
                        @ if sp (addr. = 1000), now sp (addr. = 992)

    st r0, [sp]         @ Now val at sp (addr. 992 to 995 = num val), 
                        @ r0 is pushed onto stack
    st ra, 4[sp]        @ val 4[sp] (addr. 996 to 999 = return val)
                        @ ra is pushed onto stack
    sub r0, r0, 1       @ num = num - 1
    call .factorial     @ recursive cal to factorial & result will be in r1
    ld ra, 4[sp]        @ pop the val from ra & from stack (which is r1)
    ld r0, [sp]         @ pop the val num from stack and put in r0
    mul r1, r0, r1      @ num * factorial(num-1)
    add sp, sp, 8       @ delete the activation block
    ret

.return:
    mov r1, 1           @ r1 is typically used as return reg.
    ret

.main:
    mov r0, 10          @ r0 is typically used as passing argument reg.
    call .factorial

