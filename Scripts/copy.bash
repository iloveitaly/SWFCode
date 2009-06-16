#!/bin/bash

#copy all the SWFS to the destination directory

dest=~/Sites/realnvp/includes/flash

if [ ! -e $dest ]; then
	echo "\"$dest\", does not exist"
	exit 1
fi

cd "$BUILD_DIR"

cp ./framer.swf $dest
cp ./fframerloader.swf $dest

exit 0