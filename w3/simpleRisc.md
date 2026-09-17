```asm
.foo:
    add r2, r1, r0
    ret

.main:
    mov r0, 3
    mov r1, 5
    call .foo        /* call <labelname>
    add r3, r2, 10
```



-Register Spilling
  - Caller Saved Scheme: Caller function saves the register values in store before calling the callee function. Once callee fn is closed and control returns to caller function. Caller fn restore regsiter values from store.  
  - Callee Saved Scheme: Callee fn saves the registers at the begining of fn. and once it is done, it restores the old regsiter values before the control goes back to caller fn.  
  - 
  - 

---

- Activation Block: Memory Map of a fn.  
    - Args, ra, regsiter spill area, local vars  
    
- Stack Pointer Register: sp or r14
    - Traditionally stacks are downward growing.
    - The first activation block starts at the highest address and Subsequent activation blocks are allocated lower addresses
    - Allocating an activation block : sp = sp - <const>
    - De-allocating an activation block : sp = sp + <const>

- call and ret instr's:
    - return address register: ra or r15  
    - call instruction: call .foo --> ra = pc + 4; pc = addr(.foo);
        - Puts pc + 4 in ra, and jumps to the function 
    - ret instruction: ret --> pc = ra; 
        - Puts ra in pc

- nop instruction
    - nop: does nothing
    - Exa: nop


---

- 0 address instrs
    - nop & ret
    - encoding, 32 bit: | 5 bits opcode | 27 bits not used |
    - 


- 1 address instrs
    - b, beq, bgt, call
    - Fields
	    - 5 bit opcode
	    - 27 bit offset (PC relative addressing)
	    - Since the offset points to a 4 byte word address
	    - The actual address computed is : PC + offset * 4



- 3 address instrs
    - add, sub, mul, div, mod, and, or, Isl, Isr, asr
    - Format: <opcode> rd, rs1, <rs2/imm>
    - Let us use the 'I' bit to specify if the second operand is an immediate or a register. 
        - I=0 --> 2nd oprnd is reg
        - I=1 --> 2nd oprnd is an imd
    -  Since we have 16 registers, we need 4 bits to specify a register
    - Register Format:   | opcode 5 bits | I=0 1 bt | rd 4 bts | rs1 4 bts | rs2 4 bts | 
    - Immediate Format:   | opcode 5 bits | I=1 1 bt | rd 4 bts | rs1 4 bts | modifier 2 bts |  16 immd bts | 
        - modifier bits: 00(default), 01(u), 10(h)



- 2 address instrs
    - cmp, not and mov
    - Use the 3 address: immediate or register formats
    - Do not use of the fields
    - cmp: | opcode 5 bits |  I 1 bt | rd 4 bts(not used) | rs1 4 bts | rs2/imm  18 bts | 
    - mov: | opcode 5 bits |  I 1 bt | rd 4 bts | rs1 4 bts(not used) | rs2/imm  18 bts | 
    - not: | opcode 5 bits |  I 1 bt | rd 4 bts | rs1 4 bts(not used) | rs2/imm  18 bts | 

- Load and Store Instrs
    - ld rd, imm[rs1] :   | opcode 5 bits | I 1 bt | rd 4 bts | rs1 4 bts | modifier 2 bts |  16 immd bts | 
    - st rd, imm[rs1] :   | opcode 5 bits | I 1 bt | rd 4 bts | rs1 4 bts | modifier 2 bts |  16 immd bts | 




