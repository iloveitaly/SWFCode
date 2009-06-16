#!/bin/bash

. ./Scripts/shared.bash

#------------------------------- Config Settings -------------------------------

swf="./framing_raw.swf"				#the swf to open after compiling
swfplayer="Flash Player"			#the application to open the swf with
noErrorProcessing=0					#if theres an error just output it. Useful when your not using preprocessing

#--------------------------------------------------------------------------------

# Get a list of all AS files in the 'source' directory
cd "$SRCROOT/Source"
localASFiles=`find . -name "*.as" -or -name "*.actionscript"`

cd "$BUILD_DIR"

#------------------------------- MLXML Compile -----------------------------------

#"$mtasc" \
#$localASFiles \
#-main -mx \
#-trace com.mab.util.debug.trace \
#-cp /Volumes/Work/mabwebdesign/ASLib/Source -cp $mtascStd -cp "$BUILD_DIR/source" -swf $swf -out $swfOut 2> $mtascError

#---------------------------------------------------------------------------------

$PROJECT_FILE_PATH/FCSHClient $PROJECT_NAME "mxmlc -default-size 800 600 -output $PROJECT_DIR/$PROJECT_NAME.swf $PROJECT_DIR/$PROJECT_NAME.as"

exit $?