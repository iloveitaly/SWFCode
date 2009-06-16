#!/bin/bash

. ./Scripts/shared.bash

#------------------------------- Config Settings -------------------------------

swf="./framing_raw.swf"				#the swf to open after compiling
swfOut="framer.swf"					#for the -out option, leave empty ("") if you dont want to use -out
swfplayer="Flash Player"			#the application to open the swf with
mtasc=/Applications/mtasc/mtasc		#the mtasc binary path
mtascStd=/Applications/mtasc/std	#the std directory of mtasc
mtascError=./.mtascerror			#path to a temporary error file DO NOT REMOVE
showWarnings=1						#show warnings from mtasc
noErrorProcessing=0					#if theres an error just output it. Useful when your not using preprocessing

#--------------------------------------------------------------------------------

# Get a list of all AS files in the 'source' directory
cd "$SRCROOT/Source"
localASFiles=`find . -name "*.as" -or -name "*.actionscript"`

cd "$BUILD_DIR"

# Issue a warning if the source swf does not exist
# Issue just a warning because the user could be using -header to generate the swf
if [ ! -e $swf ]; then
	echo "warning: Source swf does not exist, please redefine or create the file referenced in \$swf"
fi

#------------------------------- MTASC Compile -----------------------------------

"$mtasc" \
$localASFiles \
-main -mx \
-trace com.mab.util.debug.trace \
-cp /Volumes/Work/mabwebdesign/ASLib/Source -cp $mtascStd -cp "$BUILD_DIR/source" -swf $swf -out $swfOut 2> $mtascError

#---------------------------------------------------------------------------------

returnVal=$?

processMtascOutput
exit $?