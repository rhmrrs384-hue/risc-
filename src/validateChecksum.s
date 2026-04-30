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

	call   iban2knr             # to fetch a1 = BLZ and a2 = KNR vals


#storing Country code and Checksum

Scode_initialize:
	mv     t1 a0
	addi   t2 a0 4

loop_Scode:
	lbu    t4 0(t1)
	sb     t4 0(s1)
	addi   s1 s1 1
	addi   t1 t1 1
	bltu   t1 t2 mc_loop_Lshift # while current source != last








	call   mem


# left shift whole IBAN 6 shifts
# -- memcpy --
# Arguments:
# a0: target address
# a1: source address (a0+4)
# a2: number of bytes
# Return: none
# Semantics:
# Copies the memory area [a1 to a1 + a2 - 1] to [a0 to a0 + a2 - 1]

memcpy_Lshift:
	sub    a0 2                 #creates 2 more spaces
	mv     t0 a0                # current target
	addi   a1 a0 4
	mv     t1 a1                # current source
	li     a2 18
	add    t2 a1 a2             # last source

mc_loop_Lshift:
# copy over 1 byte from source to target
	lbu    t4 0(t1)
	sb     t4 0(t0)
	addi   t0 t0 1
	addi   t1 t1 1
	bltu   t1 t2 mc_loop_Lshift # while current source != last



	addi   sp sp -4
	sw     ra 0(sp)
	mv     a0
	mv     a1

	call   int_to_buf

	lw     ra, 0(sp)



# after converting the Ascii code (DE) to numbers you store it in a0
	mv     a0

# -- int_to_buf --
# Arguments:
# a0: positive integer
# a1: target address
# a2: number of digits (counted from right)
# Return: none
# Semantics:
# Writes the last a2 digits of the positive integer in a0 as a decimal string to the memory area [a1 to a1 + a2 - 1]
int_to_buf:
	mv     t2 a1                # start to write to
	add    t3 a1 a2
	addi   t1 t3 -1             # end to write to (position of last char)
	mv     t0 a0                # keep number
	li     t5 10                # number base

# move from back to front
ib_loop:
# t0 = remainder
	mv     t3 t0
	div    t0 t0 t5             # gets 123 if a0 = 1234
	mul    t4 t0 t5             # multiplies 123 by 10 = 1230
# t3 = t3 - ((t3/10)*10)
# (extract last digit)
	sub    t3 t3 t4             # subtracting 1234- 1230 = 4 (which is last digit)

	addi   t3 t3 48             #(add 48 to store it as ascii in next line)
	sb     t3 0(t1)

	addi   t1 t1 -1
	bgeu   t1 t2 ib_loop

ib_return:
	jr     ra








	jr     ra
