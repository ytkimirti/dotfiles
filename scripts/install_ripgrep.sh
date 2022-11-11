#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
	if [[ $(uname -m) == "aarch64" ]]; then
		PKGNAME='ripgrep-13.0.0-arm-unknown-linux-gnueabihf.tar.gz'
	else
		PKGNAME='ripgrep_13.0.0_amd64.deb'
	fi
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/$PKGNAME

	if [[ $(uname -m) == "aarch64" ]]; then
		tar -xf $PKGNAME
		cd ripgrep-13.0.0-arm-unknown-linux-gnueabihf || exit 1
	else
		dpkg -i $PKGNAME \
		&& rm -rf $PKGNAME 
	fi
fi
