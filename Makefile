PROGRAM_NAME = pairs
CC = gcc
DEBUG ?= 0
ifeq ($(wildcard .git/H*),.git/HEAD)
	VERSION = $(shell git describe --always)
else
	VERSION = 0.1.0-dev
endif
CFLAGS = -Wall -pedantic -DVERSION=$(VERSION) -std=gnu99
ifeq ($(DEBUG), 1)
	CFLAGS += -g -O0
else
	CFLAGS += -O3
endif
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
