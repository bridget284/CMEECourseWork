#!/Bridget/bin/env python3

"""script which takes an input species and will print the genus, and if the species is 
a species of oak, "FOUND AN OAK!" is printed
script contains a doctest to test if some example inputs are oaks"""

__appname__ = "[oaks_debugme.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"
#imports
import csv
import sys
import doctest

#Function to find out if the species is an oak, containing doctests
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' or 'Quercus' 
    >>> is_an_oak('Quercus cerris')
    True

    >>> is_an_oak('quercus ponticae')
    True

    >>> is_an_oak('quercuss lobatae')
    False

    >>> is_an_oak('quercuslobatae')
    False

    >>> is_an_oak('Fraxinus excelsior')
    False

    >>> is_an_oak('quercuS lobatae')
    False
    """
    #define function
    return name.split()[0] in ('quercus', 'Quercus')

#main function - opens a csv file of species and runs them through the is_an_oak function
# writes a csv file into the results folder containing the oak species
def main(argv): 
    f = open("../data/TestOaksData.csv",'r')
    g = open('../results/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        print(row)
        print ("The genus is: ") 
        print(row[0] + '\n')
        if is_an_oak(row[0]):
            print('FOUND AN OAK!\n')
            csvwrite.writerow([row[0], row[1]])    

    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()