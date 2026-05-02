	.data
	.globl knr2iban
	.text
# -- knr2iban
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
knr2iban:
# TODO

	mv     t0 a0


	li     t1 68
	li     t2 69
	sb     t1 0(t0)
	addi   t0 t0 1
	sb     t2 0(t0)

	li     t3 48
	addi   t0 t0 1
	sb     t3 0(t0)
	addi   t0 t0 1
	sb     t3 0(t0)


#stored BLZ
	addi   sp sp -16
	sw     ra 0(sp)
	sw     a0 4(sp)
	sw     a2 8(sp)
	sw     a1 12(sp)

	addi   a0 a0 4
	li     a2 8
	call   memcpy

	lw     ra 0(sp)
	lw     a0 4(sp)
	lw     a2 8(sp)
	lw     a1 12(sp)
	addi   sp sp 16


#stored KNR
	addi   sp sp -16
	sw     ra 0(sp)
	sw     a0 4(sp)
	sw     a2 8(sp)
	sw     a1 12(sp)

	addi   a0 a0 12
	mv     a1 a2
	li     a2 10

	call   memcpy

	lw     ra 0(sp)
	lw     a0 4(sp)
	lw     a2 8(sp)
	addi   sp sp 16


#STORING THE cHECK DIGIT
	mv     t4 a0
	addi   sp sp -8
	sw     ra 0(sp)
	sw     t4 4(sp)

	call   validate_checksum

	lw     ra 0(sp)
	lw     t4 4(sp)
	addi   sp sp 8

# storing the check sum in 3rd and 4th
	li     t0 10
	li     t1 98
	mv     t2 a0
	sub    t3 t1 a0          # checksum deneray form

	rem    t5 t3 t0          # gives remainder
	div    t3 t3 t0          # gives quotient


	addi   t3 t3 48
	addi   t5 t5 48


	sb     t3 2(t4)
	sb     t5 3(t4)


	jr     ra








