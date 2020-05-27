#!/bin/bash

set -e

curl -s https://api.github.com/repos/jitsi/jitsi-meet/releases/latest > RELEASE

JITSI_MEET_VERSION=$(jq -r ".tag_name[18:]" RELEASE)
JITSI_MEET_WEB_VERSION=$(jq -r .name RELEASE)

cat << __EOF__
JITSI_MEET_VERSION=$JITSI_MEET_VERSION
JITSI_MEET_WEB_VERSION=$JITSI_MEET_WEB_VERSION
__EOF__


sed -i "s@^_tag_version=.*@_tag_version=$JITSI_MEET_VERSION@; s@pkgrel=.*@pkgrel=1@" */PKGBUILD
sed -i "s@^_version=.*@_version=$JITSI_MEET_WEB_VERSION@" jitsi-meet-web/PKGBUILD


for i in */PKGBUILD
do
	cd "$(dirname "$i")"
	updpkgsums
	makepkg --printsrcinfo > .SRCINFO
	cd ..
done

# updpkgsums
# makepkg --printsrcinfo > .SRCINFO
