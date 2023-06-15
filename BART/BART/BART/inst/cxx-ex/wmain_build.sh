#!/bin/bash

swig -c++ -python -o wmain_wrap.cpp wmain.i

g++ wmain.cpp wmain_wrap.cpp -I/Users/jacobtiegs/opt/anaconda3/include/python3.8 -o _wmain.so
