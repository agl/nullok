# Testing the effects of section 7.24.1(2) of the C11 standard

This repository contains the scripts that I used to write a [blog post](https://www.imperialviolet.org/2016/06/26/nonnull.html) about the assumption, in the C standard, that all pointers passed to standard library functions are non-NULL. It compiles a number of packages with and without this assumption and writes their disassembly to a text file.

If you wish to reproduce you need to do some setup because `test-changes.sh` assumes that `/usr/include/string.h.orig` contains a pristine copy of `/usr/include/string.h` (with `nonnull` annotations) and that `/usr/include/string.h.nullok` contains a version of the same header but with the annotations removed. See `string.h.patch` for a diff from my computer of these files.

Once that's setup, you should ensure that you have passwordless sudo enabled, or else you'll be prompted for your password a few times. Otherwise, just running `test-changes.sh` should produce a number of `disas` files in subdirectories of `nonnull` and `nullok`. (Note that it'll take a while to build all the packages. If you're only interested in a subset, comment out the others in the `.sh` file.)
