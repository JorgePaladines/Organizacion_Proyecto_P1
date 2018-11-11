#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define DESCUENTO_AFI 0.95
#define IVA 1.12
/*
Funcion para imprimir el menú principal
*/

void printMenu()
{

	printf("******************BIENVENIDO AL SUPERMERCADO KOALA ELECTRONICO******************\n");
	printf("Opciones: \n");
	printf("1. Ingresar producto al carrito de compras\n");
	printf("2. Eliminar producto del carrito de compras\n");
	printf("3. Calcular total y aplicar descuento por afiliacion\n");
	printf("4. Efectuar pago & finalizar la compra actual\n");
	printf("5. Cerrar programa\n");
	

}


/*
Funcion para ingresar un producto al carrito,
toma dos punteros de arreglos para guardar la cantidad y el precio
retorna la cantidad total de artículos.
*/
void ingresarProductoCarrito(int * cantidad, double * precio, int size)
{


	for (int i=0; i<size; i++)
	{
		int index = i+1;
		int ctd = 0;
		double pr = 0.0;

		printf("Producto Nº %d \n",index);
		printf("Cantidad: \n");
		scanf ("%d", &ctd);
		fflush( stdin );
		printf("Precio: \n");
		scanf ("%lf", &pr);
		fflush( stdin );
		
		cantidad[i]=ctd;
		precio[i] = pr;
	
	}	

	printf("Productos ingresados exitosamente. \n")	;	

}



/*
Funcion para eliminar productos de un carrito mediante su índice
usa los punteros para encontrar el índice que se ingresó, 
cambia la cantidad y el precio del producto a 0. Retorna el nuevo tamaño 
del arreglo.
*/
int eliminarProductoCarrito(int size, int * cantidad, double * precio)
{
	int out_of_size = size + 1;
	
	int index = 0;

	printf ("Ingrese el numero del producto que desea eliminar del carrito \n");
	printf("Recuerde que tiene %d productos en su lista \n", size);

	scanf ("%d", &index);
	fflush( stdin );

	if (index < 1 || index > out_of_size)
	{
		do{
		
			printf("Índice no válido\n Ingrese un numero mayor (o igual) que 1 y menor (o igual a) %d\n", size);
			scanf ("%d", &index);
			fflush( stdin );

		}while (index < 1 || index > out_of_size);
	} 


	if ( index < out_of_size){

		for (int c = index - 1; c < size - 1; c++)
		{
			cantidad[c] = cantidad[c+1];
			precio[c] = precio [c+1];
		}
		printf("Producto Nº %d ha sido eliminado satisfactoriamente\n",index);

		printf("Detalle del carrito actual: \n");
		for (int d= 0; d< size - 1; d++)
		{
			printf("Producto Nº %d	|",d+1);
			printf("Cantidad: %d, Precio: %lf\n",cantidad[d], precio[d]);

		}

		
		printf("Total de productos: %d\n", size-1);

		return size - 1;	
			
	}

	else {

		printf("No se ha ejecutado acción alguna.\n");
		return size;
	}


}

/*
Funcion para calcular el total y aplicar descuento por afiliacion

	Toma el puntero de los precios y calcula el total, con IVA
Si es afiliado:
	* Toma el total y le resta el DESCUENTO_AFI (descuento de afiliado)
	* Retorna el total
Si no es afiliado:
	* Retorna el total
	
*/
double calcularTotal(int * cantidad,double * precio, int size)
{
	char afi;
	double total = 0.0;
	
	printf ("¿El cliente esta afiliado a SUPERMERCADOS KOALA? \n [1] Si [Cualquier Tecla] No \n");
	scanf (" %c", &afi);
	printf(">>Usted ha presionado %c\n",afi);
	printf("-------------Detalle de la compra--------------\n");
	
	for(int i=0; i<size; i++)
	{
		double precio_final = precio[i]*cantidad[i]*IVA;
		total+=precio_final;
		printf("Producto Nº %d	|Cantidad: %d 	|Precio: $%lf 	|Precio Final: $%lf\n", i+1,cantidad[i],precio[i], precio_final);
	}

	printf("Total: $%lf\n", total);


	if (afi =='1') 
	{
		double afi_total = total*DESCUENTO_AFI;
		printf ("Total con descuento: $%lf\n", afi_total );
		printf ("Usted ahorró %lf en esta compra por ser afiliado\n", total- afi_total);
		return (afi_total);

	}

	else return total;
	
}




/*
Funcion para ingresar la forma de pago & finalizar la compra

En efectivo:
	* pide el ingreso de la cantidad con la que pago el cliente
	*valida que la cantidad sea mayor al total
	* calcula el cambio

*/

int finalizarCompra(double total)
{
	double fp;	
	printf("Ingrese la cantidad a pagar en efectivo:\n");
	scanf (" %lf", &fp);
	if (fp<total){
		printf("La cantidad ingresada es insuficiente para realizar la compra\n");
		return 0;
	}
	else {	
	
		printf ("Su cambio es de $%lf\n", fp-total);
		return 1; 
	}
	

}





int main(void) 
{
	char opt = 'a';
	int * cantidades_productos;
	double * precios_productos;
	
	double total_precio = 0.0;
	int total_productos = 0;
	
	
	do{
		printMenu();
		scanf (" %c", &opt);
	    	switch(opt){

			case '1':
				
				printf(">>>>>>>>> INGRESO DE PRODUCTOS <<<<<<<<<\n");
				
				printf("Ingrese el numero de productos de la compra: ");

				scanf ("%d", &total_productos);
				fflush( stdin );

				if (total_productos < 1)
				{
					do{
						
						printf("Cantidad no válida\n");
						scanf ("%d", &total_productos);
						fflush( stdin );

					}while (total_productos < 1);
				} 
	
				cantidades_productos = (int*)calloc(total_productos, sizeof(int));
				precios_productos = (double*)calloc(total_productos, sizeof(double));
				
				ingresarProductoCarrito(cantidades_productos, precios_productos, total_productos);
				fflush( stdin );
				break;


			case '2':
				
				
				printf(">>>>>>>>> ELIMINACION DE PRODUCTOS<<<<<<<<<\n");
				total_productos = eliminarProductoCarrito(total_productos, cantidades_productos, precios_productos);
				fflush( stdin );
				
				break;

			case '3':

				printf(">>>>>>>>> CALCULAR TOTAL <<<<<<<<<\n");
				total_precio=calcularTotal(cantidades_productos, precios_productos,total_productos);
				break;

			case '4':

				printf(">>>>>>>>> EFECTUAR PAGO <<<<<<<<<\n");
				if (finalizarCompra(total_precio)==1){
					free (cantidades_productos);
					free (precios_productos);
				}

				
				break;

			case '5':
				printf("¡Hasta luego! Que tengas un bonito dia, fue un placer asistirte en tus compras.\n");
				
				break;

			default:
				
				printf("Opción no válida, ingrese un número entre el 1 y el 5 \n");
				scanf (" %c", &opt);
				
				

			    break;
    }

    }while(opt !='5');

    return 0;
}


