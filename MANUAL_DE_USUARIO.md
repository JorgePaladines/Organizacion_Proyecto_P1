# Organizacion_Proyecto_P1
## Proyecto de primer parcial de Organización de Computadores
### Integrantes
	Jorge Paladines
	Daniela Montenegro
## Manual de uso
	
### Cómo compilar:

Abra el terminal de linux con ctrl+alt+t

#### Para usar el cajero de supermercado (en C):
 Compile con:
`gcc -Wall main.c -o super`

y despues ejecute el programa con `./super` 


#### Cómo usar el cajero de supermercado (en MIPS Assembly):

Abra Mars 4.5 
	> En linux, abra la consola y ejecute: 
		`java -jar Mars4_5.jar`
	> En windows:
		Haga doble clic en Mars4_5.jar
Haga clic en "Abrir" y seleccione el archivo _mipsTEST.asm_

		
### Opciones del programa:

	1. Ingresar producto al carrito de compras

Funcion para ingresar un producto al carrito, toma dos punteros de arreglos para guardar la cantidad y el precio
retorna la cantidad total de artículos.


	2. Eliminar producto del carrito de compras

Funcion para eliminar productos de un carrito mediante su índice, usa los punteros para encontrar el índice que se ingresó, cambia la cantidad y el precio del producto a 0. Retorna el nuevo tamaño del arreglo.

	3. Calcular total y aplicar descuento por afiliacion

Funcion para calcular el total y aplicar descuento por afiliacion, retorna el total a pagar
Toma el puntero de los precios y calcula el total, con IVA
Si es afiliado:
	* Toma el total y le resta el DESCUENTO_AFI (descuento de afiliado)
	* Retorna el total
Si no es afiliado:
	* Retorna el total
	
	4. Efectuar pago & finalizar la compra actual

Funcion para ingresar la forma de pago & finalizar la compra

En efectivo:
	* pide el ingreso de la cantidad con la que pago el cliente
	*valida que la cantidad sea mayor al total
	* calcula el cambio

	5. Cerrar programa

Envia un mensaje de despedida y cierra el programa


	

