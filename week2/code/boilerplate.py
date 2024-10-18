#!/Bridget/bin/env python3

"""Description of this program or applocation.
You can use several lines"""

__appname__ = "[application name here]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"
__license__ = "License for this code/program"

##imports ##
import sys #module to interface our program with the operating system

## constants ##


## functions ##
def main(argv):
    """Main antry point of the program """

    print("This is a boilerplate") #Note: indented using two tabs or 4 spaces
    return 0

if __name__ == "__main__":
    """Makes sure the "main" function is called from command line"""
    status = main(sys.argv)
    sys.exit(status)