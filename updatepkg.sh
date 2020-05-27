#!/bin/bash

set -e

curl -s https://api.github.com/repos/jitsi/jitsi-meet/releases/latest > RELEASE

JITSI_MEET_VERSION=$(jq -r ".tag_name[18:]" RELEASE)
JITSI_MEET_WEB_VERSION=$(jq -r .name RELEASE)
JITSI_VIDEOBRIDGE=$(curl -s https://api.github.com/repos/jitsi/jitsi-videobridge/releases/latest | jq -r .name | tr '-' '+')
JICOFO=$(curl -s https://api.github.com/repos/jitsi/jicofo/releases/latest | jq -r .name | tr '-' '+')

cat << __EOF__
JITSI_MEET_VERSION=$JITSI_MEET_VERSION
JITSI_MEET_WEB_VERSION=$JITSI_MEET_WEB_VERSION
JITSI_VIDEOBRIDGE=$JITSI_VIDEOBRIDGE
JICOFO=$JICOFO
__EOF__


sed -i "s@^_tag_version=.*@_tag_version=$JITSI_MEET_VERSION@; s@pkgrel=.*@pkgrel=1@" */PKGBUILD
sed -i "s@^_version=.*@_version=2.0.$JITSI_MEET_VERSION@" jitsi-meet/PKGBUILD
sed -i "s@^_version=.*@_version=$JITSI_MEET_WEB_VERSION@" jitsi-meet-web/PKGBUILD
sed -i "s@^_version=.*@_version=$JITSI_MEET_WEB_VERSION@" jitsi-meet-prosody/PKGBUILD
sed -i "s@^_version=.*@_version=$JITSI_MEET_WEB_VERSION@" jitsi-meet-turnserver/PKGBUILD
sed -i "s@^_version=.*@_version=$JITSI_VIDEOBRIDGE@" jitsi-videobridge/PKGBUILD
sed -i "s@^_version=.*@_version=$JICOFO@" jicofo/PKGBUILD


for i in */PKGBUILD
do
	cd "$(dirname "$i")"
	updpkgsums
	makepkg --printsrcinfo > .SRCINFO
	cd ..
done

