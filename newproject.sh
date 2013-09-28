#!/usr/bin/env bash
# newproject.sh - utility script to automate generation of new projects

NAME=$1
NAME=${NAME:="newproject"}

# create directory
mkdir $NAME

# create README file
echo "# $NAME" > $NAME/README.md

# create Makefile
echo 'CC=gcc'                                >> $NAME/Makefile
echo 'DEPS='                                 >> $NAME/Makefile
echo 'LDLIBS='                               >> $NAME/Makefile
echo 'CFLAGS = -g -Wall -O3 -std=c99'        >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile
echo '%.o: %.c $(DEPS)'                      >> $NAME/Makefile
echo -e "\t\tgcc -c -o $@ $< \$(CFLAGS)"     >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile
echo "$NAME: main.o"                         >> $NAME/Makefile
echo -e "\t\tgcc -o $@ $^ \$(CFLAGS)"        >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile
echo 'test: test.o'                          >> $NAME/Makefile
echo -e "\t\tgcc -o prog_test $^ \$(CFLAGS)" >> $NAME/Makefile
echo -e "\t\t@./prog_test"                   >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile
echo 'clean:'                                >> $NAME/Makefile
echo -e "\t\trm -f *.o $NAME prog_test"      >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile
echo '.PHONY: clean test'                    >> $NAME/Makefile
echo ''                                      >> $NAME/Makefile

# create main file
echo 'int main(int argc, const char *argv[]) {' >> $NAME/main.c
echo '  return 0;'                              >> $NAME/main.c
echo '}'                                        >> $NAME/main.c

# create test harness
echo '#include <assert.h>'                      >> $NAME/test.c
echo '#include <stdlib.h>'                      >> $NAME/test.c
echo '#include <stdio.h>'                       >> $NAME/test.c
echo ''                                         >> $NAME/test.c
echo '// Helpers'                               >> $NAME/test.c
echo ''                                         >> $NAME/test.c
echo '#define test(fn) \'                       >> $NAME/test.c
echo '  puts("... \x1b[33m" # fn "\x1b[0m"); \' >> $NAME/test.c
echo '  test_##fn();'                           >> $NAME/test.c
echo ''                                         >> $NAME/test.c
echo '// Tests'                                 >> $NAME/test.c
echo ''                                         >> $NAME/test.c
echo 'static void test_*(void) {'               >> $NAME/test.c
echo '}'                                        >> $NAME/test.c
echo ''                                         >> $NAME/test.c
echo '// Run Tests'                             >> $NAME/test.c
echo 'int main(int argc, const char *argv[]) {' >> $NAME/test.c
echo '  test(*);'                               >> $NAME/test.c
echo '  puts("... \x1b[32m100%\x1b[0m\n");'     >> $NAME/test.c
echo '  return 0;'                              >> $NAME/test.c
echo '}'                                        >> $NAME/test.c

