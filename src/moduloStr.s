	.data
	.globl modulo_str
	.text

# --- modulo_str ---
# Arguments:
# a0: start address of the buffer
# a1: number of bytes in the buffer
# a2: divisor
# Return:
# a0: the decimal number (encoded using ASCII digits '0' to '9') in the buffer [a0 to a0 + a1 - 1] modulo a2
modulo_str:
# TODO

	li     t1 1
	sub    t2 a1 t1          #length -1
	add    t3 a0 a1
	mv     a1 t3             #end adress of array


	li     a3 10             #x value assigned to a3

intialize_modulo_req:
	mv     t1 a0             # t1 = pointer, starts at base of array
	li     a0 0              # a0 = accumulator, intialized to 0
	j      modulo_head

Modulo_loop:
	lbu    t0 0(t1)          # load current(next) coefficient from memory into t0
	addi   t0 t0 -48

	mul    a0 a0 a3          # (x*y) = a
	rem    a0 a0 a2

	add    a0 a0 t0
	rem    a0 a0 a2          # (a mod b) mod c {c is the divisor}
	addi   t1 t1 1

modulo_head:
	bne    t1 a1 Modulo_loop # if pointer hasnt reached end loop again
	ret


	jr     ra
