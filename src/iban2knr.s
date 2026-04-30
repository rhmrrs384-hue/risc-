	.data

	.globl iban2knr
	.text
# -- iban2knr
# Arguments:
# a0: IBAN buffer (22 bytes)
# a1: BLZ buffer (8 bytes)
# a2: KNR buffer (10 bytes)
iban2knr:
# TODO



	addi   sp sp -16
	sw     ra 0(sp)
	sw     a0 4(sp)
	sw     a1 8(sp)
	sw     a2 12(sp)

	mv     t0 a1
	mv     a1 a0
	mv     a0 t0
	addi   a1 a1 4
	li     a2 8
	call   memcpy

	lw     ra 0(sp)
	lw     a0 4(sp)
	lw     a1 8(sp)
	lw     a2 12(sp)
	addi   sp sp 16


# stores KNR in its place
# length of KLNR

	mv     t5 a0
	addi   t5 t5 12
	li     t3 10

memcpy_KNR:
	mv     t0 a2             # current target
	mv     t1 t5             # current source
	add    t2 t5 t3          # last source

mc_loop_KNR:
# copy over 1 byte from source to target
	lbu    t4 0(t1)
	sb     t4 0(t0)
	addi   t0 t0 1
	addi   t1 t1 1
	bltu   t1 t2 mc_loop_KNR # while current source != last

	jr     ra



