#!/bin/sh

set -e -x

yay -S --needed --noconfirm nginx coturn prosody lua52 lua52-sec lua52-zlib lua52-event

for i in jicofo jitsi-meet-prosody jitsi-meet-turnserver jitsi-meet-web jitsi-videobridge jitsi-meet
do
	cd "$i"
	rm -f *.part
	makepkg -si --needed --noconfirm
	cd -
done

