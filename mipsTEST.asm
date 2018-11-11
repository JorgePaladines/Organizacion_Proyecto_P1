	.data
opcion:	.word	0
saldo:	.word	0
flag:	.word	1
mensajeInicial:	.asciiz "Ingrese su opcion: \n"
op1:	.asciiz	"1-Compra\n"
op2:	.asciiz	"2-Retiro\n"
op3:	.asciiz	"3-Depósito\n"
op4:	.asciiz	"4-Verificar saldo disponible\n"
op5:	.asciiz	"5-Salir\n"

	.text
main:
	#Inicialización de las variables
	li	$t0, 1
	sw	$t0, flag	#guardar flag = 1
	li	$t0, 0
	sw	$t0, saldo	#guardar saldo = 0

	#Impresión de opciones
	li	$v0, 4
	la	$a0, mensajeInicial
	syscall
	la	$a0, op1
	syscall
	la	$a0, op2
	syscall
	la	$a0, op3
	syscall
	la	$a0, op4
	syscall
	la	$a0, op5
	syscall
	
	#input de la opción
	li	$v0, 5
	syscall
	#guardar la opcion
	sb	$v0, opcion	#guardar la opcion escogida
	lb	$t0, opcion	#colocarla en variable temporal para su uso
	li	$v0, 1
	move	$a0, $t0
	syscall




	
	li	$v0, 10
	syscall
	