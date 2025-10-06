#include "libasm.h"

int main(void)
{
    char *s ="hola";
    char *ss ="hola";
    char des[10];
    char dees[10];
    char buff[10];
    int fd = open("tet.txt", O_RDONLY);
    int fd_ = open("text.txt", O_RDONLY);
    char *ptr;

    printf("strlen: %zu\n", strlen(s));
    printf("ft_strlen: %zu\n", ft_strlen(s));
    printf("strcpy: %s\n", strcpy(des, s));
    printf("ft_strcpy: %s\n", ft_strcpy(dees, ss));
    printf("strcmp: %d\n", strcmp(ss, s));
    printf("ft_strcmp: %d\n", ft_strcmp(ss, s));
    printf("ft_write: %ld\n", ft_write(1, "hola\n", 5));
    printf("ft_read: %ld\n", ft_read(fd, buff, 5));
    printf("\nft_write: %ld\n", ft_write(1, buff, 10));
    printf("ft_read: %ld\n", ft_read(fd_, buff, 5));
    printf("\nft_write: %ld\n", ft_write(1, buff, 10));
    ptr = ft_strdup("lalalalalallal");
    printf("%s\n", ptr);

    return 0;
}
