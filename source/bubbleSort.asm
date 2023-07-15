/* INFO: 

This is assemebly code for MIT's Beta Assembly Language which is very similar to the ARM ISA

This code can be tested and compiled by going to the following link and pasting the code: https://computationstructures.org/exercises/assembly/lab.html#
*/

.include "beta.uasm"

        BR(STEP1)   // start execution with Step 1

        // the array to be sorted
        A:      LONG(10) LONG(56) LONG(27) LONG(69) LONG(73) LONG(99)
                LONG(44) LONG(36) LONG(10) LONG(72) LONG(71) LONG(1)

ALEN = (. - A)/4    // determine number of elements in A

/* ----------- START OF BUBBLE SORT IMPLEMENTATION -------------*/

// define more relevant labels for registers
i = R0 // index in array
size = R1 // size of array to sort
new_size = R2 // new size to update
comp_reg = R3 // register for comparisons
offset = R4
curr = R5
prev = R6


STEP1: // initialize size registers
	CMOVE(ALEN, size)

STEP2: // first statements in size while loop
	CMOVE(0, new_size) 
	CMOVE(0, i) 
	
STEP3: // the for loop increment & comparison
	ADDC(i, 1, i) 
	CMPLT(i, size, comp_reg)
	BEQ(comp_reg, STEP5) 
	
	SHLC(i, 2, offset) 
	
	LD(offset, A, curr) // load A[i] into curr register
	LD(offset, A - 4, prev) // load A[i - 1] into prev register
	
STEP4: // if statement for swapping
	CMPLE(prev, curr, comp_reg) 
	BNE(comp_reg, STEP3) 
	
	// swap prev and curr values in memory
	ST(prev, A, offset) 
	ST(curr, A - 4, offset) 
	
	ADDC(i, 0, new_size)
	BR(STEP3) 
	

STEP5: // updating size & checking while loop condition
	ADDC(new_size, 0, size)
	BNE(size, STEP2)  


// When step 5 is complete, execution continues with the
// checkoff code.  You must include this code in order to
// receive credit for completing the problem.
.include "checkoff.uasm"

