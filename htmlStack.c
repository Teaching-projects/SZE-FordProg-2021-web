#include <stdio.h>

int MAXSIZE = 100;
char* stack[100];
int top = -1;

char* pop() {
   char* data;
   if (top > -1) {
      data = stack[top];
      top = top - 1;   
      return data;
   } else {
        static char empty[1] = {'\0'};
        return empty;
   }
}

void push(char* data) {
   if (top != MAXSIZE) {
      top = top + 1;   
      stack[top] = data;
   } else {
      printf("\n ERROR: Could not insert data, Stack is full.\n");
   }
}

void removeFirstChar(char *s){
	if (*s == '\0') return;
	*s = *(s+1);
	removeFirstChar(s+1);
}

void removeLastChar(char *s){
    s[strlen(s)-1] = '\0';
}

void convertEndTag(char *s) {
    removeFirstChar(s);
    removeFirstChar(s);
    removeLastChar(s);
}