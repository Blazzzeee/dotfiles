#include <stdio.h>

struct stack{
    int size;
    struct stack *stack;
    int* arr;
};


void main(){
    struct stack *mystack;

    int size=10;

    mystack->size=size;

    printf("Stack size: %d", mystack->size)
}