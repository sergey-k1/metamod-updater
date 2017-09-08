#!/bin/bash
SPATH=$1
if [ ! -f $SPATH/steam.inf ]; then
	echo "Usage: $0 path/to/tf2/tf"
	exit 0
fi
mkdir -p $SPATH/.metamod-downloads/

MM1="http://www.metamodsource.net/mmsdrop/1.11/"
MM2=$(wget -q -O- $MM1 | egrep -o "mm.*git.*linux.tar.gz\"" | tail -n 1 | head -c -2)                   
if [ -f $SPATH/.metamod-downloads/$MM2 ];then
	echo "MetaMod up to date, skipping."
	exit 0
fi

echo "Downloading $MM2"
rm -rf $PATH/.metamod-downloads/*
wget -q -O $SPATH/.metamod-downloads/$MM2 $MM1$MM2

if [ -f $SPATH/addons/metamod.vdf ]; then
	cp $SPATH/addons/metamod.vdf $SPATH/addons/metamod.vdf_back
fi

tar -zxf $SPATH/.metamod-downloads/$MM2 -C $SPATH
if [ -f $SPATH/addons/metamod.vdf_back ]; then
	mv $SPATH/addons/metamod.vdf_back $SPATH/addons/metamod.vdf
fi
echo "Installed Metamod ($MM2)"
echo "Quitting."
exit 0
