
## Registers --> named storage locations

in ARM: r0, r1, ..., r15
in x86: eax, ebx, ecx, edx, esi, edi

Machine specific registers (MSR)

Registers with special functions: stack pointer, program counter, return address




## RISC V


A general assembly instructions syntax:

`instruction  operand1 op2 op3 opn`

Operands can be:
  - Constants like 1, 2, 3, 'C', 'h' (Characters) are also called immediates in assembly language.
  - Registers
  - Addresses

```asm

add r3, r1, r2   @ r3 = r1 - r2 Comment
mul r3, r1, r2   /* r3 = r1 * r2  Comment */


instr <destination operand> <src operands>
```

#### Instructions 

**4 Types of Instructions**

1. Data Processing Instr's (Arithmetic & compare, logical or & and )
2. Data Transfer Instr's (mem to reg, reg to mem, reg to reg)
3. Branch Instr's
4. Special Instr's (Specific to interacting with machine, peripheral) 



  * la - load address Ex: la sp, stack0 # Load address of stack0 into sp  
  * li - load immediate Ex: li a0, 1024*4  # Load immediate value 4096 into a0  
  * csrr - Control and Status Register Read Ex: csrr a1, mhartid # read from a control & status register mhartid and place the value in a1  
  * ecall - Environment Call Ex: ecall # ecall is used by a user program to make a system call — meaning it asks the OS to perform a task on its behalf.  

#### Registers

  * mhartid - machine hardware thread id # This ID identifies the hardware thread (hart) currently executing the instruction.  
  * sp - stack pointer 
  * gp - global pointer
  * ra - return address
  * ss - 
