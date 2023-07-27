/* INFO: 

This is assemebly code for MIT's Beta Assembly Language which is very similar to the ARM ISA

This code can be tested and compiled by going to the following link and pasting the code: https://computationstructures.org/exercises/procedures/lab.html#
*/

.include "checkoff.uasm"


TestCase: LONG(0)


p_storeIdx = R0
p_arr = R1
p_left = R2
p_right = R3
p_pivotVal = R4
p_tmp1 = R5
p_tmp2 = R6
p_arr_i = R7
p_arr_storeIdx = R8
p_i = R9

partition:
	PUSH(LP)
	PUSH(BP)
	MOVE(SP, BP)
	

	PUSH(R1)
	PUSH(R2)
	PUSH(R3)
	PUSH(R4)
	PUSH(R5)
	PUSH(R6)
	PUSH(R7)
	PUSH(R8) 
	PUSH(R9) 
	
	// load in register values for use
	LD(BP, -4 * (3 + 0), p_arr)
	LD(BP, -4 * (3 + 1), p_left)
	LD(BP, -4 * (3 + 2), p_right) 
	
	// find pivot_idx = (left + right) / 2 offset in bytes 
	ADD(p_left, p_right, p_tmp1)
	SHRC(p_tmp1, 1, p_tmp1)
	SHLC(p_tmp1, 2, p_tmp1) // get offset in bytes
	ADD(p_tmp1, p_arr, p_tmp1) // get memory address
	
	LD(p_tmp1, 0, p_pivotVal) 
	
	// move arr[right] to arr[pivotIdx] 
	MOVE(p_right, p_tmp2)
	SHLC(p_tmp2, 2, p_tmp2)
	ADD(p_tmp2, p_arr, p_tmp2)
	LD(p_tmp2, 0, p_tmp2)
	ST(p_tmp2, 0, p_tmp1) 
	
	MOVE(p_left, p_storeIdx) 
	
	// for loop logic
	MOVE(p_left, p_i)
	
loop:	
	CMPLT(p_i, p_right, p_tmp1) 
	BF(p_tmp1, loop_end) 
	
	// calculate arr[i] address and load into tmp1 reg
	SHLC(p_i, 2, p_arr_i) 
	ADD(p_arr_i, p_arr, p_arr_i) 
	
	LD(p_arr_i, 0, p_tmp1)
	
	CMPLT(p_tmp1, p_pivotVal, p_tmp2)
	BF(p_tmp2, incr) 
	
	// calculate arr[storeIdx] and load into tmp2 reg
	SHLC(p_storeIdx, 2, p_arr_storeIdx) 
	ADD(p_arr_storeIdx, p_arr, p_arr_storeIdx)
	
	LD(p_arr_storeIdx, 0, p_tmp2) 
	
	
	// swap arr[storeIdx] and arr[i]
	ST(p_tmp1, 0, p_arr_storeIdx)
	ST(p_tmp2, 0, p_arr_i) 
	
	ADDC(p_storeIdx, 1, p_storeIdx) 
	
incr:	// loop increment
	ADDC(p_i, 1, p_i) 
	BR(loop) 
		
		
loop_end:
	// swap arr[right] (holds pivotVal) and arr[storeIdx]

	SHLC(p_storeIdx, 2, p_arr_storeIdx) 
	ADD(p_arr_storeIdx, p_arr, p_arr_storeIdx)
	
	LD(p_arr_storeIdx, 0, p_tmp2) 
	
	SHLC(p_right, 2, p_tmp1) 
	ADD(p_tmp1, p_arr, p_tmp1)
	ST(p_tmp2, 0, p_tmp1) 
	ST(p_pivotVal, 0, p_arr_storeIdx)
	
	POP(R9)
	POP(R8)
	POP(R7) 
	POP(R6)
	POP(R5)
	POP(R4)
	POP(R3)
	POP(R2)
	POP(R1)
	MOVE(BP, SP)
	POP(BP)
	POP(LP)
	JMP(LP)


quicksort:
	PUSH(LP)
	PUSH(BP)
	MOVE(SP, BP)

	
	// extra regs
	PUSH(R1) 
	PUSH(R2) 
	PUSH(R3)
	PUSH(R4) 
	
	// comparison of left vs right
	LD(BP, -4 * (3 + 1), R1) 
	LD(BP, -4 * (3 + 2), R2) 
	
	CMPLT(R1, R2, R1) 
	BF(R1, q_rtn) 
	
	LD(BP, -4 * (3 + 0), R1) // arr
	LD(BP, -4 * (3 + 1), R2) // left idx
	LD(BP, -4 * (3 + 2), R3) // right idx
	
	// call partition function
	PUSH(R3)
	PUSH(R2)
	PUSH(R1)
	BR(partition, LP)
	DEALLOCATE(3) 
	
	// call quicksort on left subarray
	SUBC(R0, 1, R4)
	PUSH(R4) // pivotidx - 1 
	PUSH(R2)
	PUSH(R1) 
	BR(quicksort, LP) 
	DEALLOCATE(3) 
	
	// call quicksort on right subarray
	ADDC(R0, 1, R4)
	PUSH(R3) 
	PUSH(R4) // pivot_idx + 1
	PUSH(R1) 
	BR(quicksort, LP) 
	DEALLOCATE(3) 

q_rtn:	
	POP(R4)
	POP(R3)
	POP(R2)
	POP(R1)
	MOVE(BP, SP)
	POP(BP)
	POP(LP)
	JMP(LP)

// Allocate a stack: SP is initialized by checkoff code.
StackBasePtr:
	LONG(StackArea)

.unprotect

StackArea:
	STORAGE(1000)
