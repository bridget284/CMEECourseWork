#!/Bridget/bin/env python3

"""Some functions exemplifying conditional statements"""

__appname__ = "[cfexercises1.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"


##imports ##
import sys  # module to interface our program with the operating system
import doctest

def foo_1(x=9):
    """Find the square root of x
    >>> foo_1(16)
    4.0
    """
    return x ** 0.5

def foo_2(x=4, y=6):
    """Find the largest input
    >>> foo_2(8, 10)
    10
    """
    if x > y:
        return x
    return y

def foo_3(x=2, y=1, z=3):
    """Reorders the inputs, if x <= z it puts them in size order
    >>> foo_3(3, 2, 1)
    [1, 2, 3]
    """
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    if x > y:
        tmp = y
        y = x
        x = tmp
    return [x, y, z]

def foo_4(x=5):
    """Finding the factorial of the input
    >>> foo_4(6)
    720
    """
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result

def foo_5(x=5):
    """A second way to find the factorial of the input, using a recursive function
    >>> foo_5(6)
    720
    """
    if x == 1:
        return 1
    return x * foo_5(x - 1)

def foo_6(x=5):
    """A third way to find the factorial of the input
    >>> foo_6(6)
    720
    """
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto

# Arguments to run when the code is run through main
def main(argv):
    """The main function that demonstrates the use of the foo_* functions
    by printing results for two inputs for each for the 6 functions."""
    print(foo_1(9))
    print(foo_1(16))
    print(foo_2(2, 4))
    print(foo_2(6, 7))
    print(foo_3(1, 3, 2))
    print(foo_3(3, 2, 1))
    print(foo_4(3))
    print(foo_4(7))
    print(foo_5(3))
    print(foo_5(7))
    print(foo_6(3))
    print(foo_6(7))
    return 0

if __name__ == "__main__":
    status = main(sys.argv)
    doctest.testmod()
