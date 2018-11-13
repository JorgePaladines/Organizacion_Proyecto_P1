.data
cantidades_productos:	.word	0:100 #Arreglo de 100 ints
precios_productos: 	.double	0.00:100 #Arreglo de 100 doubles con ceros
DESCUENTO_AFI:		.double 0.95
IVA:			.double	1.12
total_precio:		.double	0.00
total_productos:	.word	0

mensajeInicial1:	.asciiz "******************BIENVENIDO AL SUPERMERCADO KOALA ELECTRONICO******************\n"
mensajeInicial2:	.asciiz "Opciones: \n"
op1:			.asciiz	"1. Ingresar producto al carrito de compras\n"
op2:			.asciiz	"2. Eliminar producto del carrito de compras\n"
op3:			.asciiz	"3. Calcular total y aplicar descuento por afiliacion\n"
op4:			.asciiz	"4. Ingresar forma de pago & finalizar la compra actual\n"
op5:			.asciiz	"5. Cerrar programa\n"
espacio:		.asciiz "\n"
ingresoDeProductos:	.asciiz ">>>>>>>>> INGRESO DE PRODUCTOS <<<<<<<<<\n"
ingreseNumeroProductos:	.asciiz "Ingrese el numero de productos de la compra: "
str2:			.asciiz	"Cantidad no válida\n"
strcalcularTotal:	.asciiz ">>>>>>>>> CALCULAR TOTAL <<<<<<<<<\n"


.text
_start:	
	#Imprimir el menú
	jal printMenu
	
	#input de la opción
	li	$v0, 5
	syscall
	#guardar la opcion
	move	$t0, $v0	#guardar la opcion escogida
	li $v0, 4
	la $a0, espacio
	syscall
	
	beq $t0, 1, OP1
	beq $t0, 2, OP2
	beq $t0, 3, OP3
	beq $t0, 4, OP4
	beq $t0, 5, OP5
	
	OP1:
		li $v0, 4
		la $a0, ingresoDeProductos
		syscall
		la $a0, ingreseNumeroProductos
		syscall
		
		li $v0, 5 #scanf ("%d", &total_productos);
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
			li $v0, 5 #scanf ("%d", &total_productos);
			syscall
			add $t0, $v0, $0 #que el número ingresado por pantalla se guarde en $t0
			li $v0, 4
			la $a0, espacio
			syscall
			j while
		
		noWhile:
			sw $t0, total_productos
			la $a0, cantidades_productos
			la $a1, precios_productos
			addi $a2, $t0, 0
			jal ingresarProductoCarrito

	OP2:
	
	OP3:
		li $v0, 4
		la $a0, strcalcularTotal
		syscall
		
		la $a0, cantidades_productos
		la $a1, precios_productos
		sw $t0, total_productos
		addi $a2, $t0, 0
		jal calcularTotal
		s.d $f0, total_precio
	
	OP4:
	
	
	OP5:
	.data
		mensajeCierre:	.asciiz "¡Hasta luego! Que tengas un bonito dia, fue un placer asistirte en tus compras.\n"
	.text
		li $v0, 4
		la $a0, mensajeCierre 
		syscall
		li $v0, 10
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
	sw $s3, 12($sp) #total_productos
	sw $s1, 8($sp) #cantidades_productos
	sw $s2, 4($sp) #precios_producto
	sw $t2, 0($sp) #i del for
	
	
	#Obtener los arreglos para usarlos dentro de la función
	la $s1, 0($a0) #cantidad
	la $s2, 0($a1) #precio
	la $s3, 0($a2) #size
	
	
	li $t2, 0 #int i = 0
	For:
		slt $t1, $t2, $s3 # i < cantidad_productos
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
		s.d $f0, 0($t4) #precio[i] = pr
		
		addi $t2, $t2, 1 #i++
		
		li $v0, 4
		la $a0, espacio
		syscall
		
		j For
		
	finFor:
		#Restaurar registros
		lw $t2, 0($sp)
		lw $s2, 4($sp)
		lw $s1, 8($sp)
		lw $s3, 12($sp)
		lw $t5, 16($sp) #index
		lw $t6, 20($sp) #ctd
		l.d $f0, 24($sp)
		addi $sp, $sp, 36
		jr $ra


#Opción 3: Calcular Total
calcularTotal:
	.data
		str1cal:	.asciiz	"¿El cliente esta afiliado a SUPERMERCADOS KOALA? \n [1] Si [Cualquier Tecla] No \n"
		str2cal:	.asciiz	">>Usted ha presionado "
		str3cal:	.asciiz	"-------------Detalle de la compra--------------\n"
		str4cal:	.asciiz	"Producto Nº "
		str5cal:	.asciiz	"	|Cantidad: "
		str6cal:	.asciiz	" 	|Precio: $"
		str7cal:	.asciiz	" 	|Precio Final: $"
		str8cal:	.asciiz "Total: $"
		str9cal:	.asciiz "Total con descuento: $"
		str10cal:	.asciiz "Usted ahorró "
		str11cal:	.asciiz " en esta compra por ser afiliado\n"
		afi:		.space	4
		opAfi:		.byte	'1'
	.text
		
		la $s1, 0($a0) #cantidad
		l.d $f0, 0($a1) #precio
		la $s3, 0($a2) #size
		
		li $v0, 4
		la $a0, str1cal #"¿El cliente esta afiliado a SUPERMERCADOS KOALA? \n [1] Si [Cualquier Tecla] No \n"
		syscall
		
		li $v0, 8 #scanf (" %c", &afi);
		la $a0, afi
		li $a1, 4
		syscall
		
		li $v0, 4
		la $a0, str2cal #">>Usted ha presionado "
		syscall
		lb $a0, afi
		syscall
		
		li $v0, 4
		la $a0, espacio
		syscall
		la $a0, str3cal #"-------------Detalle de la compra--------------\n"
		syscall
		
		li $t2, 0 #int i = 0
		li $v0, 4
		la $a0, afi
		syscall
		calFor:
			slt $t1, $t2, $s3 # i < size
			beq $t1, $zero, calfinFor
			
			sll $t0, $t2, 2 # i * 4
			sll $t1, $t2, 3 # i * 4
			add $t0, $t0, $s1 #cantidad[i]
			mtc1.d $t0, $f2
  			cvt.d.w $f2, $f2 #convertir cantidad[i] a un double
			add.d $f4, $f4, $f0 #precio[i]
			
			#$f2 = cantidad[i], $f4 = precio[i], IVA = iva = 1.12
			
			mul.d $f6, $f2, $f4 #precio[i]*cantidad[i]
			l.d $f8, IVA 
			mul.d $f6, $f6, $f8 #precio[i]*cantidad[i]*IVA
			add.d $f14, $f24, $f6 #total += precio_final;
			
			#$t0 = cantidad[i] como entero
			#$f4 = precio[i]
			#$f6 = precio_final
			#$f14 = total
			
			#"Producto Nº "
			li $v0, 4
			la $a0, str4cal
			syscall
			#número del producto
			li $v0, 1
			addi $a0, $t2, 1
			syscall
			#"	|Cantidad: "
			li $v0, 4
			la $a0, str5cal
			syscall
			#cantidad de productos
			li $v0, 1
			lw $a0, 0($t0)
			syscall
			#" 	|Precio: $"
			li $v0, 4
			la $a0, str6cal 
			syscall
			#precio del producto
			li $v0, 3
			add.d $f12, $f4, $f24
			syscall
			#" 	|Precio Final: $"
			li $v0, 4
			la $a0, str7cal
			syscall
			#precio_final
			li $v0, 3
			add.d $f12, $f14, $f24
			syscall
			
			li $v0, 4
			la $a0, espacio
			syscall
			
			addi $t2, $t2, 1 #i++
			j calFor
			
		calfinFor:
		li $v0, 4
		la $a0, str8cal #"Total: $"
		syscall
		li $v0, 3
		add.d $f12, $f14, $f24
		syscall #printf("Total: $%lf\n", total);
		li $v0, 4
		la $a0, espacio
		syscall
		
		lw $s4, afi
		lw $s5, opAfi
		bne $s4, $s5, afiNoIgual1
		
		li $v0, 4
		lb $a0, afi
		syscall
		la $a0, opAfi
		syscall
		
		afiNoIgual1:
			
		
		jr $ra
