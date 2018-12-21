#!/bin/bash

###
# Pulls a remote directory into HDFS.
#
# Usage: ./remote-dir-to-hdfs <user@host> <dir_on_ssh> <dir_on_hdfs>
###

# The SSH host to connect to.
SSH=$1

# The SRC directory (on the SSH host).
SRC=$2

# The DST directory (on HDFS).
DST=$3

# For each file in the remote directory, read it and put it in HDFS.
for file in $(ssh $SSH "find $SRC -type f"); do
        ssh $SSH "cat $file" | hdfs dfs -put - ${file/$SRC/$DST}
done
