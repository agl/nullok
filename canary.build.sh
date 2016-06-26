set -e

gcc -c -O3 canary.c -fno-builtin
objdump -M intel -d canary.o > ../disas
