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

taxa_dic = {}
s1 = set()
for i in range(len(taxa)):
        s1.add(taxa[i][1])
l=list(s1)
print (l)
for i in range(len(l)):
        s2 = set()
        #print (l[i])
        for j in range(len(taxa)):
                if taxa[j][1] == l[i]:
                        #print ("in?")
                        s2.add(taxa[j][0])
        taxa_dic[l[i]] = s2
        #s2.clear()
print (taxa_dic)