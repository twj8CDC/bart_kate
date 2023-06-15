# standard compile options for the c++ executable
FLAGS = -fPIC
LIBFLAGS = -L /usr/local/lib/
# the python interface through swig
PYTHONI = -I/Users/jacobtiegs/opt/anaconda3/include/python3.8
PYTHONL = -Xlinker -export-dynamic

# default super-target
all: 
	g++ -fPIC -c kitty.cpp -o kitty.o
	# g++ -fPIC -c main.cpp -o main.o
	swig -c++ -python -o kitty_wrap.cxx kitty.i 
	g++ $(FLAGS) `python3-config --cflags` -c kitty_wrap.cxx -o kitty_wrap.o
	g++ -bundle `python3-config --ldflags` kitty.o kitty_wrap.o -o _kitty.so

kitty:	
	g++ -fPIC -c kitty.cpp -o kitty.o
	g++ -fPIC -c main.cpp -o main.o
	g++ -shared kitty.o main.o -o main.so


clean:
	rm -f *.o kitty.py *.so kitty_wrap.cxx