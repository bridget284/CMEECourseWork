#!/Bridget/bin/env python3

"""A function using ipdb for debugging"""

__appname__ = "[debugme.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"

def buggyfunc(x):
     """Demonstrates debugging using ipdb."""
     try:
        import ipdb  # Ensure ipdb is available
     except ImportError:
        print("Error: ipdb module is not installed. Install it using 'pip install ipdb'.")
        return None
    
     y = x
     for i in range(x):
        y=y-1
        try:
            ipdb.set_trace()  # Debugging breakpoint
            z = x / y
        except ZeroDivisionError: # prevent division by 0
            print("Error: Division by zero occurred. Adjust your logic.")
            return None
     return z

buggyfunc(20)

