set -e

./configure
sed -i -e 's/^CFLAGS=\(.*\)/CFLAGS=\1 -fno-builtin/' Makefile
make -j4

echo > ../disas
for obj in $(ls -1 *.o | sort); do
	objdump -M intel -d $obj >> ../disas
done
