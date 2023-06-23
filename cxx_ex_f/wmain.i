/* wmain.i */
%module wmain

%{
#include "cwbart.cpp"
extern int main(void);
%}

extern int main(void);