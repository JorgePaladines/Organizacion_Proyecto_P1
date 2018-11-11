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
espacio:		.asciiz "\n"

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
	li $v0, 4
	la $a0, espacio
	syscall
	
	jal ingresarProductoCarrito
	
	
	#Prueba de carga de datos
	li	$v0, 1
	la	$t0, cantidades_productos
	lw	$a0, 0($t0)
	syscall
	li	$v0, 3
	l.d	$f0, precios_producto
	add.d	$f12, $f0, $f10
	syscall
	
	li	$v0, 1
	la	$t0, cantidades_productos
	lw	$a0, 4($t0)
	syscall
	li	$v0, 3
	l.d	$f0, precios_producto+8
	add.d	$f12, $f0, $f10
	syscall
	
	li	$v0, 1
	la	$t0, cantidades_productos
	lw	$a0, 8($t0)
	syscall
	li	$v0, 3
	l.d	$f0, precios_producto+16
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
	.data
	str1:	.asciiz	"Ingrese el numero de productos de la compra: "
	str2:	.asciiz	"Cantidad no válida\n"
	str3:	.asciiz	"Producto Nº "
	str4: 	.asciiz "Cantidad: "
	str5:	.asciiz	"Precio: "
	str6:	.asciiz	"Productos ingresados exitosamente \n"
	
	
	.text
	#Guardar registros
	addi $sp, $sp, -36
	s.d $f0, 24($sp) #donde se guarda el input de cada precio
	sw $t6, 20($sp) #ctd
	sw $t5, 16($sp) #index
	sw $t0, 12($sp) #cantidad_productos
	sw $s1, 8($sp) #cantidades_productos
	sw $s2, 4($sp) #precios_producto
	sw $t2, 0($sp) #i del for
	
	
	#Obtener los arreglos para usarlos dentro de la función
	la $s1, cantidades_productos
	la $s2, precios_producto
	
	li $t0, 0 #int cantidad_productos = 0
	li $v0, 4
	la $a0, str1 #printf("Ingrese el numero de productos de la compra: ");
	syscall
	
	li $v0, 5 #scanf ("%d", &cantidad_productos);
	syscall
	add $t0, $v0, $0 #que el número ingresado por pantalla se guarde en $t0
	li $v0, 4
	la $a0, espacio
	syscall
	
	#validaicón de cantidad de productos
	while:
		slti $t1, $t0, 1
		beq $t1, $zero, noWhile
		li $v0, 4
		la $a0, str2 #printf("Cantidad no válida\n");
		syscall
		li $v0, 4
		la $a0, espacio
		syscall
		li $v0, 5 #scanf ("%d", &cantidad_productos);
		syscall
		add $t0, $v0, $0 #que el número ingresado por pantalla se guarde en $t0
		li $v0, 4
		la $a0, espacio
		syscall
		j while
	
	noWhile:
	li $t2, 0 #int i = 0
	
	For:
		slt $t1, $t2, $t0 # i < cantidad_productos
		beq $t1, $zero, finFor
		addi $t5, $t2, 1 #int index = i + 1;
		li $t6, 0 #int ctd = 0;
		
		li $v0, 4
		la $a0, str3 #Producto Nº 
		syscall
		li $v0, 1
		move $a0, $t5
		syscall
		li $v0, 4
		la $a0, espacio
		syscall
		
		la $a0, str4 #Cantidad: 
		syscall
		li $v0, 5 #scanf ("%d", &ctd);
		syscall
		addi $t6, $v0, 0 #ctd = scan
		
		li $v0, 4
		la $a0, str5 #"Precio: "
		syscall
		li $v0, 7
		syscall
		
		#guardar en los arreglos
		sll $t4, $t2, 2
		add $t4, $t4, $s1 #cantiidad[i]
		sw $t6, 0($t4) #cantidad[i] = ctd
		
		sll $t4, $t2, 3
		add $t4, $t4, $s2 #precio[i]
		s.d $f0, 0($t4)
		
		addi $t2, $t2, 1 #i++
		
		li $v0, 4
		la $a0, espacio
		syscall
		
		j For
		
	finFor:
	#Restaurar registros
	sw $t0, 0($sp)
	lw $t3, 4($sp)
	lw $t4, 8($sp)
	lw $t2, 12($sp)
	lw $t3, 16($sp) #index
	lw $t4, 20($sp) #ctd
	l.d $f0, 24($sp)
	addi $sp, $sp, 36
	jr $ra
