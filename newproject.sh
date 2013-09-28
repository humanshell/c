#!/usr/bin/env bash
# newproject.sh - utility script to automate generation of new projects

NAME=$1
NAME=${NAME:="newproject"}

# create new project's directory
mkdir $NAME

# create new project's README file
echo "# $NAME" > $NAME/README.md

# create new project's main file
echo 'int main(int argc, const char *argv[]) {' >> $NAME/main.c
echo '  return 0;'                              >> $NAME/main.c
echo '}'                                        >> $NAME/main.c

# create new project's test harness
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

