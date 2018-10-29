/*
Extraido de:
http://www.cprograms4future.com/p/atm-machine.html
*/
#include<stdio.h>


int main()
{
 int choice;
 float cash=0;
 


  	printf("Ingrese su opcion: \n1-Retiro\n2-Deposito\n3-Verificar saldo disponible\n");
 	scanf("%d",&choice);
	 switch(choice)
	 {
	  case 1:
	  {

//*RETIRO*//
	   int withdraw;
	   printf("Ingrese la cantidad que desea retirar: \n");
	   scanf("%d",&withdraw);
	   if(withdraw%10==0)
	   {
	    if(cash>=withdraw)
		{
		cash-=withdraw;
		printf("Cantidad despues del retiro es: %f dolares\n",cash);
	       }
	       else
	    {
	    printf("No tiene suficiente saldo para realizar esta transacción\n");
		}
	   }
	   else
	   {
	    printf("El valor minimo de ingreso es $10. No disponemos de biletes de $5\n");
	   }
	   break;
	  }


	  case 2:
	  {
//*DEPOSITO*//
	   int deposit;
	   printf("Ingrese cantidad a depositar: \n");
	   scanf("%d",&deposit);
	   if(deposit%10==0)
	   {
	       cash=cash+deposit;
	       printf("Su saldo actual es de: %f dolares\n",cash);
	   }
	   else
	   {
	    printf("El valor minimo de ingreso es $10\n");
	   }
	   break;
	  }
	  case 3:
//*SALDO DISPONIBLE*//
	  {
	   printf("El saldo de su cuenta es: %.2f dolares\n",cash);
	   break;
	  }
	  default :
	  {
	   printf("Ingrese una opcion valida\n");
	   break;
	  }
	 }
	


   printf("Gracias por usar el cajero automatico. Tenga usted un buen día.\n");
}
