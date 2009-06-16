#!/bin/bash

# For this script to work you need the filepp: http://www.cabaret.demon.co.uk/filepp/
# or you could modify the script to use cpp or your favorite preprocesser

#include shared functions
. ./Scripts/shared.bash

srcDest="$BUILD_DIR/source"
srcRoot="$SRCROOT/Source"

if [[ -e "$srcDest" ]]; then
	rm -R "$srcDest"
fi

mkdir "$srcDest"

cp -R "$srcRoot"/* "$srcDest"

# Set a macro depending on the build type
if [[ "$BUILD_STYLE" = "Debug" ]]; then
	buildMacro=""
else
	buildMacro="-DIS_PRODUCTION=1"
fi

# Process all the actionscript source files
find "$srcDest" -name "*.as" -or -name "*.actionscript" | while read file; do
	# You can replace the filepp command below with your favorite preprocesser command
	# With filepp you can specify macros from the command line, for instance:
	#	-Dtrace=com.mab.util.debug.trace
	#	-Ddate=`date`
	filepp $buildMacro "-I/Volumes/Work/mabwebdesign/ASLib/Source/prototypes" "-I$srcRoot" "$file" -o "`translateToBuildPath "$file"`"
	
	if [ $? -ne 0 ]; then
		exit $?
	fi
done

exit 0