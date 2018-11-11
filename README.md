# Organizacion_Proyecto_P1
# Manual de uso

## Proyecto de primer parcial de Organización de Computadores

### Cómo compilar:


Abra el terminal de linux con ctrl+alt+t

#### Para usar el cajero de supermercado (en C):
 Compile con:
`gcc -Wall main.c -o super`

y despues ejecute el programa con `./super` 


*Opciones:*

	_1. Ingresar producto al carrito de compras_

Funcion para ingresar un producto al carrito,
toma dos punteros de arreglos para guardar la cantidad y el precio
retorna la cantidad total de artículos.


	_2. Eliminar producto del carrito de compras_

Funcion para eliminar productos de un carrito mediante su índice
usa los punteros para encontrar el índice que se ingresó, 
cambia la cantidad y el precio del producto a 0. Retorna el nuevo tamaño 
del arreglo.

	_3. Calcular total y aplicar descuento por afiliacion_

Funcion para calcular el total y aplicar descuento por afiliacion

	Toma el puntero de los precios y calcula el total, con IVA
Si es afiliado:
	* Toma el total y le resta el DESCUENTO_AFI (descuento de afiliado)
	* Retorna el total
Si no es afiliado:
	* Retorna el total
	
	_4. Efectuar pago & finalizar la compra actual_

Funcion para ingresar la forma de pago & finalizar la compra

En efectivo:
	* pide el ingreso de la cantidad con la que pago el cliente
	*valida que la cantidad sea mayor al total
	* calcula el cambio

	_5. Cerrar programa_

	Cierra el programa


#### Cómo usar el cajero de supermercado (en MIPS Assembly):

