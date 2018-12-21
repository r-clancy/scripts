#!/bin/bash

###
# Pulls a remote directory with GZIP files into HDFS, unzipping each one.
#                                                                                                                                                                                           
# Usage: ./remote-dir-to-hdfs <user@host> <dir_on_ssh> <dir_on_hdfs>
###

# The SSH host to connect to.
SSH=$1

# The SRC directory (on the SSH host).
SRC=$2

# The DST directory (on HDFS).
DST=$3

# For each file in the remote directory...
for file in $(ssh $SSH "find $SRC -type f"); do

        # We want to store the file unzipped... get it's name
        unzipped_name=$(echo $file | cut -d . -f 1)

        # Read in the file, gunzip it, and put it in HDFS
        ssh $SSH "cat $file" | gunzip | hdfs dfs -put - ${unzipped_name/$SRC/$DST}

done
