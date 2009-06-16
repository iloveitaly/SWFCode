#!/bin/bash

#document your code using NaturalDocs (http://naturaldocs.org/)
#Assumes you have a NaturalDocs executable (or a symlink to it) in your /usr/bin directory (or another directory in $PATH)

#Configuration variables
PROJECT_DIR=./Documentation	#directory for all config files
TARGET_DIR=./Source			#source directory to process
DOC_DIR=./Documentation		#output directory for all the documentation files


NaturalDocs \
-p $PROJECT_DIR \
-i $TARGET_DIR \
-o HTML $DOC_DIR			#you can also specify FramedHTML instead of HTML

#if you need to rebuild the documentation specify the -r option (specify -ro to also rebuild the configuration files
#if you need to exclude a directory from source indexing specify the -xi flag

if [ $? != 0 ]; then
	exit 1
else 
	open ./Documentation/index.html
	exit 0
fi