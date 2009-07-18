#!/bin/bash

translateToBuildPath()
{
	newPath="$1"
	newPath=${newPath/"$SRCROOT\/Source"/"$BUILD_DIR/source"}
	echo "$newPath"
}

translateToSourcePath()
{
	newPath="$1"
	newPath=${newPath/"$BUILD_DIR\/source"/"$SRCROOT/Source"}
	echo "$newPath"
}

processCompilerOutput()
{
	# example xcode error output:
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:80: error: syntax error before '}' token
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:85: warning: 'return' with a value, in function returning void
	
	# More Example Output:
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m: In function '-[ASDataSource isInstalled]':
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:39: warning: unused variable 'fm'
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m: In function '-[ASDataSource performActionForStep:withController:]':
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:80: error: syntax error before '}' token
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:85: warning: 'return' with a value, in function returning void
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m: In function '-[ASDataSource searchResultsForString:withAllPages:]':
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:96: warning: 'NSString' may not respond to '-containsString:ignoringCase:'
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:96: warning: (Messages without a matching method signature
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:96: warning: will be assumed to return 'id' and accept
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:96: warning: '...' as arguments.)
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m: At top level:
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:104: warning: incomplete implementation of class 'ASDataSource'
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:104: warning: method definition for '-generateRootNode' not found
	# /Volumes/Work/CocoaApps/PyHelp/trunk/Source/Plugins/AS/ASDataSource.m:104: warning: class 'ASDataSource' does not fully implement the 'WHDataSource' protocol

	
	# http://swik.net/mxmlc
	# Error box: ([^\(]*)[\(](\d+)[)]\: col\: (\d+) Error: (.*)
	# Warning box: ([^\(]*)[\(](\d+)[)]\: col\: (\d+) Warning: (.*)
	# Filename: $1
	# Line number: $2
	# Error message: $4

	#if there is more than one line of error messages
	# wc -l "$ERROR_FILE" | sed 's/[^0-9]//g'
	# if [[ `wc -l "$ERROR_FILE" | sed 's/[^0-9]//g'` != 1 ]]; then
	# 	cat "$ERROR_FILE"
	# 	return 1
	# fi
	
	cat $ERROR_FILE | ack '^/' | while read line; do
		echo $line | ack '([^\(]*)[\(](\d+)[)]\: col\: (\d+) (\S+): (.*)' --output='$1:$2: $4: $5' | sed 's/build\/source/Source/'
	done
	
	return 0
	cat $ERROR_FILE
	return 0
	cat $ERROR_FILE | ack '([^\(]*)[\(](\d+)[)]\: col\: (\d+) Error: (.*)' --output=\$1:\$2: warning: \$4
	
	return 0
	error=`cat "$ERROR_FILE"`	#grab the stored error message from the file
	origError=$error			#make a copy of the error message for future use
	
	#class not found error. Just exit with the error message
	if echo "$error" | fgrep -q "(unknown) : type error class not found :"; then	
		echo "$error"
		return 1
	fi
	
	#extract the line number from the error message
	errorFile=`echo "$error" | grep -o -E '^.*:[0-9]+:'`
	errorLineNum=`echo "$errorFile" | egrep -o '[0-9]+:$'`
	errorLineNum=${errorLineNum:0:${#errorLineNum}-1}
	
	#get the path that the error
	errorFile=${errorFile%:*:}

	#create a new error message using the 'real' path of the file
	error="`translateToSourcePath "$error"`"

	#create a reference to the 'real' file
	realFile=${error/:*/} #strip all characters after the ':' char

	#the line of the error in the preprocessed file
	errorLine=`sed -n ${errorLineNum}p "$errorFile"`	#the error line for the preprocessed file

	#figure out the difference in lines in the files and modify the error statement
	if [[ "`cat "$realFile" | wc -l > /dev/null`" = "`cat "$errorFile" | wc -l > /dev/null`" \
		&& "`fgrep -nx "$errorLine" "$realFile" | sed 's/:*//'`" = "$errorLineNum" ]]; then
		#then the files are exactly the same, output the original error message and exit
		echo "$origError"
		return 1
	else
		if fgrep -q "$errorLine" "$realFile"; then
			# get the line number of $errorLine in the original source files
			# then replace the old line number in the error message with the newly found one
			# if more than one match for $errorLine is found then multiple errors are echo'd
			# giving the user all the possible error locations
			# Then output the error and exit

			newErrorLine=`fgrep -nx "$errorLine" "$realFile" | grep -o '[^:]*'`
			for lineNum in $newErrorLine; do
				echo "$error" | sed -E "s/:[0-9]+/:$lineNum/"
			done
			
			return 1
		else
			#then the line was not found in the original source file which means the line that contains an error must be the pre-processed source
			#so output the original error message to let the user figure out the pre-processing error
			echo "$origError"
			return 1
		fi
	fi
	
	echo "Uncaught exception! Please report!"
	return 1
}