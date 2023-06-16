# standard compile options for the c++ executable
FLAGS = -fPIC
LIBFLAGS = -L /usr/local/lib/
# the python interface through swig



# default super-target
kitty_py: 
	g++ -fPIC -c kitty.cpp -o kitty.o
	swig -c++ -python -o kitty_wrap.cpp kitty.i
	g++ -fPIC `python3-config --cflags` -c kitty_wrap.cpp -o kitty_wrap.o
	g++ -shared `python3-config --ldflags` kitty.o kitty_wrap.o -o _kitty.so

kitty:	
	g++ -fPIC -c kitty.cpp -o kitty.o
	g++ -fPIC -c main.cpp -o main.o
	g++ -Wall -o main.out kitty.o main.o 

hello:
	g++ -Wall -o hello.out hello.cpp
	./hello.out

clean:
	rm -f *.o kitty.py *.so kitty_wrap.cpp *.out