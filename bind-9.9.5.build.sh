set -e

CFLAGS=-fno-builtin ./configure
make -j4

echo > ../disas
for obj in $(find -name "*.o" | sort) ; do objdump -M intel -d $obj >> ../disas; done
