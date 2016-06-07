PROGRAM_NAME = pairs
CC = gcc
VERSION = $(shell git describe --always)
CFLAGS = -Wall -Wextra -DVERSION=$(VERSION) -std=gnu99 -O2
LDFLAGS = -static -lz


.PHONY: clean all test

all: pairs

clean:
	rm -f $(OBJS)
	rm -f $(PROGRAM_NAME)
	rm -f pairs pairs.o

pairs: pairs.c | kseq.h
	$(CC) $(CFLAGS) $< -o pairs $(LDFLAGS) 

test:
	(cd tests && python test_pairs.py in-1.fq in-2.fq)

format:
	astyle -A8 -s4 -k3 -W3 -j -c -xC80 --mode=c $(wildcard *.c)
