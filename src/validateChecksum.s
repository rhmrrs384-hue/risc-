	.data
	.globl validate_checksum
	.text

# -- validate_checksum --
# Arguments:
# a0 : Address of a string containing a german IBAN (22 characters)
# Return:
# a0 : the checksum of the IBAN
validate_checksum:
# TODO

# Stroring Country code
	lb     t0 0(a0)
	lb     t1 1(a0)
	lb     t2 2(a0)
	lb     t3 3(a0)


	addi   sp sp -48

# saved the first 4 characters
	sw     t0 24(sp)         # D
	sw     t1 28(sp)         # E
	sw     t2 32(sp)         # 6
	sw     t3 36(sp)         # 8

# Shifting all bits of BLZ & KNR to stack pointer

	sw     a0 40(sp)
	sw     ra 44(sp)


	li     a2 18             # a2: number of characters
	addi   a1 a0 4           # Source adress
	mv     a0 sp             # save a0 in t4

	call   memcpy

	lw     t0 24(sp)         # D
	lw     t1 28(sp)         # E
	lw     t2 32(sp)         # 6
	lw     t3 36(sp)         # 8




# converting ascii to decimal
	li     t6 100
	li     t5 65
	sub    t0 t0 t5          # 3
	addi   t0 t0 10          # 13

	mul    t0 t0 t6

	sub    t1 t1 t5          # 4
	addi   t1 t1 10          # 14

	add    t4 t0 t1          #+ve number

# storing ascii numbers from 16 - 20 in sp

	addi   a1 sp 18          #target address (18)
	li     a2 4
	mv     a0 t4

	call   int_to_buf        # writes all the numbers to the back

	lw     t2 32(sp)         # 6
	lw     t3 36(sp)         # 8


#store checksum


	mv     t6 sp
	addi   t6 t6 22
	sb     t2 0(t6)
	addi   t6 t6 1
	sb     t3 0(t6)

	mv     a0 sp
	li     a1 24
	li     a2 97
	call   modulo_str

	mv     t0 a0
	lw     ra 44(sp)
	addi   sp sp 48
	mv     a0 t0

	jr     ra
