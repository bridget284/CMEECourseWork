#!/Bridget/bin/env python3

"""explaining global variables"""

__appname__ = "[scope.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"


_a_global = 10 # a global variable

if _a_global >= 5:
    _b_global = _a_global + 5 # also a global variable

# print the variable values before calling the function    
print("Before calling a_function, outside the function, the value of _a_global is", _a_global)
print("Before calling a_function, outside the function, the value of _b_global is", _b_global)

def a_function():
    """Function to show how global and local variables work, inside and out of a function."""
    _a_global = 4 # a local variable
    
    if _a_global >= 4:
        _b_global = _a_global + 5 # also a local variable
    
    _a_local = 3
     # print variable values in the function
    print("Inside the function, the value of _a_global is", _a_global)
    print("Inside the function, the value of _b_global is", _b_global)
    print("Inside the function, the value of _a_local is", _a_local)

# run the function    
a_function()

# print variable values after the function
print("After calling a_function, outside the function, the value of _a_global is (still)", _a_global)
print("After calling a_function, outside the function, the value of _b_global is (still)", _b_global)
# _a_local is a local variable not a global variable, so cannot be found outside the function scope where it is defined
# printing _a_local will cause an error
try:
    print("After calling a_function, outside the function, the value of _a_local is", _a_local)
except NameError:
    print("Error: '_a_local' is not defined outside the function. It is a local variable.")














_a_global = 10 # define a global variable

def a_function():
    """Function to show how global and local variables work, inside and out of a function."""
    _a_local = 4 # define a local variable
    
    # print the variable values inside the function
    print("Inside the function, the value _a_local is", _a_local)
    print("Inside the function, the value of _a_global is", _a_global)
    
# run the function and print the global value after running the function
a_function()
print("Outside the function, the value of _a_global is", _a_global)










_a_global = 10 # define the global variable
# print the global variable before calling a function
print("Before calling a_function, outside the function, the value of _a_global is", _a_global)

def a_function():
     """Function to show how global and local variables work, inside and out of a function."""
     # define variables within the function
     global _a_global
     a_global = 5
     _a_local = 4

     # print variable values from within the function
     print("Inside the function, the value of _a_global is", _a_global)
     print("Inside the function, the value _a_local is", _a_local)

# run the function and print the global variable value after running
a_function()
print("After calling a_function, outside the function, the value of _a_global now is", _a_global)



















_a_global = 10 # define global variable

def a_function():
    """Function to show how global and local variables work, inside and out of a function."""
    def _a_function2():
        """Function to show how global and local variables work, inside and out of a function."""
        # define global variables within two functions
        global _a_global
        _a_global = 20
    
    # print the value of the variable before calling the second function, call function 2, then re-print the variable value
    print("Before calling a_function2, value of _a_global is", _a_global)
    _a_function2()
    print("After calling a_function2, value of _a_global is", _a_global)

# call function 1
a_function()

# print the variable value after the function has run
print("The value of a_global in main workspace / namespace is", _a_global)