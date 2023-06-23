This example is now working.

Few items that are verified to work
- nesting through includes
  - A single smth.i can be used to reference smth.h associated with smth.cpp
  - smth.cpp can have its own includes, which will be accessable to objs of smth.cpp but will not be accessible through the python module.
  - to access the objs they must be referenced in smth.i
- Multiple includes in smth.i
  - smth.i can contian smth.h and othr.h and objs in both smth.h and othr.h are accessible
  - smth.h/smth.cpp can itself include othr.h making the objs of othr.h accessible to the smth.cpp objs
- Cpp includes directly
  - if smth.cpp needs a fx from fx.cpp but fx.cpp does not have a fx.i it can be included as fx.cpp in smth.cpp 
  - The only difference is that when creating smth.so, the fx.o is not included in the `g++` linkage command 
    - if fx.o and smth.o are in the linkage cmd then it will try to add the fx.o twice and an error will occur.
    - basically the `includes fx.cpp` in smth.cpp will copy that code into smth.cpp 
  - Makefile allows for either option. Changes will need to be made in main_fx.cpp and the Makefile
  