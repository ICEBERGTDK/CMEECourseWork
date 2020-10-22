#!/usr/bin/env python3

"""oaks_debugme Practical 2"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'

import csv
import sys
import doctest

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' 
    
    >>> is_an_oak('Quercus')
    True

    >>> is_an_oak('Quercs')
    False

    >>> is_an_oak('Quercus+s')
    False

    >>> is_an_oak('quercus')
    False

    >>> is_an_oak('Fraxinus')
    False

    """

    return name=='Quercus' # missed a letter
"""is an oak"""

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        if row[0].lower().startswith('genus'): # skip the first line
            print("This is the title \n")
            csvwrite.writerow(row)
        else:
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])
                oaks.add(row[1]) # add the names into the 'oaks' set
    print('Quercus : ',oaks)
    return 0
"""the main function"""
    
if (__name__ == "__main__"):
    status = main(sys.argv)

doctest.testmod()