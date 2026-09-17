### ARM Machine Model

- Memory (Von Neumann Arch)

- 16 regs: r0 - r15 & PC is explicitly visible

  | Reg | Abbrv. | Name                             |
  | --- | ---    | ---                              |
  | r11 | fp     | frame pointer                    |
  | r12 | ip     | intra-procedure-call scratch reg |
  | r13 | sp     | stck ptr                         |
  | r14 | lr     | link reg                         |
  | r15 | pc     | program cntr                     |


---

#### Data Transfer Instructions

- mov and mvn (move not - moves the not/compliment of a reg/immd)  


 | Semantics           | Example    | Explanation |
 | ---                 | ---        | ---         |
 | mov reg, (reg/immd) | mov r1, r2 | r1 <-- r2   |
 | mov reg, (reg/immd) | mov r1, #3 | r1 <-- 3    |
 | mvn reg, (reg/immd) | mvn r1, r2 | r1 <-- ~ r2 |
 | mvn reg, (reg/immd) | mvn r1, #3 | r1 <-- ~ 3  |

> Note: All immediates will be preceded with #.  


---

#### Arithmetic Instructions

- add, sub, rsb (reverse subtract)  


  | Semantics                | Example        | Explanation    |
  | ---                      | ---            | ---            |
  | add reg, reg, (reg/immd) | add r1, r2, r3 | r1 <-- r2 + r3 |
  | sub reg, reg, (reg/immd) | sub r1, r2, r3 | r1 <-- r2 - r3 |
  | rsb reg, reg, (reg/immd) | rsb r1, r2, r3 | r1 <-- r3 - r2 |

- Why separate rsb? why not use sub?
- rsb r1, r2, 3  --> r1 = 3 - r2  
- To implement the same using sub, two times sub is used.  


---

#### Logical Instructions

- and, eor (exclusive or), orr (or), bic (bit clear)  


   | Semantics                | Example        | Explanation         |
   | ---                      | ---            | ---                 |
   | and reg, reg, (reg/immd) | and r1, r2, r3 | r1 <-- r2 AND r3    |
   | eor reg, reg, (reg/immd) | eor r1, r2, r3 | r1 <-- r2 XOR r3    |
   | orr reg, reg, (reg/immd) | orr r1, r2, r3 | r1 <-- r2 OR r3     |
   | bic reg, reg, (reg/immd) | bic r1, r2, r3 | r1 <-- r2 AND (~r3) |


- ARM follows equal length instructions
- bic: whatever bit is set in r3, it should be cleared to 0 in result.
- Exa: 
    - r3 = 0010  (3rd bit is set, so it should be cleared in result)
    - r2 = 1111
    - r1 = r2 AND (~r3) = 1111 AND 1101 = 1101 (In result, 3rd bit is cleared)

---

#### Multiplication Instruction  

- mul (multiply), mla (multiply & accumlate), smull (signed multiply long), umull (unsigned multiply long)

   | Semantics                | Example              | Explanation         |
   | ---                      | ---                  | ---                 |
   | mul reg, reg, (reg/immd) | mul r1, r2, r3       | r1 <-- r2 x r3      |
   | mla reg, reg, reg, reg   | mla r1, r2, r3, r4   | r1 <-- r2 x r3 + r4 |
   | smull reg, reg, reg, reg | smull r0, r1, r2, r3 | r1r0 <-- r2 x r3    |
   | umull reg, reg, reg, reg | umull r0, r1, r2, r3 | r1r0 <-- r2 x r3    |


- smull and umull instructions can hold a 64 bit operand.  
- Please google about smull and umull instrs in arm 

> Note: Please remember where the lower and upper 32 bits are received in the registers of the result in smull and umull   


---

#### Shifter Operands

- lsl (logical shift left), lsr (logical shift right), asr (arithmetic shift right), ror (rotate right)  and there is no lor or lsr.  

- Generic format: reg1, <lsl | lsr | asr | ror> <reg2 | #immd>
    - Exa: r1, lsl r2
- #immediate range 0-31

Let r1 = 10110

- lsl:  r1, lsl #2  @ 11000 , 0's are padded to right
- lsr:  r1, lsr #2  @ 00101 , 0's are padded to left
- asr:  r1, asr #2  @ 11101 , sign bit is padded to left
- ror:  r1, ror #2  @ 10101 , bits are rotated in right direction

- arm don't have shift instrs, these are shift directives. 
- These are not separate instructions by themselves and these are used in instructions
- Exa: 
    @ Compute r1 = r2 / 4
    mov r1, r2 asr #2

    @ Compute r1 = r2 + r3 x 4
    add r1, r2, r3 lsl #2

- Please go thorugh the documentation in google search about lsl, lsr, asr, ror. Cause gemini gave wrong format of instructions and lor.  

---

#### Compare Instructions

- cmp (Compare), cmn (Compare Negative), tst (Test), teq (Test Equivalence)


  | Semantics           | Example    | Explanation                           |
  | ---                 | ---        | ---                                   |
  | cmp reg, (reg/immd) | cmp r1, r2 | Set flags after computing (r1 - r2)   |
  | cmn reg, (reg/immd) | cmn r1, r2 | Set flags after computing (r1 + r2)   |
  | tst reg, (reg/immd) | tst r1, r2 | Set flags after computing (r1 AND r2) |
  | teq reg, (reg/immd) | teq r1, r2 | Set flags after computing (r1 XOR r2) |

- Sets the flags of CPSR (Current Program Status Register) register
- N (Negative), Z (Zero), C (Carry), V (oVerflow)
- Please google "arm instructions documentation: cmp, cmn, tst, teq" and read the material.  

- https://en.eeworld.com.cn/news/mcu/eic282751.html

---

#### Instructions with the 's' suffix

- Compare instructions are not the only instructions that set the flags.
- We can add an s suffix to regular ALU instructions to set the flags.
    - An instruction with the 's' suffix sets the flags in the CPSR register.
    - adds (add and set the flags)
    - subs (subtract and set the flags)


---

#### Instructions that use the Flags

- adc (Add with Carry), sbc (Subtract with Carry), rsc (Reverse Subtract with Carry)

   | Semantics         | Example        | Explanation                     |
   | ---               | ---            | ---                             |
   | adc reg, reg, reg | adc r1, r2, r3 | r1 = r2 + r3 + Carry Flag       |
   | sbc reg, reg, reg | sbc r1, r2, r3 | r1 = r2 - r3 - NOT (Carry Flag) |
   | rsc reg, reg, reg | rsc r1, r2, r3 | r1 = r3 - r2 - NOT (Carry Flag) |

- add and subtract instructions that use the value of the carry flag  
- Please google and look about these instructions  


---








