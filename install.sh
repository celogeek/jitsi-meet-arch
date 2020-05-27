#!/bin/sh
for i in */PKGBUILD
do
	cd "$(dirname "$i")"
	makepkg -sfi
	cd ..
done

