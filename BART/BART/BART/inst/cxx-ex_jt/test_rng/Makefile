CXX = g++
CXXFLAGS = -std=gnu++11 -Wall -g -O2 -fpic -mtune=native
##CXX = `R CMD config CXX11`
##CXXFLAGS = `R CMD config CXX11STD` `R CMD config CXX11FLAGS` `R CMD config CXX11PICFLAGS` 

## Rmath library for random number generation and other needs
CPPFLAGS = `R CMD config CPPFLAGS` -I. -DMATHLIB_STANDALONE  -DRNG_Rmath
LIB = `R CMD config LDFLAGS` -lRmath

# make at cpbart
all:
	swig -c++ -python -o rn_wrap.cpp rn.i
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) `python3-config --cflags` -c rn_wrap.cpp -o rn_wrap.o $
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -bundle `python3-config --ldflags` rn_wrap.o -o _rn.so $(LIB)

clean:
	rm -f *.o *.so *_wrap.cpp  rn.py