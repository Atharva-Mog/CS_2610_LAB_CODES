 #include<stdio.h>
 
 char*   course_name="default";     //global variable
//char*   get_course="default2";

 char* getcourse()
{
    return course_name;
}

 void display_profile(char * first_name,char *last_name,char *course_name)
{
    printf("First_Name: %s ,Second_Name: %s , Course_Name:%s \n", first_name,last_name,course_name);
}
