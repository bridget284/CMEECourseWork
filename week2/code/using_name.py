#!/Bridget/bin/env python3

"""A script using the special variable __name__"""

__appname__ = "[using_name.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"



if __name__ == "__main__":
    print("This program is being run by itself!")
else:
     print("I am being imported from another script/program/module!")

print("This module's name is: " + __name__)