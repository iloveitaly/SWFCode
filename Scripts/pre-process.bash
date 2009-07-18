#!/bin/bash

# For this script to work you need the filepp: http://www.cabaret.demon.co.uk/filepp/
# or you could modify the script to use cpp or your favorite preprocesser

OUTPUT_SRC_DIR="$BUILD_DIR/source"
INTPUT_SRC_DIR="$SRCROOT/Source"

# clear the output dir each time
if [[ -e "$OUTPUT_SRC_DIR" ]]; then
	rm -R "$OUTPUT_SRC_DIR"
fi

mkdir "$OUTPUT_SRC_DIR"

# copy the original source over to the output dir
cp -R "$INTPUT_SRC_DIR"/* "$OUTPUT_SRC_DIR"

# Set a macro depending on the build type

if [[ "$BUILD_STYLE" = "Debug" ]]; then
	buildMacro=""
else
	buildMacro="-DIS_PRODUCTION=1"
fi

# preprocess all the actionscript source files

find "$OUTPUT_SRC_DIR" -name "*.as" -or -name "*.actionscript" | while read file; do
	# You can replace the filepp command below with your favorite preprocesser command
	# With filepp you can specify macros from the command line, for instance:
	#	-Dtrace(str)=mab.util.debug.send(str);
	#	-Ddate=`date`
	#
	# You can also specify include Paths:
	#	-I/Volumes/Work/FlashConstants"
	
	filepp $buildMacro "-Dtrace(str)=mab.util.debug.send(str);" "-I$INTPUT_SRC_DIR" "$file" -o "`translateToBuildPath "$file"`"
	
	if [ $? -ne 0 ]; then
		exit $?
	fi
done