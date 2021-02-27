#!/bin/bash

INSTDIR="${XDG_DATA_HOME-$HOME/.local/share}/classicube"

if [ `getconf LONG_BIT` = "64" ]
then
	PACKAGE_LINK="nix64/ClassiCube.tar.gz"
else
	PACKAGE_LINK="nix32/ClassiCube.tar.gz"
fi

deploy() {
	mkdir -p $INSTDIR
	cd ${INSTDIR}
	PACKAGE="ClassiCube.tar.gz"
	wget --progress=dot:force "https://classicube.s3.amazonaws.com/client/release/${PACKAGE_LINK}" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --auto-close --auto-kill --title="Downloading ClassiCube..."

	tar -xzf ${PACKAGE} 
	rm ${PACKAGE}
	chmod +x ClassiCube
}

runcc() {
	cd ${INSTDIR}
	./ClassiCube "$@"
}

if [ ! -f ${INSTDIR}/ClassiCube ]; then
    deploy
    runcc "$@"
else
    runcc "$@"
fi
