#
# Makefile for the CS:APP Shell Lab
# 
# Type "make" to build your shell and driver
#
CC = /usr/bin/gcc
CFLAGS = -Wall -g -Werror
LIBS = -lpthread

FILES = sdriver runtrace tsh myspin1 myspin2 myenv myintp \
      myints mytstpp mytstps mysplit mysplitp mycat

all: $(FILES)

#
# Using link-time interpositioning to introduce non-determinism in the
# order that parent and child execute after invoking fork
#
tsh: tsh.c tsh_helper.c fork.c
	$(CC) $(CFLAGS)   -Wl,--wrap,fork -o tsh tsh.c tsh_helper.c utilities.c sighandlers.c builtin.c fork.c csapp.c $(LIBS)

sdriver: sdriver.o
sdriver.o: sdriver.c config.h
runtrace.o: runtrace.c config.h

# Clean up
clean:
	rm -f $(FILES) *.o *~

# Create Hand-in
handin:
	tar cvf handin.tar tsh.c key.txt
