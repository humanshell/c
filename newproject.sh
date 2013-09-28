#!/usr/bin/env bash
# newproject.sh - utility script to automate generation of new projects

NAME=$1
NAME=${NAME:="newproject"}

# create directory
mkdir $NAME

# create README file
echo "# $NAME" > $NAME/README.md

# create Makefile
cat > $NAME/Makefile <<EOF
CC=gcc
DEPS=
LDLIBS=
CFLAGS = -g -Wall -O3 -std=c99

%.o: %.c \$(DEPS)
		gcc -c -o $@ $< \$(CFLAGS)

$NAME: main.o
		gcc -o $@ $^ \$(CFLAGS)

test: test.o
		gcc -o prog_test $^ \$(CFLAGS)
		@./prog_test

clean:
		rm -f *.o $NAME prog_test

.PHONY: clean test
EOF


# create main file
cat > $NAME/main.c <<EOF
int main(int argc, const char *argv[]) {
  return 0;
}
EOF

# create test harness
cat > $NAME/test.c <<'EOF'
#include <assert.h>
#include <stdlib.h>
#include <stdio.h>

// Helpers

#define test(fn) \
  puts("... \x1b[33m" # fn "\x1b[0m"); \
  test_##fn();

// Tests

static void test_*(void) {
}

// Run Tests
int main(int argc, const char *argv[]) {
  test(*);
  puts("... \x1b[32m100%\x1b[0m\n");
  return 0;
}
EOF

