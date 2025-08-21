#include <stdio.h>
#include <string.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *s1, const char *s2);

int main(void)
{
    char *s ="hola";
    char *ss ="hola2";
    char des[10];
    char dees[10];

    printf("strlen: %zu\n", strlen(s));
    printf("ft_strlen: %zu\n", ft_strlen(s));
    printf("strcpy: %s\n", strcpy(des, s));
    printf("ft_strcpy: %s\n", ft_strcpy(dees, ss));
    printf("strcmp: %s\n", strcmp(ss, s));
    printf("ft_strcmp: %s\n", ft_strcmp(ss, s));

    return 0;
}