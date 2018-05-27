scope Mem {

// Allocate t0 blocks of memory and return an address to them in a0
Alloc:
scope Alloc {
	la a0,blocks
	
	// find next available contiguous chunk of t0 blocks
l0:
	move t1,t0
l1:
	lb t2,0(a0)
	bne t2,r0,l0
	addi a0,a0,1

	subi t1,t1,1
	bne t1,r0,l1
	nop

	// T1=table offset
	la a1,blocks
	sub t1,a0,a1

	// save the size of the allocated memory in the size table
	la a0,sizes
	add a0,a0,t1
	sw t0,0(a0)

	// save the address of the location in the address table and return it
	la a1,blocks
	sll t2,t1,2
	add a1,a1,t2
	
	la a0,pool
	add a0,a0,t2
	sw a0,0(a1)

	jr ra
	nop
}

// Free the memory at address in a0
Free:
scope Free {
	la a1,ptrs
l0:
	lw t0,0(a1)
	bne a0,t0,l0
	addi a1,a1,4

	// T0=offset to mark free
	// T1=# of blocks to free
	// A0=start address to mark freed bytes from
	la t0,ptrs
	sub t0,a1,t0
	srl t0,2

	la a1,sizes
	add a1,a1,t0
	lb t1,0(a1)

	la a0,blocks
	add a0,a0,t0
	add a1,a0,t1

l1:	
	//mark the blocks as empty
	sw r0,0(a0)
	bne a0,a1,l1
	addi a0,a0,1
	//mark the blocks as empty
done:
	jr ra
	nop
}

///////////////////////////////////////
// locations of each allocated block
ptrs:
fill 1024*4

// the size of each allocation
sizes:
fill 1024
}

blocks:
fill 256

pool:
fill 256*$100
