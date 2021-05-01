#!/bin/bash

echo "Compiling Example"
clang -I ../klee/include -emit-llvm -c -g -O0 -Xclang -disable-O0-optnone example1.c
echo "Running KLEE on Example."
klee example1.bc
printf "\nGenerated Test Case 1\n"
ktest-tool klee-last/test000001.ktest 
printf "\nGenerateD Test Case 2\n"
ktest-tool klee-last/test000002.ktest 
printf "\nGenerated Test Case 3\n"
ktest-tool klee-last/test000003.ktest 

printf "\nReplaying Test Case 1\n"
gcc -I ../klee/include/ -L ../klee/build/lib example1.c -lkleeRuntest
KTEST_FILE=klee-last/test000001.ktest ./a.out
echo $?
printf "\nReplaying Test Case 2\n"
KTEST_FILE=klee-last/test000002.ktest ./a.out
echo $?
printf "\nReplaying Test Case 3\n"
KTEST_FILE=klee-last/test000003.ktest ./a.out
echo $?
