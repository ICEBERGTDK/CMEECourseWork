#!/usr/bin/env python3
"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'
"""

taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a short python script to populate a dictionary called taxa_dic 
# derived from  taxa so that it maps order names to sets of taxa. 
# E.g. 'Chiroptera' : set(['Myotis lucifugus']) etc. 

taxa_dic = {} # create the dictionary
s1 = set() # create set1 in order to avoid repetition
for i in range(len(taxa)):
        s1.add(taxa[i][1]) # add common name into set1
l=list(s1) # change the set to a list in order to edit
print (l)
for i in range(len(l)):
        s2 = set() # create set2 to store latin name
        #print (l[i])
        for j in range(len(taxa)):
                if taxa[j][1] == l[i]:
                        #print ("in?")
                        s2.add(taxa[j][0]) # put their latin name in set2
        taxa_dic[l[i]] = s2
        #s2.clear()
print (taxa_dic)