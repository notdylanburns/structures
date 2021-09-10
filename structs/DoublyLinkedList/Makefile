CC := gcc
LD := ld

ROOT_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

LIBTARGET := DoublyLinkedList.so
OBJTARGET := DoublyLinkedList.o

SRCS := $(wildcard *.c)
LIBOBJS := $(patsubst %.c, %.o-libsrc, $(SRCS))
OBJOBJS := $(patsubst %.c, %.o-objsrc, $(SRCS))

CFLAGS := -Wall -Wextra -O2 -ggdb3
LDFLAGS :=

lib: $(LIBTARGET)
$(LIBTARGET): $(LIBOBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $(ROOT_DIR)/$@ $<

%.o-libsrc: %.c
	$(CC) $(CFLAGS) -fpic -o $@ -c $^

obj: $(OBJTARGET)
$(OBJTARGET): $(OBJOBJS)
	$(LD) -r $^ -o $@

%.o-objsrc: %.c
	$(CC) $(CFLAGS) -o $@ -c $^

clean:
	rm -f $(LIBTARGET) $(OBJTARGET) $(LIBOBJS) $(OBJOBJS)