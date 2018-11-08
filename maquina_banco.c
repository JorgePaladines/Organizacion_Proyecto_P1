#include<stdio.h>
#include <string.h>

int main(){
  int opcion;
  float saldo = 0;
  int flag = 1;

  while(flag){
    printf("Ingrese su opcion: \n");
    printf("1-Compra\n");
    printf("2-Retiro\n");
    printf("3-Depósito\n");
    printf("4-Verificar saldo disponible\n");
    printf("5-Salir\n");
    scanf("%d",&opcion);
    printf("\n");
    switch(opcion)
    {
      case 1:{ //COMPRAR ARTÍCULOS
        int cantidad;
        printf("Ingrese cantidad de artículos: ");
        scanf("%d",&cantidad);

        if(cantidad == 0){
          printf("No hay artículos en el inventario");
          printf("\n");
          break;
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

        float total = 0;
        for(int x = 0; x < cantidad; x++){
          total += inventario[x];
        }
        printf("TOTAL: $%.2f\n",total);

        if(total > saldo){
          printf("No tiene saldo suficiente en su cuenta\n");
        }
        else{
          saldo = saldo - total;
        }

        printf("\n");
        break;
      }
      case 2:{ //*RETIRO*//
        int withdraw;
        printf("Ingrese la cantidad que desea retirar: \n");
        scanf("%d",&withdraw);
        if(withdraw%10==0){
          if(saldo>=withdraw){
            saldo-=withdraw;
            printf("Cantidad despues del retiro es: %f dolares\n", saldo);
          }
          else{
            printf("No tiene suficiente saldo para realizar esta transacción\n");
          }
        }
        else{
          printf("El valor minimo de ingreso es $10. No disponemos de biletes de $5\n");
        }
        printf("\n");
        break;
      }

      case 3:{//*depositoO*//
        int deposito;
        printf("Ingrese cantidad a depositoar: \n");
        scanf("%d",&deposito);
        if(deposito%10==0){
          saldo=saldo+deposito;
          printf("Su saldo actual es de: %.2f dolares\n", saldo);
        }
        else{
          printf("El valor minimo de ingreso es $10 y debe ser divisible para 10\n");
        }
        printf("\n");
        break;
      }

      case 4:{//*SALDO DISPONIBLE*//
        printf("El saldo de su cuenta es: %.2f dolares\n", saldo);
        printf("\n");
        break;
      }
      
      case 5:{ //Salir
        flag = 0;
        printf("\n");
        break;
      }

      default:{
        printf("Ingrese una opcion valida\n");
        break;
      }
    }
  }


   printf("Gracias por usar el cajero automatico. Tenga un buen día.\n");
}