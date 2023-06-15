# standard compile options for the c++ executable
FLAGS = -fPIC
LIBFLAGS = -L /usr/local/lib/
# the python interface through swig
PYTHONI = -I/Users/jacobtiegs/opt/anaconda3/include/python3.8
PYTHONL = -Xlinker -export-dynamic

# default super-target
all: 
	g++ -c example.cxx -o example.o
	swig -c++ -python -o example_wrap.cxx example.i 
	g++ $(FLAGS) `python3-config --cflags` -c example_wrap.cxx -o example_wrap.o
	g++ -bundle `python3-config --ldflags` example.o example_wrap.o -o _example.so


clean:
	rm -f *.o example.py *.so example_wrap.cxx