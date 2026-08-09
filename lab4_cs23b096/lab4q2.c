#include<stdio.h>


extern char result_string[];
extern int reverse(char str[]);


int main()
{
    char input []="atharvamoghe";
    int x=reverse(input);
    printf("reverse_string=%s,",result_string);
    printf("length=%d \n",x);
}  