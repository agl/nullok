set -e

function test_code {
	name=$1
	url=$2
	tarball=$3

	if [ ! -f $tarball ]; then
		wget $url
	fi

	sha256sum -c $tarball.sum

	mkdir -p nonnull/$name
	pushd nonnull/$name
	tar xz < ../../$tarball
	pushd $(ls -1)
	sudo cp /usr/include/string.h.orig /usr/include/string.h
	cp ../../../$name.build.sh .
	/bin/bash $name.build.sh
	popd
	popd

	mkdir -p nullok/$name
	pushd nullok/$name
	tar xz < ../../$tarball
	pushd $(ls -1)
	sudo cp /usr/include/string.h.nullok /usr/include/string.h
	cp ../../../$name.build.sh .
	/bin/bash $name.build.sh
	popd
	popd
}

rm -Rf nonnull
rm -Rf nullok

test_code canary no-url canary.tar.gz
test_code boringssl-snapshot no-url boringssl-snapshot.tar.gz
test_code openssh-7.2p2 http://mirrors.sonic.net/pub/OpenBSD/OpenSSH/portable/openssh-7.2p2.tar.gz openssh-7.2p2.tar.gz
test_code openssh-5.4p1 http://mirrors.sonic.net/pub/OpenBSD/OpenSSH/portable/openssh-5.4p1.tar.gz openssh-5.4p1.tar.gz
test_code openssl-1.0.2h https://www.openssl.org/source/openssl-1.0.2h.tar.gz openssl-1.0.2h.tar.gz

# https://kb.isc.org/article/AA-01167
# Had to move /usr/include/json out of the way because otherwise json/features.h causes major problems.
test_code bind-9.9.5 https://ftp.isc.org/isc/bind/9.9.5/bind-9.9.5.tar.gz bind-9.9.5.tar.gz
