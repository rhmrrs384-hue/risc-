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

	mv     t5 a0

# stores BLZ inits place
# length of BLZ
	addi   t5 t5 4
	li     t3 8

memcpy_BLZ:
	mv     t0 a1             # current target
	mv     t1 t5             # current source
	add    t2 t5 t3          # last source

mc_loop_BLZ:
# copy over 1 byte from source to target
	lbu    t4 0(t1)
	sb     t4 0(t0)
	addi   t0 t0 1
	addi   t1 t1 1
	bltu   t1 t2 mc_loop_BLZ # while current source != last


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



