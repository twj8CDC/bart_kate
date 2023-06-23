The shapes example works.

The key thing is making sure you are using the same python library that was used in the compile
My defualt python3 points to the 3.7 non-anaconda python, but my PATH python is the conda version. Using python 3.7 directly works.

Other items
	g++ $(FLAGS) `python3-config --cflags` -c example_wrap.cxx -o example_wrap.o
	g++ -bundle `python3-config --ldflags` example.o example_wrap.o -o _example.so

	- the `python3-config --cflags` is used to get the includes neede in creating the example_wrap.o
	- the `python3-config --ldflags` is used to get the library components in the linkage step
	- `-bundle` is the g++ linkage param