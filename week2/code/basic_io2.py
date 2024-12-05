#!/Bridget/bin/env python3

"""Save the elements of a list to a file in sandbox"""

__appname__ = "[basic_io2.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"


#############################
# FILE OUTPUT
#############################
# Save the elements of a list to a file
list_to_save = range(100)

# open file in sandbox and write in elements from list
with open('../sandbox/testout.txt', 'w') as f:
    for i in list_to_save:
        f.write(str(i) + '\n')  # Add a new line at the end
