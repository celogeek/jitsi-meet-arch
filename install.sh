#!/bin/sh
for i in */PKGBUILD
do
	cd "$(dirname "$i")"
	echo Y | makepkg -sfi
	cd ..
done

