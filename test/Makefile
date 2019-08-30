COMPILERS ?= \
	x86_64-linux-gnu-gcc \
	i686-linux-gnu-gcc \
	aarch64-linux-gnu-gcc \
	arm-linux-gnueabihf-gcc \
	x86_64h-apple-darwin14-cc \
	x86_64-apple-darwin14-cc \
	i386-apple-darwin14-cc \
	x86_64-w64-mingw32-gcc \
	i686-w64-mingw32-gcc

BINARIES ?= \
	x86_64-linux-gnu-gcc \
	i686-linux-gnu-gcc \
	aarch64-linux-gnu-gcc \
	arm-linux-gnueabihf-gcc \
	x86_64h-apple-darwin14-cc \
	x86_64-apple-darwin14-cc \
	i386-apple-darwin14-cc \
	x86_64-w64-mingw32-gcc.exe \
	i686-w64-mingw32-gcc.exe

CFLAGS ?= --static

.PHONY: all
all: ${COMPILERS}

.PHONY: clean
clean:
	@rm -f ${BINARIES}

x86_64-linux-gnu-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@

i686-linux-gnu-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@

aarch64-linux-gnu-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@

arm-linux-gnueabihf-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@

x86_64h-apple-darwin14-cc: helloworld.c
	@$@ $(subst --static,,${CFLAGS}) -o $@ $^
	@file $@

x86_64-apple-darwin14-cc: helloworld.c
	@$@ $(subst --static,,${CFLAGS}) -o $@ $^
	@file $@

i386-apple-darwin14-cc: helloworld.c
	@$@ $(subst --static,,${CFLAGS}) -o $@ $^
	@file $@

x86_64-w64-mingw32-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@.exe

i686-w64-mingw32-gcc: helloworld.c
	@$@ ${CFLAGS} -o $@ $^
	@file $@.exe
