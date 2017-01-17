#!/bin/sh
set -x
DYLD_LIBRARY_PATH=../lib export DYLD_LIBRARY_PATH
LD_LIBRARY_PATH=../lib export LD_LIBRARY_PATH
CLASSPATH=$CLASSPATH:. export CLASSPATH
java sample

