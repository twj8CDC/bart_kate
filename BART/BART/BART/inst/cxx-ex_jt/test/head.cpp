/* main.cpp */
#include <iostream>
#include "functions.h"

using namespace std;
void head(void)
{
	cout << "printing from head" << endl;
	print_hello();
	cout << endl;
	cout << "The factorial of 5 is " << factorial(5) << endl;
	
}