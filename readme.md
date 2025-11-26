# Assembly Language Notes

## 1. Introduction to Assembly Language

Assembly language is a **low-level programming language** that communicates directly with the CPU using **mnemonics** and symbolic representations of machine instructions.

It provides:

* **Direct hardware control**
* **High execution speed**
* **Efficient use of memory**

Unlike high-level languages (C, Java), assembly requires understanding of the CPU architecture and registers.

---

## 2. 8086 Microprocessor Overview

The **Intel 8086** is a 16-bit microprocessor. Key features:

* **Registers:**

  * **General-purpose:** AX, BX, CX, DX (each 16-bit, can split into AH/AL, BH/BL, etc.)
  * **Segment registers:** CS (code), DS (data), SS (stack), ES (extra)
  * **Pointer/index registers:** SP, BP, SI, DI
  * **Instruction pointer:** IP
  * **Flags register:** Carry, Zero, Sign, Overflow, Parity, Auxiliary Carry, Direction

* **Memory segmentation:** divides memory into **segments** of 64KB

  * Each segment is referenced by its segment register + 16-bit offset

* **Instruction types:** Data transfer, arithmetic, logical, branching, string, I/O, control

---

## 3. Memory Segmentation and Models

8086 memory is **segmented** into code, data, stack, and extra segments.
The assembler uses **memory models** to define how many segments are used:

| Model       | Code Segments | Data Segments | Use Case                           |
| ----------- | ------------- | ------------- | ---------------------------------- |
| **Tiny**    | 1             | 1 (code+data) | Small COM programs                 |
| **Small**   | 1             | 1             | Most small programs                |
| **Medium**  | >1            | 1             | Large code, small data             |
| **Compact** | 1             | >1            | Small code, large data             |
| **Large**   | >1            | >1            | Large programs, both code and data |

* **`.MODEL SMALL`** is used for simple programs (<64KB code & data)
* **`.MODEL LARGE`** is used for huge programs (>64KB code or data)

---

## 4. Registers in 8086

| Register | Size   | Purpose                                  |
| -------- | ------ | ---------------------------------------- |
| AX       | 16-bit | Accumulator (AL/AH) for arithmetic & I/O |
| BX       | 16-bit | Base register (BL/BH) for addressing     |
| CX       | 16-bit | Count register for loops & shifts        |
| DX       | 16-bit | Data register (DL/DH) for I/O            |
| SP       | 16-bit | Stack pointer                            |
| BP       | 16-bit | Base pointer for stack/frame access      |
| SI       | 16-bit | Source index for string operations       |
| DI       | 16-bit | Destination index for string operations  |
| CS       | 16-bit | Code segment                             |
| DS       | 16-bit | Data segment                             |
| SS       | 16-bit | Stack segment                            |
| ES       | 16-bit | Extra segment                            |
| IP       | 16-bit | Instruction pointer                      |
| FLAGS    | 16-bit | CPU status flags                         |

---

## 5. Basic Assembly Program Structure (MASM)

```asm
.model small
.stack 100h

.data
    ; Data declarations
    num db 2
    msg db 'Hello$',0

.code
main proc
    mov ax, @data
    mov ds, ax       ; initialize data segment

    ; Program instructions

    mov ah, 4Ch
    int 21h          ; terminate program
main endp
end main
```

### Key Directives:

* **`.MODEL SMALL`** — memory model
* **`.STACK 100h`** — stack size
* **`.DATA`** — declares variables
* **`.CODE`** — program instructions
* **`main proc` / `endp`** — procedure
* **`end main`** — program end

---

## 6. Data Types in MASM

| Directive | Size          | Description                            |
| --------- | ------------- | -------------------------------------- |
| DB        | 1 byte        | Define byte                            |
| DW        | 2 bytes       | Define word (16-bit)                   |
| DD        | 4 bytes       | Define double word (32-bit)            |
| DQ        | 8 bytes       | Define quad word (64-bit)              |
| DT        | 10 bytes      | Define ten bytes (for BCD)             |
| ?         | uninitialized | Use `DB ?` or `DW ?` to reserve memory |

**Example:**

```asm
num db 5           ; byte
arr dw 1000        ; word
large dd 12345678  ; double word
```

---

## 7. Strings in MASM

* Strings are defined using `DB` and should **end with `$`** if using DOS `INT 21h AH=09h` to print.
* The `$` character marks the **end of the string** for DOS functions.

**Example:**

```asm
msg db 'Hello World$',0
```

* To print a string:

```asm
mov dx, offset msg
mov ah, 09h   ; DOS print string function
int 21h
```

---

## 8. Common Instructions

| Type              | Instruction                  | Purpose                                                  |
| ----------------- | ---------------------------- | -------------------------------------------------------- |
| Data transfer     | MOV                          | Copy data between registers, memory, or immediate values |
| Arithmetic        | ADD, SUB, MUL, DIV           | Perform arithmetic operations                            |
| Logic             | AND, OR, XOR, NOT            | Logical operations                                       |
| Control           | JMP, JE, JNE, LOOP           | Branching and looping                                    |
| String            | MOVS, LODS, STOS, CMPS, SCAS | String operations                                        |
| I/O               | IN, OUT                      | Input/output operations                                  |
| Processor control | INT, NOP, HLT                | Interrupts, halt, no-operation                           |

---

## 9. Loops, Conditions, and Jumps

* **LOOP** decrements CX and jumps if CX ≠ 0
* **Conditional jumps** check flags:

  * JE / JZ — jump if equal / zero
  * JNE / JNZ — jump if not equal / not zero
  * JC / JNC — jump if carry / no carry
  * JA / JNBE — jump if above (unsigned)
  * JB / JNAE — jump if below (unsigned)
  * JG / JNLE — jump if greater (signed)
  * JL / JNGE — jump if less (signed)
* **Unconditional jump:** JMP

**Example:**

```asm
mov cx, 5
startLoop:
    ; do something
    loop startLoop
```

**Example — conditional:**

```asm
cmp al, bl
je equalLabel
jne notEqualLabel
```

---

## 10. Procedures

* Procedures allow code **modularity and reuse**
* Syntax:

```asm
myProc proc
    ; instructions
    ret
myProc endp
```

* Call with `call myProc`
* Use `push`/`pop` to pass parameters if needed

---

## 11. Multiplication and ASCII Adjust (AAM)

**Problem:** Multiplying two decimal digits often gives a result in binary, not ASCII.

* Use **MUL** to multiply bytes:

```asm
mov al, 2
mov bl, 5
mul bl        ; AL = 10
```

* **AAM (ASCII Adjust after Multiplication)** splits result into tens & ones:

```asm
aam          ; AH = AL / 10, AL = AL % 10
add ah, 30h  ; convert tens to ASCII
add al, 30h  ; convert ones to ASCII
```

* AH = higher digit, AL = lower digit

---

## 12. Printing Characters (DOS Interrupt)

* DOS interrupt **INT 21h** can print characters or strings:

| AH  | Function                                 |
| --- | ---------------------------------------- |
| 02h | Display character in DL                  |
| 09h | Display string at DS:DX, ending with `$` |
| 01h | Input character from keyboard into AL    |
| 0Ah | Buffered input from keyboard             |
| 4Ch | Terminate program                        |

**Character example:**

```asm
mov dl, 'A'
mov ah, 2
int 21h
```

**String example:**

```asm
mov dx, offset msg
mov ah, 09h
int 21h
```

---

## 13. Macros in MASM

* Macros allow **code reuse**.
* Syntax:

```asm
myMacro macro param1, param2
    mov dl, param1
    add dl, 30h  ; convert to ASCII
    mov ah, 2
    int 21h
endm
```

* Call with: `myMacro num, times`
* For **two-digit numbers**, split AL using **AAM** before printing.

---

## 14. Why `.MODEL SMALL` vs `.MODEL LARGE`

* Small programs: 1 code + 1 data segment → `.MODEL SMALL`
* Large programs: multiple segments → `.MODEL LARGE`
* Using **SMALL** avoids unnecessary complexity for simple programs.

---

## 15. Tips

* Always **initialize DS** before accessing data:

```asm
mov ax, @data
mov ds, ax
```

* Clear AH before `MUL` if multiplying AL:

```asm
mov ah, 0
mul bl
```

* Convert binary numbers to ASCII before printing:

```asm
add al, 30h
```

* Use macros for repeated patterns like printing formatted output.

---

## References

1. Intel 8086 Manual
2. MASM/TASM Programmer’s Guide
3. Kip Irvine, *Assembly Language for x86 Processors*
