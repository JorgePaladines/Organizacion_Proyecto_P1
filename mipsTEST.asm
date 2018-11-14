.data
cantidades_productos:	.word	0:100 #Arreglo de 100 ints
precios_productos: 	.float	0.00:100 #Arreglo de 100 doubles con ceros
DESCUENTO_AFI:		.float	0.95
IVA:			.float	1.12
total_precio:		.float	0.00
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
str2:			.asciiz	"Cantidad no v�lida\n"
strcalcularTotal:	.asciiz ">>>>>>>>> CALCULAR TOTAL <<<<<<<<<\n"


.text
_start:	
	#Imprimir el men�
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
		addi $t0, $0, 0 #limpiar $t0
		
		li $v0, 4
		la $a0, ingresoDeProductos
		syscall
		la $a0, ingreseNumeroProductos
		syscall
		
		li $v0, 5 #scanf ("%d", &total_productos);
		syscall
		#----------------------
		lw $s7, total_productos
		addi $s7, $v0, 0
		sw $s7, total_productos
		
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
			
			jal _start

	OP2:
		addi $t0, $0, 0 #limpiar $t0
	
		la $s6, cantidades_productos #guardo la direccion del array en $s6
		l.s $f20, precios_productos #guardo la direccion del array en $f20
		lw $s7, total_productos #guardo size en $s7
		jal eliminarProducto #llamo a la funcion de eliminacion
		sw $s7, total_productos
		s.s $f20, precios_productos
		
		jal _start
	OP3:
		addi $t0, $0, 0 #limpiar $t0
	
		li $v0, 4
		la $a0, strcalcularTotal
		syscall
		
		la $a0, cantidades_productos
		la $a1, precios_productos
		lw $t0, total_productos
		addi $a2, $t0, 0
		jal calcularTotal
		s.s $f0, total_precio
		
		li $v0, 4
		la $a0, espacio
		syscall
		
		jal _start
	
	OP4:
		addi $t0, $0, 0 #limpiar $t0
	
	
		jal _start
	OP5:
		addi $t0, $0, 0 #limpiar $t0
	
	.data
		mensajeCierre:	.asciiz "�Hasta luego! Que tengas un bonito dia, fue un placer asistirte en tus compras.\n"
	.text
		li $v0, 4
		la $a0, mensajeCierre 
		syscall
		li $v0, 10
		syscall


#Impresi�n de opciones
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
	
#Opci�n 1: Ingresar producto
ingresarProductoCarrito:
	.data
	str3:	.asciiz	"Producto N� "
	str4: 	.asciiz "Cantidad: "
	str5:	.asciiz	"Precio: "
	str6:	.asciiz	"Productos ingresados exitosamente \n"
	
	
	.text
	#Guardar registros
	addi $sp, $sp, -36
	s.s $f4, 24($sp) #donde se guarda el input de cada precio
	sw $t6, 20($sp) #ctd
	sw $t5, 16($sp) #index
	sw $s3, 12($sp) #total_productos
	sw $s1, 8($sp) #cantidades_productos
	sw $s2, 4($sp) #precios_producto
	sw $t2, 0($sp) #i del for
	
	
	
	#Obtener los arreglos para usarlos dentro de la funci�n
	la $s1, ($a0) #cantidad
	la $s2, ($a1) #precio
	la $s3, ($a2) #size

	
	
	li $t2, 0 #int i = 0
	For:
		slt $t1, $t2, $s3 # i < cantidad_productos
		beq $t1, $zero, finFor
		addi $t5, $t2, 1 #int index = i + 1;
		li $t6, 0 #int ctd = 0;
		
		li $v0, 4
		la $a0, str3 #Producto N� 
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
		li $v0, 6
		syscall
		
		#guardar en los arreglos
		sll $t4, $t2, 2
		add $t4, $t4, $s1 #cantiidad[i]
		sw $t6, 0($t4) #cantidad[i] = ctd
		
		sll $t4, $t2, 2
		add $t4, $t4, $s2 #precio[i]
		s.s $f0, 0($t4) #precio[i] = pr
		
		addi $t2, $t2, 1 #i++
		
		li $v0, 4
		la $a0, espacio
		syscall
		
		j For
		
	finFor:
		sw $s3, total_productos #guardar el tama�o del carrito, el cual la �ltima vez que se puso fue en $s3
		#Restaurar registros
		lw $t2, 0($sp)
		lw $s2, 4($sp)
		lw $s1, 8($sp)
		lw $s3, 12($sp)
		lw $t5, 16($sp) #index
		lw $t6, 20($sp) #ctd
		l.s $f4, 24($sp)
		addi $sp, $sp, 36
		jr $ra


####ELIMINAR ELEMENTO DEL CARRITO MEDIANTE INDICE
#########################################################################################
#	Funcion para eliminar productos de un carrito mediante su índice		#
#	usa los punteros para encontrar el índice que se ingresó, 			#
#	cambia la cantidad y el precio del producto a 0. Retorna el nuevo tamaño	#
#	del arreglo.									#
#########################################################################################

eliminarProducto: 
		.data
			print0: 	.asciiz ">>>>>>>>>>ELIMINAR PRODUCTO<<<<<<<<<<<<< \n"
			print11: 	.asciiz "No hay productos en el carrito \n"
			print1:		.asciiz "Ingrese el numero del producto que desea eliminar del carrito \n"
			print21:	.asciiz "Recuerde que tiene "
			print22:	.asciiz " producto(s) en su lista \n"
			print3: 	.asciiz "Producto N� "
			print30: 	.asciiz "No se ha"
			print31:	.asciiz " eliminado, volviendo al men� principal\n"

		.text
			#espacio en el stack
			addi $sp, $sp, -4
			sw $ra, 4($sp)
			
			beqz $s7, zeroelem
			#inicializacion de variables
			
			#int out_of_size = size +1
			addi $t0, $s7, 1
			#int index = $t1 = 0
			addi $t1, $zero, 0
			
			
			#printf (">>>>>>>>>>ELIMINAR PRODUCTO<<<<<<<<<<<<< \n");
			
			li $v0, 4 #instruccion para imprimir string
			la $a0, print0 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			#printf ("Ingrese el numero del producto que desea eliminar del carrito \n");		
			li $v0, 4 #instruccion para imprimir string
			la $a0, print1 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			#printf("Recuerde que tiene %d productos en su lista \n", size);
			
			li $v0, 4 #instruccion para imprimir string
			la $a0, print21 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			li $v0, 1 #instruccion para imprimir int
			la $a0, 0($s7) #guardo direccion del int
			syscall #imprimo el int
			
			li $v0, 4 #instruccion para imprimir string
			la $a0, print22 #guardo direccion del int
			syscall #imprimo el string
			
			li $v0, 5 #scanf ("%d", );
			syscall

			#guardo el valor del user input en index
			add $t1, $v0, $t1
			#if index < out_of_size
			blt $t1, $t0, delete
		end:	
			li $v0, 4 #instruccion para imprimir string
			la $a0, print30 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			#printf ("No se ha eliminado\n");		
			li $v0, 4 #instruccion para imprimir string
			la $a0, print31 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			lw $ra, 4($sp)
			addi $sp, $sp, 4
			jr $ra #retorno al main
		zeroelem:
			li $v0, 4 #instruccion para imprimir string
			la $a0, print11 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			lw $ra, 4($sp)
			addi $sp, $sp, 4
			jr $ra #retorno al main	
		
		delete:
			blt $t1, $0, end
			beqz $t1, end
			addi $t2, $t1, -1#int c=index -1
			addi $t3, $s7, -1#size-1
			la $a0, ($s6) #cargo la direccion de $s6 en $a0
			move $t0, $zero
		fordel: 
			
			beq $t2, $t3, successdeletion
			#for int c=index -1; c < size - 1; c++
			sll $t4, $t2, 2 #$t4=$t2*4
			add $t5, $a0, $t4 #$t5=$s6+$t4; &cantidad [c]
			addi $t0, $t5, 4 #&cantidad [c+i]
			lw $t7, ($t0) #cantidad [c+1]
			sw $t7, ($t5) #cantidad [c] = cantidad [c+1]
			sw $0, ($t0) #cantidad [c+1] = 0
			
			addi $t2,$t2,1
			
			
			#cantidad [c] = cantidad [c+1]
			#precio [c] = precio [c+1] 
			
		successdeletion:
			addi $s7, $s7, -1 #size = size - 1
			
			li $v0, 4 #instruccion para imprimir string
			la $a0, print3 #guardo direccion del string en $a0
			syscall #imprimo el string
					
			li $v0, 1 #instruccion para imprimir int
			la $a0, 0($t1) #guardo direccion del int
			syscall #imprimo el int
			
			#printf
			li $v0, 4 #instruccion para imprimir string
			la $a0, print31 #guardo direccion del string en $a0
			syscall #imprimo el string
			
			lw $ra, 4($sp)
			addi $sp, $sp, 4
			
			jr $ra #retorno al main



#Opci�n 3: Calcular Total
calcularTotal:
	.data
		str1cal:	.asciiz	"�El cliente esta afiliado a SUPERMERCADOS KOALA? \n [1] Si [Cualquier Tecla] No \n"
		str2cal:	.asciiz	">>Usted ha presionado "
		str3cal:	.asciiz	"-------------Detalle de la compra--------------\n"
		str4cal:	.asciiz	"Producto N� "
		str5cal:	.asciiz	"	|Cantidad: "
		str6cal:	.asciiz	" 	|Precio: $"
		str7cal:	.asciiz	" 	|Precio Final: $"
		str8cal:	.asciiz "Total: $"
		str9cal:	.asciiz "Total con descuento: $"
		str10cal:	.asciiz "Usted ahorr� "
		str11cal:	.asciiz " en esta compra por ser afiliado\n"
		afi:		.space	4
		opAfi:		.byte	'1'
	.text
		#Guardar registros
		addi $sp, $sp, -44
		sw $t6, 40($sp)
		s.s $f9, 36($sp)
		sw $t5, 32($sp)
		s.s $f4, 28($sp)
		sw $t7, 24($sp)
		sw $t2, 20($sp)
		s.s $f5, 16($sp)
		s.s $f6, 12($sp)
		s.s $f7, 8($sp)
		s.s $f8, 4($sp)
		s.s $f10, 0($sp)
		
		
		
		la $t5, 0($a0) #cantidad
		la $t6, 0($a1) #precio
		la $t7, 0($a2) #size
		
		li $v0, 4
		la $a0, str1cal #"�El cliente esta afiliado a SUPERMERCADOS KOALA? \n [1] Si [Cualquier Tecla] No \n"
		syscall
		
		li $v0, 8 #scanf (" %c", &afi);
		la $a0, afi
		li $a1, 4
		syscall
		
		li $v0, 4
		la $a0, str2cal #">>Usted ha presionado "
		syscall
		la $a0, afi
		syscall
		
		li $v0, 4
		la $a0, espacio
		syscall
		la $a0, str3cal #"-------------Detalle de la compra--------------\n"
		syscall
		
		li $t2, 0 #int i = 0
		add.s $f7, $f19, $f18 #total = 0.0
		calFor:
			slt $t1, $t2, $t7 # i < size
			beq $t1, $zero, calfinFor
			
			sll $t0, $t2, 2 # i * 4
			sll $t1, $t2, 2 # i * 4
			
			add $t0, $t0, $t5 #cantidad[i]
			lwc1 $f11, 0($t0)
			cvt.s.w $f11, $f11
			
			add $t1, $t1, $t6 #precio[i]
			lwc1 $f5, 0($t1) #leer el float
			
			l.s $f8, IVA 
			
			#$f11 = cantidad[i], $f5 = precio[i], $f8 = IVA = 1.12
			add.s $f6, $f18, $f19 #precio_final = 0
			mul.s $f6, $f11, $f5 #precio[i]*cantidad[i]
			mul.s $f6, $f6, $f8 #precio[i]*cantidad[i]*IVA
			add.s $f7, $f7, $f6 #total += precio_final;
			
			#$t0 = cantidad[i] como entero
			#$f5 = precio[i]
			#$f6 = precio_final
			#$f7 = total
			
			#"Producto N� "
			li $v0, 4
			la $a0, str4cal
			syscall
			#n�mero del producto
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
			li $v0, 2
			add.s $f12, $f5, $f17
			syscall
			#" 	|Precio Final: $"
			li $v0, 4
			la $a0, str7cal
			syscall
			#precio_final
			li $v0, 2
			add.s $f12, $f6, $f19
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
		li $v0, 2
		add.s $f12, $f7, $f19
		syscall #printf("Total: $%lf\n", total);
		li $v0, 4
		la $a0, espacio
		syscall
		
		move $t4, $zero
		move $t5, $zero
		
		lb $t4, afi
		li $t5, 1
		
		bne $t4, $t5, afiNoIgual1
		l.s $f9, DESCUENTO_AFI
		
		mul.s $f8, $f7, $f9 #$f8 = afi_total
		li $v0, 4
		la $a0, str9cal #"Total con descuento: $"
		syscall
		li $v0, 2
		add.s $f12, $f8, $f19
		syscall
		li $v0, 4
		la $a0, espacio
		syscall
		la $a0, str10cal #"Usted ahorr� "
		syscall
		
		li $v0, 2
		sub.s $f12, $f7, $f8 #total - afi_total
		syscall
		li $v0, 4
		la $a0, str11cal #" en esta compra por ser afiliado\n"
		syscall
		
		#return (afi_total);
		add.s $f0, $f7, $f19
		
		afiNoIgual1:
			#else return total;
			add.s $f0, $f7, $f19
		
		l.s $f10, 0($sp)
		l.s $f8, 4($sp)
		l.s $f7, 8($sp)
		l.s $f6, 12($sp)
		l.s $f5, 16($sp)
		lw $t2, 20($sp)
		lw $t7, 24($sp)
		l.s $f4, 28($sp)
		lw $t5, 32($sp)
		l.s $f9, 36($sp)
		lw $t6, 40($sp)
		addi $sp, $sp, 44
		
		jr $ra












