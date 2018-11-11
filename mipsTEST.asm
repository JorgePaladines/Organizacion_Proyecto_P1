			.data
opcion:			.word	'a'
cantidades_productos:	.space	400 #Arreglo de 100 ints
precios_producto: 	.double	0.00:100 #Arreglo de 100 doubles con ceros

mensajeInicial1:	.asciiz "******************BIENVENIDO AL SUPERMERCADO KOALA ELECTRONICO******************\n"
mensajeInicial2:	.asciiz "Opciones: \n"
op1:			.asciiz	"1. Ingresar producto al carrito de compras\n"
op2:			.asciiz	"2. Eliminar producto del carrito de compras\n"
op3:			.asciiz	"3. Calcular total y aplicar descuento por afiliacion\n"
op4:			.asciiz	"4. Ingresar forma de pago & finalizar la compra actual\n"
op5:			.asciiz	"5. Cerrar programa\n"

			.text


_start:	
	#Imprimir el menú
	jal printMenu
	
	#input de la opción
	li	$v0, 5
	syscall
	#guardar la opcion
	sb	$v0, opcion	#guardar la opcion escogida
	lb	$t0, opcion	#colocarla en variable temporal para su uso
	
	jal ingresarProductoCarrito
	
	
	#Prueba de carga de datos
	li	$v0, 1
	la	$t0, cantidades_productos
	lw	$a0, 0($t0)
	syscall
	lw	$a0, 4($t0)
	syscall
	
	li	$v0, 3
	l.d	$f0, precios_producto
	add.d	$f12, $f0, $f10
	syscall
	l.d	$f0, precios_producto+8
	add.d	$f12, $f0, $f10
	syscall

	
	li	$v0, 10
	syscall


#Impresión de opciones
printMenu:
	li	$v0, 4
	la	$a0, mensajeInicial1
	syscall
	li	$v0, 4
	la	$a0, mensajeInicial2
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

	jr $ra
	
#Opción 1: Ingresar producto
ingresarProductoCarrito:
	addi $sp, $sp, -20
	sw $t3, 16($sp)
	sw $t4, 12($sp)
	sw $t2, 8($sp)
	s.d $f0, 0($sp)
	
	la $t3, cantidades_productos
	la $t4, precios_producto

	li $t2, 10
	sw $t2, 0($t3)
	li $t2, 20
	sw $t2, 4($t3)
	
	li $v0, 7
	syscall
	s.d $f0, ($t4)
	
	li $v0, 7
	syscall
	addi $t4, $t4, 8
	s.d $f0, ($t4)

	
	jr $ra