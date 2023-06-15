# CXX = g++
# CXXFLAGS = -std=gnu++11 -Wall -g -O2 -fpic -mtune=native
# ##CXX = `R CMD config CXX11`
# ##CXXFLAGS = `R CMD config CXX11STD` `R CMD config CXX11FLAGS` `R CMD config CXX11PICFLAGS` 

# ## Rmath library for random number generation and other needs
# CPPFLAGS = `R CMD config CPPFLAGS` -I. -DMATHLIB_STANDALONE -DRNG_Rmath
# LIB = `R CMD config LDFLAGS` -lRmath
# # RNG_random = 'noR'


# This is a comment line
CC=g++
# CFLAGS will be the options passed to the compiler.
CFLAGS= -Wall -fPIC
IFLAG = -I/Users/jacobtiegs/opt/anaconda3/include/python3.8


# do with head.h in main_fx.cpp
# all:
# 	$(CC) $(CFLAGS) -c factorial.cpp -o factorial.o
# 	$(CC) $(CFLAGS) -c hello.cpp -o hello.o
# 	$(CC) $(CFLAGS) -c head.cpp -o head.o
# 	$(CC) $(CFLAGS) -c main_fx.cpp -o main_fx.o
# 	swig -c++ -python -o main_fx_wrap.cpp main_fx.i
# 	$(CC) $(CFLAGS) `python3-config --cflags` -c main_fx_wrap.cpp -o main_fx_wrap.o
# 	$(CC) -bundle `python3-config --ldflags` main_fx.o factorial.o hello.o head.o main_fx_wrap.o -o _main_fx.so

# do with head.cpp in main_fx.cpp
all:
	$(CC) $(CFLAGS) -c factorial.cpp -o factorial.o
	$(CC) $(CFLAGS) -c hello.cpp -o hello.o
	$(CC) $(CFLAGS) -c head.cpp -o head.o
	$(CC) $(CFLAGS) -c main_fx.cpp -o main_fx.o
	swig -c++ -python -o main_fx_wrap.cpp main_fx.i
	$(CC) $(CFLAGS) `python3-config --cflags` -c main_fx_wrap.cpp -o main_fx_wrap.o
	# remove head.o from the linkage
	$(CC) -bundle `python3-config --ldflags` main_fx.o factorial.o hello.o main_fx_wrap.o -o _main_fx.so

clean:
	rm -rf *.o *.out *.py main_fx_wrap.cpp