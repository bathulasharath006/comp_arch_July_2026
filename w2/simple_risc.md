# SimpleRisc ISA


#### Registers

- 16 registers: r0-r15

- r14 = sp

- r15 = ra

- Von Neumann Model = One large array of bytes for both data & instr.

- Special "flags" register = result of last comparison & Only accessible to HW.

- flags.E = 1  when r1 == r2  

- flags.GT = 1  when r1 > r2  

- flags.E = 0 & flags.GT = 0 when r1 < r2  


#### Instructions

- 2 forms of *mov* 

- mov r1,r2 /* r1=r2  transfer the contents of one reg to another*/ 

- mov r1,3 /*  r1=3 transfer the contents of one immediate to another*/ 

- SimpleRisc has 16 bit immediates, range = -2^15 to 2^15 -1

##### SimpleRisc has 6 arithmetic Instructions

- add, sub, mul, div, mod - modulo gives remainder, cmp - compare & set flags

- Generic Form: instr reg1, reg2, (reg3 or immed) 

- Note: Only third argument can be an immediate and not any other position register

- Compare requires 2 registers and sets flags & will be present until the next compare operation


| Example         | Explanation                   |
|-----------------|-------------------------------|
| add r1, r2, r3  | r1 = r2 + r3                  |
| add r1, r2, 10  | r1 = r2 + 10 same for other 4 |
| sub r1, r2, r3  | r1 = r2 - r3                  |
| mul r1, r2, r3  | r1 = r2 * r3                  |
| div r1, r2, r3  | r1 = r2 / r3 (quotient)       |
| mod r1, r2, r3  | r1 = r2 mod r3 (remaider)     |
| cmp r1, r2      | r1 - r2 = 0  or > 0 set flags |


##### SimpleRisc has 3 logical Instructions

- and, or, not - all are bitwise operations

- Generic Form: instr reg1, reg2, (reg3 or immed) 

- Note: Only third argument can be an immediate and not any other position register

| Example         | Explanation                   |
|-----------------|-------------------------------|
| and r1, r2, r3  | r1 = r2 & r3                  |
| or r1, r2, r3   | r1 = r2 | r3                  |
| not r1, r2      | r1 = ~ r2 (toggles the bits)  |


##### SimpleRisc has 3 shift Instructions

- lsl (logical shift left) = << operator
    - 0010 << 2 = 1000 . After shifting the bits, 0's will be added
    - (<< n) same as multiplying 2^n

- lsr (logical shift right) = >>> operator
    - 1000 >>> 2 = 0010 . After shifting the bits, 0's will be added
    - ()>>> n) same as dividing by 2^n

- asr (arithmetic shift right) = >> operator
    - 0010 >> 1 = 0001 . After shifting the bits, sign bit will be extended
    - 1000 >> 2 = 1110 . After shifting the bits, sign bit will be extended

- Why there is no  `asl`? After shifting the bits, sign bit will always be overwritten  

- lsl, lsr, asr - all are bitwise shift operations

- Generic Form: instr reg1, reg2, (reg3 or immed) 

- Note: Only third argument can be an immediate and not any other position register

| Example           | Explanation            |
|-------------------|------------------------|
| lsl r1, r2, r3    | r1 = r2 << r3          |
| lsr r1, r2, r3    | r1 = r2 >>> r3         |
| asr r1, r2, r3    | r1 = r2 >> r3          |


- A Good programmer always try to use shift instr's instead of expensive mul or div instructions.

- Shift instr's are ultra fast than the time taking mul and div instr's.

Example 1: Compute 101 * 6 with shift operators 

```asm
mov r0, 101
lsl r1, r0, 1   /* 101 * 2 */
lsl r2, r0, 2   /* 101 * 4 */
add r3, r1, r2  /* 101 * 6 */
```

Example 2: Compute 102 * 7.5 with shift operators 

```asm
mov r0, 102
lsl r1, r0, 3   /* 102 * 8 */
lsr r2, r0, 1   /* 102 * 0.5 */
sub r3, r1, r2  /* 102 * 7.5 */
```


##### SimpleRisc Load-Store Instructions


- **2 address format, base-offset addressing** -- Uses 2 addresses only and base & offset value's in addressing   

- ld r1, 10[r2] /* r1 = [r2 + 10] */ Fetch the contents of register r2, add the offset (10), and then perform the memory access  

    - 1. Get r2                             → 1000 (addr. present in r2)  
    - 2. Add offset 10                      → 1000 + 10 = 1010
    - 3. Read 4 bytes from memory[1010]     → 123  (Value at addr. 1010)  
    - 4. Put 123 into r1                    → r1 = 123


- st r1, 10[r2] /* [r2 + 10] =  r1 */


Example 1: Translate the following C code into assembly.

```c
int arr[10];
arr[3] = 5;
arr[4] = 8;
arr[5] = arr[3] + arr[4];
```

```asm
/* assume base of array saved in r0 */
mov r1, 5
st r1, 12[r0]
mov r2, 8
st r2, 16[r0]
ld r3, 12[r0]
ld r4, 16[r0]
add r5, r3, r4
st r5, 20[r0]
```

- **Mem Layout:** 0-3: 0th index element, 4-7: 1st index element, 8-11: 2nd index element, 12-15: 3rd index element, .....


##### SimpleRisc Branch Instructions


**Unconditional Branch Instructions:**  

- `b <label_name> /* Branch to Label */` -- Branch is similar to "goto" in C  

```asm
add r1, r2, r3
b .foo    /* Branch to .foo */
...
...

.foo:
    add r3, r1, r4
```


**Conditional Branch Instructions:**  

- `beq <label_name> /* Branch to Label if flags.E = 1 */` goto statement with condition  

- `bgt <label_name> /* Branch to Label if flags.GT = 1 */`   

- flags are only set by cmp instr  

```asm
cmp r1, r2
bgt .gtlabel
mov r3, 5
...
...

.gtlabel:
    mov r3, 4
```

Example 1: Compute the factorial of the var. 'num'

```C
int prod=1;
int idx;

for (idx=num; idx>1; idx--)
    { prod=prod*idx; }
```

Answer:

```asm
mov r1, 1    /* prod=1 */
mov r2, r0   /* idx=num */

.loop:
    mul r1, r1, r2   /* prod = prod*idx */
    sub r2, r2, 1    /* idx--   */
    cmp r2, 1        /* idx > 1 */
    bgt .loop        /* if flags.GT=1, then back to .loop (4th code line) */
```



##### Modifiers


We can add the following modifiers to an instruction that has an immediate operand

Modifier :
* default : mov -> treat the 16 bit immediate as a signed number (automatic sign extension)
* (u) : movu -> treat the 16 bit immediate as an unsigned number
* (h) : movh -> left shift the 16 bit immediate by 16 positions

Mechanism

* The processor internally converts a 16 bit immediate to a 32 bit number
* It uses this 32 bit number for all the computations
* Valid only for arithmetic/logical insts
* We can control the generation of this 32 bit number
  - sign extension (default)
  - treat the 16 bit number as unsigned (u suffix)
  - load the 16 bit number in the upper bytes (h suffix)


- so essentially the modifiers can be used with any arithmetic & logical instructions and the mov instruction right so let me say this again the u and h modifiers can be used with any instruction that uses immediates namely the arithmetic & logical instructions and the mov instruction



```
              16-bit immediate
                     │
          ┌──────────┼──────────┐
          ↓          ↓          ↓
       default       u          h
          │          │          │
          ↓          ↓          ↓
    sign extend   zero extend   << 16
          │          │          │
          └──────────┼──────────┘
                     ↓
                  32-bit
                 immediate
                     │
                     ↓
                    ALU
                     │
                     ↓
             add/sub/mul/div/...
```

- This is actually a very useful purpose of movh: loading a 32-bit constant in pieces.




