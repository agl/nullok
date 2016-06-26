set -e

./config
sed -i -e 's/^CFLAG=\(.*\)/CFLAG=\1 -fno-builtin/' Makefile
make depend
make

objdump -M intel -d libcrypto.a > ../disas
objdump -M intel -d libssl.a >> ../disas
