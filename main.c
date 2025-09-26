#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

size_t ft_strlen(const char *s);
char *ft_strcpy(char *dest, const char *src);
int ft_strcmp(const char *s1, const char *s2);
ssize_t ft_write(int fd, const void *buf, size_t count);
ssize_t ft_read(int fd, void *buf, size_t count);
char *ft_strdup(const char *s);

int main(void)
{
    char *s ="hola";
    char *ss ="hola";
    char des[10];
    char dees[10];
    char buff[10];
    int fd = open("text.txt", O_RDONLY);

    printf("strlen: %zu\n", strlen(s));
    printf("ft_strlen: %zu\n", ft_strlen(s));
    printf("strcpy: %s\n", strcpy(des, s));
    printf("ft_strcpy: %s\n", ft_strcpy(dees, ss));
    printf("strcmp: %d\n", strcmp(ss, s));
    printf("ft_strcmp: %d\n", ft_strcmp(ss, s));
    printf("ft_write: %ld\n", ft_write(1, "hola\n", 5));
    printf("ft_read: %ld\n", ft_read(fd, buff, 5));
    printf("\nft_write: %ld\n", ft_write(1, buff, 10));
    printf("ft_strdup: %s\n", ft_write("que tal\n"));

    return 0;
}
