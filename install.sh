#!/bin/sh
for i in */PKGBUILD
do
	cd "$(dirname "$i")"
	echo Y | makepkg -sfi
	cd ..
done

sudo systemctl daemon-reload
for c in disable enable stop start
do
	sudo systemctl $c jitsi-meet
done
