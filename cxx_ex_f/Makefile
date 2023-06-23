
CXX = g++
CXXFLAGS = -std=gnu++11 -Wall -g -O2 -fpic -mtune=native
# CXX = `R CMD config CXX11`
# CXXFLAGS = `R CMD config CXX11STD` `R CMD config CXX11FLAGS` `R CMD config CXX11PICFLAGS` 

## Rmath library for random number generation and other needs
# CPPFLAGS = `R CMD config CPPFLAGS` -I. -DMATHLIB_STANDALONE -DRNG_Rmath #updated because CPPFLAGS has no content
# CPPFLAGS = -I/usr/include/ -I. -DRNG_Rmath -DMATHLIB_STANDALONE
# CPPFLAGS = -I. -I./include -DRNG_Rmath -DMATHLIB_STANDALONE
CPPFLAGS = -I./include -DRNG_Rmath -DMATHLIB_STANDALONE
# LIB = `R CMD config LDFLAGS` -lRmath # not working
# LIB = -L/usr/lib/ -lRmath 
LIB = -L./slib -lRmath 


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


# make at cpbartpPpPp
# all:
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c rtnorm.cpp -o rtnorm.o 
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bart.cpp -o bart.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bartfuns.cpp -o bartfuns.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c bd.cpp -o bd.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c tree.cpp -o tree.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c treefuns.cpp -o treefuns.o
# #	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c pmain.cpp -o pmain.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c cpbart.cpp -o cpbart.o
# #	swig -c++ -python -o pmain_wrap.cpp pmain.i
# #	$(CXX) $(CXXFLAGS) $(CPPFLAGS) `python3-config --cflags` -c pmain_wrap.cpp -o pmain_wrap.o
# 	swig -c++ -python -o cpbart_wrap.cpp cpbart.i
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) `python3-config --cflags` -c cpbart_wrap.cpp -o cpbart_wrap.o
# 	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -bundle `python3-config --ldflags` cpbart.o cpbart_wrap.o rtnorm.o bart.o bartfuns.o bd.o tree.o treefuns.o -o _cpbart.so $(LIB)




# .cpp.o : Makefile common.h rn.h
#	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $*.o

# main.out : Makefile main.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o 
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) main.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o -o main.out $(LIB)

# wmain.out : Makefile cwbart.cpp wmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o 
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) wmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o -o wmain.out $(LIB)

# pmain.out : Makefile cpbart.cpp pmain.o rtnorm.o bart.o bartfuns.o bd.o tree.o treefuns.o
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) pmain.o bart.o bartfuns.o bd.o tree.o treefuns.o rtnorm.o -o pmain.out $(LIB)

# lmain.out : Makefile clbart.cpp lmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o rand_draws.o randomkit.o latent.o
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) lmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o rand_draws.o randomkit.o latent.o -o lmain.out $(LIB)

# mmain.out : Makefile cmbart.cpp mmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o rand_draws.o randomkit.o latent.o
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) mmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o rand_draws.o randomkit.o latent.o -o mmain.out $(LIB)

# dpmain.out : Makefile cdpmbart.cpp dpmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o dp.o dpm.o dps.o
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) dpmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o dp.o dpm.o dps.o -o dpmain.out $(LIB)

# dpmwmain.out : Makefile cdpmwbart.cpp dpmwmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o dp.o dpm.o dps.o
# 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) dpmwmain.o bart.o bartfuns.o bd.o heterbart.o heterbartfuns.o heterbd.o tree.o treefuns.o dp.o dpm.o dps.o -o dpmwmain.out $(LIB)

clean :
	rm -f *.o *.so pmain_wrap.cpp  pmain.py cpbart.py

check :
	@echo CXX=$(CXX)
	@echo CXXFLAGS=$(CXXFLAGS)
	@echo CPPFLAGS=$(CPPFLAGS)
	@echo LIB=$(LIB)
