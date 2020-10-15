# Dengkui Tang,Oct 2020

import csv
import sys

#Define function
def is_an_oak(name):
    """ Returns True if name is starts with 'quercus' """
    
    return name.lower().startswith('quercus') # missed a letter

def main(argv): 
    f = open('../Data/TestOaksData.csv','r')
    g = open('../Data/JustOaksData.csv','w')
    taxa = csv.reader(f)
    csvwrite = csv.writer(g)
    oaks = set()
    for row in taxa:
        if row[0].lower().startswith('genus'): # skip the first line
            print("This is the title \n")
        else:
            print(row)
            print ("The genus is: ") 
            print(row[0] + '\n')
            if is_an_oak(row[0]):
                print('FOUND AN OAK!\n')
                csvwrite.writerow([row[0], row[1]])
                oaks.add(row[1]) # add the names into the 'oaks' set
    print(oaks)
    return 0
    
if (__name__ == "__main__"):
    status = main(sys.argv)