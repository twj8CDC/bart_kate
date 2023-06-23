#!/bin/bash
DIR=$(pwd)
echo $DIR
export LD_LIBRARY_PATH=$(pwd)/slib
echo $LD_LIBRARY_PATH

python3 _runscript.py