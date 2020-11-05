##16-bit ALU FPGA implementation

###Introduction

This GitHub repository details code for the implementation of a 16-bit Arithmetic Logic Unit (ALU) on an Alchitry Au FPGA with Br and Io boards attached. All code is done in Lucid.

The ALU normally takes in 2 16-bits signed integer inputs A and B, and returns a signed output RESULT. The operation performed depends on a 6-bit ALUFN code passed to the ALU. It consists of a fully combinational manual IO mode for normal operation, and an automatic self-test mode to check ALU functionality.

###Supported operations

The ALU supports the following operations as listen in the table below. Note that the inputs are treated as signed integers, with negative values represented using 2's complement.

| ALUFN  | Operation | Description                                                                       |
|--------|-----------|-----------------------------------------------------------------------------------|
| 000000 | ADD       | Adds A and B                                                                      |
| 000001 | SUB       | Subtracts B from A                                                                |
| 000010 | MUL       | Multiplies A and B                                                                |
| 011000 | AND       | Performs bitwise AND operation on A and B                                         |
| 011110 | OR        | Performs bitwise OR operation on A and B                                          |
| 010110 | XOR       | Performs bitwise XOR operation on A and B                                         |
| 011010 | 'A'       | Returns A (B is ignored)                                                          |
| 100000 | SHL       | Performs logical left shift of A by the number of cells indicated by B\[3:0\]       |
| 100001 | SHR       | Performs logical right shift of A by the number of cells indicated by B\[3:0\]      |
| 100011 | SRA       | Performs arithmetic right shift of A by the number of cells indicated by B\[3:0\]   |
| 101000 | DIV       | Divides A by B. Note that division by zero may yield unexpected results           |
| 110011 | CMPEQ     | Checks if A==B                                                                    |
| 110101 | CMPLT     | Checks if A&lt;B                                                                     |
| 110111 | CMPLE     | Checks if A<=B                                                                    |

Note that ALUFN codes listed here are in binary.

###Setup

Referring to the Br board reference in https://drive.google.com/file/d/1T3Vth8YpqDq1iOcPEW6TWjwVH0-h-59C/view,

* Connect input A\[15:8\] to the topmost row of Bank A, and A\[7:0\] to the 2nd top row, with most significant bit on the left.
* Connect input B\[15:8\] to the topmost row of Bank C, and B\[7:0\] to the 2nd top row, with most significant bit on the left.
* Connect input ALUFN\[5:3\] to A\[9,6,3\] on Bank A, and ALUFN\[2:0\] to A\[8,5,2\], with most significant bit on the left.
* Connect output RESULT\[15:8\] to the 2nd lowest row of Bank C, and RESULT\[7:0\] to the bottommost row of Bank C, with most significant bit on the left.

As a precaution, you may also wish to turn off all switches on the 2 leftmost arrays of the Io board.

####Usage

The rightmost switch in the rightmost array of the Io board allows toggling between normal operation and autotesting mode. Turn on to enable autotesting.

#####Normal operation

Under normal operation, no operation on the Io board is needed: the ALU takes external ALUFN, A and B input, and outputs the corresponding RESULT output through the Br board.

Additionally, the ALU illustrates the RESULT output using the 2 leftmost LED arrays, and the Z, V, and N result of the ALU's adder module using the 3 rightmost LEDs of the rightmost array.

#####Autotesting

In autotesting mode, the FPGA cycles through 64 different test cases, proceeding onto the next one only if RESULT, Z, V and N output of the ALU are correct.

The rightmost array displays debugging information. Specifically, the leftmost LED lights up only if RESULT is correct, and the 2nd leftmost one lights up only if Z, V and N are all correct. The other LEDs all indicate the index of the current test case. To illustrate this functionality, we include functionality for the 4th rightmost switch: toggle this switch to feed dummy zero ALU outputs to the autotester.

The 2 leftmost arrays display different values, depending on the values of the 2nd and 3rd rightmost switches. The indicated values are as follows:

| Switch value | Value displayed                                                                                                                     |   |
|--------------|-------------------------------------------------------------------------------------------------------------------------------------|---|
| 00           | ALUFN on the 6 leftmost bits of the leftmost LED array, and Z, V and N on the leftmost 3 bits of the middle LED array, from the ALU |   |
| 01           | A                                                                                                                                   |   |
| 10           | B                                                                                                                                   |   |
| 11           | RESULT output from ALU                                                                                                              |   |

For reference, the test cases are as follows, with all values in hex (note that the FPGA starts from the bottommost entry):

| ALUFN |   A  |   B  | RESULT | Z | V | N |
|:-----:|:----:|:----:|:------:|:-:|:-:|:-:|
|   00  | 0000 | 0000 |  0000  | 1 | 0 | 0 |
|   01  | 0000 | 0000 |  0000  | 1 | 0 | 0 |
|   01  | 0AFA | CCCC |  3E2E  | 0 | 0 | 0 |
|   01  | CCCC | 0AFA |  C1D2  | 0 | 0 | 1 |
|   00  | 0AFA | CCCC |  D7C6  | 0 | 0 | 1 |
|   01  | 6DA1 | AC44 |  C15D  | 0 | 1 | 1 |
|   00  | AC44 | 8CEA |  392E  | 0 | 1 | 0 |
|   02  | 0000 | 0000 |  0000  | 1 | 0 | 0 |
|   02  | FFFF | FFFF |  0001  | 0 | 0 | 1 |
|   02  | 7EE3 | 143E |  76FA  | 0 | 1 | 1 |
|   02  | 143E | 7EE3 |  76FA  | 0 | 1 | 1 |
|   02  | 7FFF | 7FFF |  0001  | 0 | 1 | 1 |
|   18  | 5F46 | 13EB |  1342  | 0 | 0 | 0 |
|   18  | 13EB | A63B |  022B  | 0 | 0 | 1 |
|   18  | A63B | 13EB |  022B  | 0 | 0 | 1 |
|   1E  | 4871 | F85E |  F87F  | 0 | 0 | 0 |
|   1E  | F85E | 2173 |  F97F  | 0 | 0 | 0 |
|   1E  | 2173 | FDBA |  FDFB  | 0 | 0 | 0 |
|   16  | FDBA | 3CFF |  C145  | 0 | 0 | 0 |
|   16  | 3CFF | 844C |  B8B3  | 0 | 0 | 1 |
|   16  | 844C | E997 |  6DDB  | 0 | 1 | 0 |
|   1A  | E997 | C4A6 |  E997  | 0 | 0 | 1 |
|   1A  | C4A6 | B798 |  C4A6  | 0 | 1 | 0 |
|   1A  | B798 | C4A6 |  B798  | 0 | 1 | 0 |
|   20  | 593A | 47FE |  8000  | 0 | 1 | 1 |
|   20  | 47FE | D73C |  E000  | 0 | 0 | 0 |
|   20  | D73C | 755E |  0000  | 0 | 0 | 0 |
|   21  | 755E | CFDC |  0007  | 0 | 1 | 1 |
|   21  | CFDC | 94E2 |  33F7  | 0 | 0 | 0 |
|   21  | 94E2 | B365 |  04A7  | 0 | 0 | 1 |
|   23  | B365 | DD69 |  FFD9  | 0 | 0 | 1 |
|   23  | DD69 | 40F3 |  FBAD  | 0 | 0 | 1 |
|   23  | 40F3 | 593A |  0010  | 0 | 0 | 1 |
|   28  | 2801 | 6D93 |  0000  | 0 | 1 | 1 |
|   28  | 6571 | 5E2F |  0001  | 0 | 1 | 1 |
|   28  | 6571 | 0001 |  6571  | 0 | 0 | 0 |
|   28  | 6571 | FFFF |  9A8F  | 0 | 0 | 0 |
|   28  | 0000 | 0001 |  0000  | 0 | 0 | 0 |
|   28  | 0000 | FFFF |  0000  | 0 | 0 | 1 |
|   28  | FFFF | FFFF |  0001  | 0 | 0 | 1 |
|   28  | 0001 | 0001 |  0001  | 0 | 0 | 0 |
|   28  | 0001 | FFFF |  FFFF  | 1 | 0 | 0 |
|   28  | FFFF | 0001 |  FFFF  | 1 | 0 | 0 |
|   28  | FE0F | E0D8 |  0000  | 0 | 0 | 1 |
|   28  | 5E20 | 0661 |  000E  | 0 | 0 | 0 |
|   28  | 8000 | E0D8 |  0004  | 0 | 1 | 0 |
|   28  | 8000 | 0001 |  8000  | 0 | 0 | 1 |
|   28  | 8000 | 8000 |  0001  | 1 | 1 | 0 |
|   28  | 8000 | FFFF |  8000  | 0 | 1 | 0 |
|   33  | 0000 | 0000 |  0001  | 1 | 0 | 0 |
|   35  | 0000 | 0000 |  0000  | 1 | 0 | 0 |
|   37  | 0000 | 0000 |  0001  | 1 | 0 | 0 |
|   33  | 0AFA | CCCC |  0000  | 0 | 0 | 0 |
|   35  | 0AFA | CCCC |  0000  | 0 | 0 | 0 |
|   37  | 0AFA | CCCC |  0000  | 0 | 0 | 0 |
|   33  | 8000 | 8000 |  0001  | 1 | 0 | 0 |
|   35  | 8000 | 8000 |  0000  | 1 | 0 | 0 |
|   37  | 8000 | 8000 |  0001  | 1 | 0 | 0 |
|   33  | 6DA1 | AC44 |  0000  | 0 | 1 | 1 |
|   35  | 6DA1 | AC44 |  0000  | 0 | 1 | 1 |
|   37  | 6DA1 | AC44 |  0000  | 0 | 1 | 1 |
|   33  | 8CEA | BA88 |  0000  | 0 | 0 | 1 |
|   35  | 8CEA | BA88 |  0001  | 0 | 0 | 1 |
|   37  | 8CEA | BA88 |  0001  | 0 | 0 | 1 |

While most of these test cases are based on randomly generated hexadecimal values, some test cases have been included to:

* Test Z, V and N comprehensively
* Test effects of switching A and B (which should be negligible for some operations and significant for others)
* Test edge values, eg. division of 0x8000 by 0x0001
