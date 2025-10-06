SRC = ft_strcpy.s\
	  ft_strlen.s\
	  ft_strcmp.s\
	  ft_write.s\
	  ft_read.s\
	  ft_strdup.s\

OBJ = $(SRC:.s=.o)

NAME =  libasm.a

NASM = nasm
NASMFLAGS = -f elf64

all: $(NAME)

$(NAME) : $(OBJ)
	ar rcs $(NAME) $(OBJ)

%.o: %.s
	$(NASM) $(NASMFLAGS) $< -o $@

#gcc -no-pie main.c $(NAME) -o main

clean:
	rm -f $(OBJ)

fclean: clean
	rm -f $(NAME)

re: fclean all

.PHONY: all, clean, fclean, re, run, test