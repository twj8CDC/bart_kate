Random number generator based on RMATH now works when compiled as an independent class.

- Changes
  - added `define RNG_Rmath` directly to the rn.h file and removed from `-DRNG_Rmath` in Makefile
    - this wont need to be switched in main compile
    - this is updated back to original state
  - `log_sum_exp` needed to be fully implemented
    - this was done by copying the code directly from bartfuns.cpp
    - it probably works to do it by pulling in bartfuns.cpp directly, but that requires additional includes. Implemented in the cpbart swig.
  - `$(LIB)` added to end of the link step 
    - I believe this is what is needed for RMath library to be accessed
  - 