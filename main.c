#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void) {
    printf("Ingrese cantidad de artículos: ");
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


    return 0;
}