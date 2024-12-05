#!/Bridget/bin/env python3

"""Some functions exemplifying conditional statements"""

__appname__ = "[cfexercises2.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"


########################
def hello_1(x):
    """Function that prints hello for each number between 1 and x which is divisable by 3"""
    for j in range(x):
        if j % 3 == 0:
            print('hello')
    print(' ')

hello_1(12)

########################
def hello_2(x):
    """Function that prints hello each time a number between 1 and x has remender 3 when divided by 4 and 5"""
    for j in range(x):
        if j % 5 == 3:
            print('hello')
        elif j % 4 == 3:
            print('hello')
    print(' ')

hello_2(12)

########################
def hello_3(x, y):
    """Function that prints hello for each number between x and y"""
    for i in range(x, y):
        print('hello')
    print(' ')

hello_3(3, 17)

########################
def hello_4(x):
    """Function which prints hello for every factor of 3 that can be added to x without x=15 occuring"""
    while x != 15:
        print('hello')
        x = x + 3
    print(' ')

hello_4(0)

########################
def hello_5(x):
    """Function which prints hello when specific conditions are met"""
    while x < 100:
        if x == 31:
            for k in range(7):
                print('hello')
        elif x == 18:
            print('hello')
        x = x + 1
    print(' ')

hello_5(12)

# WHILE loop with BREAK
def hello_6(x, y):
    """Function which prints hello when specific conditions are met"""
    while x: # while x is True
        print("hello! " + str(y))
        y += 1 # increment y by 1 
        if y == 6:
            break
    print(' ')

hello_6 (True, 0)