
CXX = g++
CXXFLAGS = -std=gnu++11 -Wall -g -O2 -fpic -mtune=native
# CXX = `R CMD config CXX11`
# CXXFLAGS = `R CMD config CXX11STD` `R CMD config CXX11FLAGS` `R CMD config CXX11PICFLAGS` 

## Rmath library for random number generation and other needs
# Use if RMATH fully installed
# CPPFLAGS = -I/usr/include/ -I. -DRNG_Rmath -DMATHLIB_STANDALONE

# Use if reference repo specific Rmath
CPPFLAGS = -I./include -DRNG_Rmath -DMATHLIB_STANDALONE

# Use if Rmath standalone fully installed
# LIB = `R CMD config LDFLAGS` -L/usr/lib/ -lRmath 

# Use to reference repo specific Rmath # NOTE this will only run from the shell script due to need to specifify LD_PATH
LIB = `R CMD config LDFLAGS` -L./slib -lRmath



## STL random class for random number generation and the Rmath functions for other needs
# CPPFLAGS = -I. -I/usr/local/include -DMATHLIB_STANDALONE -DRNG_random

all:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c rtnorm.cpp -o rtnorm.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bart.cpp -o bart.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bartfuns.cpp -o bartfuns.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bd.cpp -o bd.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c tree.cpp -o tree.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c treefuns.cpp -o treefuns.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c pmain.cpp -o pmain.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c cpbart.cpp -o cpbart.o 
	swig -c++ -python -o pmain_wrap.cpp pmain.i 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) `python3.10-config --cflags` -c pmain_wrap.cpp -o pmain_wrap.o 
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -shared `python3.10-config --ldflags` cpbart.o rtnorm.o bart.o bartfuns.o bd.o tree.o treefuns.o pmain_wrap.o pmain.o -o _pmain.so $(LIB)


clean :
	rm -f *.o *.so pmain_wrap.cpp  pmain.py cpbart.py

check :
	@echo CXX=$(CXX)
	@echo CXXFLAGS=$(CXXFLAGS)
	@echo CPPFLAGS=$(CPPFLAGS)
	@echo LIB=$(LIB)
