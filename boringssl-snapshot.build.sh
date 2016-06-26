set -e

mkdir build
sed -i -e 's/set(C_CXX_FLAGS "\([^"]*\)")/set(C_CXX_FLAGS "\1 -fno-builtin -O3")/' CMakeLists.txt
cd build
cmake -GNinja ..
ninja

objdump -M intel -d crypto/libcrypto.a > ../../disas
objdump -M intel -d ssl/libssl.a >> ../../disas
