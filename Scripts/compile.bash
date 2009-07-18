#!/bin/bash

. ./Scripts/shared.bash
. ./Scripts/pre-process.bash

#------------------------------- Config Settings -------------------------------

FLEX_BIN="/Applications/flex_sdk/bin"
OUTPUT_SWF="splash.swf"				#the swf to open after compiling
SWF_PLAYER="Flash Player"			#the application to open the swf with
noErrorProcessing=0					#if theres an error just output it. Useful when your not using preprocessing

#--------------------------------------------------------------------------------

PATH="$PATH:$FLEX_BIN"
OUTPUT_SWF="$BUILD_DIR/$OUTPUT_SWF"
ERROR_FILE="/tmp/swfcode.error"

localASFiles=`find "$SRCROOT/Source" -name "*.as" -or -name "*.actionscript"`
localASFiles="$localASFiles"

cd "$BUILD_DIR"

#------------------------------- MLXML Compile -----------------------------------

#"$mtasc" \
#$localASFiles \
#-main -mx \
#-trace com.mab.util.debug.trace \
#-cp /Volumes/Work/mabwebdesign/ASLib/Source -cp $mtascStd -cp "$BUILD_DIR/source" -swf $swf -out $swfOut 2> $mtascError

#---------------------------------------------------------------------------------

#$PROJECT_FILE_PATH/FCSHClient $PROJECT_NAME "mxmlc -default-size 800 600 -output $PROJECT_DIR/$PROJECT_NAME.swf $PROJECT_DIR/$PROJECT_NAME.as"

mxmlc \
-default-size 960 500 \
-output "$OUTPUT_SWF" \
-default-background-color 0xFFFFFF \
-compiler.source-path  /Applications/Adobe\ Flash\ CS3/Configuration/ActionScript\ 3.0/Classes/ \
-compiler.incremental \
$BUILD_DIR/source/$PROJECT_NAME.as 2> $ERROR_FILE

#-debug=true
#echo "mxmlc -default-size 800 600 -output $PROJECT_DIR/$PROJECT_NAME.swf "$localASFiles""
#-dump-config

COMPILER_RETURN=$?

cat $ERROR_FILE

processCompilerOutput

if [[ $COMPILER_RETURN -eq 0 && -z $swfOut ]]; then
	open -a "$SWF_PLAYER" "$OUTPUT_SWF"
fi

exit $COMPILER_RETURN