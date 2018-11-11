#include <stdio.h>
#include <stdlib.h>
#include <string.h>

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
	printf("4. Ingresar forma de pago & finalizar la compra actual\n");
	printf("5. Cerrar programa\n");
	

}


/*
Funcion para ingresar un producto al carrito,
toma dos punteros de arreglos para guardar la cantidad y el precio
retorna la cantidad total de artículos.
*/
int ingresarProductoCarrito(int * cantidad, double * precio)
{

	
	int cantidad_productos=0;
	
	printf("Ingrese el numero de productos de la compra: ");
	scanf ("%d", &cantidad_productos);
	if (cantidad_productos < 1)
	{
		do{
		
			printf("Cantidad no válida\n");
			scanf ("%d", &cantidad_productos);

		}while (cantidad_productos < 1);
	} 	
	

	cantidad = (int*)calloc(cantidad_productos, sizeof(int));
	precio = (double*)calloc(cantidad_productos, sizeof(double));

	for (int i=0; i<cantidad_productos; i++)
	{
		int index = i+1;
		int ctd = 0;
		double pr = 0.0;

		printf("Producto Nº %d \n",index);
		printf("Cantidad: \n");
		scanf ("%d", &ctd);
		printf("Precio: \n");
		scanf ("%lf", &pr);
		
		cantidad[i]=ctd;
		precio[i] = pr;
	
	}	

	printf("Productos ingresados exitosamente. \n")	;	
	

	return cantidad_productos;
}



/*
Funcion para eliminar productos de un carrito mediante su índice
*/
void eliminarProductoCarrito(int index)
{


}

/*
Funcion para calcular el total y aplicar descuento por afiliacion

	Toma el puntero de los precios y calcula el total, con iva
Si es afiliado:
	* Toma el total y le resta el 5%
	* Retorna el total
Si no es afiliado:
	* Retorna el total
	
*/
double calcularTotal(int * precio)
{

	return 0.0;
}

/*
Funcion para ingresar la forma de pago & finalizar la compra

Si es en efectivo:
	* pide el ingreso de la cantidad con la que pago el cliente
	* calcula el cambio
		>si el cambio es negativo:
			* le pide al cajero que vuelva a ingresar la cantidad
			con la que pago el cliente 
Si es con tarjeta:
	* pide el ingreso del numero de tarjeta

Pregunta al cajero si desea realizar mas compras
	Retorna 1, si el cajero responde si
	Retorna 0, si el cajero responde no
*/

int finalizarCompra(double total)
{
	return 0;

}





int main(void) 
{
	char opt = 'a';
	int * cantidades_productos;
	double * precios_productos;
	do{
		printMenu();
		scanf ("%c", &opt);

	    	switch(opt){

			case '1':
				
				printf(">>>>>>>>> INGRESO DE PRODUCTOS <<<<<<<<<\n");
				ingresarProductoCarrito(cantidades_productos, precios_productos);

				break;
			case '2':
				
				
				printf(">>>>>>>>> ELIMINACION DE PRODUCTOS<<<<<<<<<\n");

				break;

			case '3':

				printf(">>>>>>>>> CALCULAR TOTAL <<<<<<<<<\n");
			
				break;

			case '4':

				printf(">>>>>>>>> EFECTUAR PAGO <<<<<<<<<\n");

				break;

			case '5':
				printf("¡Hasta luego! Que tengas un bonito dia, fue un placer asistirte en tus compras.\n");
				free (cantidades_productos);
				free (precios_productos);
				
				break;

			default:

				printf("Opción no válida, ingrese un número entre el 1 y el 5 \n");
				scanf ("%c", &opt);

			    break;
    }

    }while(opt !='5');




/**
    char c[10] = {0};
    fgets(c,10,stdin);
    int cantidad = 0;
    sscanf(c, "%d", &cantidad);
    //printf("%d\n",cantidad);

    if(cantidad == 0){
        printf("No hay artículos en el inventario");
        exit(0);
    }

    float inventario[cantidad];
    memset(inventario, 0, cantidad*sizeof(int));

    printf("\n");
    for(int i = 0; i < cantidad; i++){
        printf("Precio del artículo N° %d: ", i+1);
        float valor;
        scanf("%f",&valor);
        valor = valor * 1.12;
        inventario[i] += valor;
    }

    printf("\n");
    printf("Valores Finales (+IVA del %%12):\n");
    for(int a = 0; a < cantidad; a++){
        printf("-> $%.2f\n",inventario[a]);
    }
    printf("\n");

    float total = 0;
    for(int x = 0; x < cantidad; x++){
        total += inventario[x];
    }
    printf("TOTAL: $%.2f\n",total);

**/
    return 0;
}


