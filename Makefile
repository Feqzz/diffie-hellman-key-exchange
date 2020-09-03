PROG = main
NAME = diffie-hellman
CC = gnatmake
DEST = /usr/local/bin
all: build clean

build:
	$(CC) $(PROG).adb -o $(NAME)
clean:
	rm -f *.ali *.o 
install:
	install $(NAME) $(DEST)
uninstall:
	rm $(DEST)/$(NAME)