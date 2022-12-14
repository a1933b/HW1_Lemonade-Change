#include <stdio.h>
#include <stdbool.h>
bool LemonadeChange(int* bills, int billsSize){
    int bill_5 = 0;
    int bill_10 = 0;
    int bill_20 = 0;
    
    for(int i = 0; i < billsSize; i++){
        if(bills[i] == 5){
            bill_5 ++;
        }else if(bills[i] == 10){
            if(bill_5<1)  return false;
            bill_5 --;
            bill_10 ++;
        }else{
            if(bill_10 > 0 && bill_5 > 0){
            	bill_5 --;
                bill_10 --; 
                bill_20 ++;      
            }else if(bill_5 > 2){ 
            	bill_5 = bill_5 - 3;
                bill_20 ++;    
			}else{
                return false;  
            }
        }
    }
    return true;
}
int main(int argc, char*argv[]){
	int test1[5] = {5,5,5,10,20};
	int test2[5] = {5,5,10,10,20};
	int test3[10] = {5,5,5,10,5,5,10,20,20,20};
	int size1 = 5;
	int size2 = 5;
	int size3 = 10;
	int j = 0;
	
	printf("Test 1: ");
	for(j = 0; j < size1; j++)
		printf("%d ",test1[j]);
	if(LemonadeChange(test1, size1) == true)   printf(" Ans : true \n");
	else   printf(" Ans : false \n");
		
	
	printf("Test 2: ");
	for(j = 0; j < size2; j++)
		printf("%d ",test2[j]);
	if(LemonadeChange(test2, size2) == true)   printf(" Ans : true \n");
	else   printf(" Ans : false \n");
		
		
	printf("Test 3: ");
	for(j = 0; j < size3; j++)
		printf("%d ",test3[j]);
	if(LemonadeChange(test3, size3) == true)   printf(" Ans : true \n");
	else   printf(" Ans : false \n");
}
