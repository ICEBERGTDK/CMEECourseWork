birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#(1) Write three separate list comprehensions that create three different
# lists containing the latin names, common names and mean body masses for
# each species in birds, respectively. 

LatinN = [birds[0][0],birds[1][0],birds[2][0],birds[3][0],birds[4][0]]
CommonN = [birds[0][1],birds[1][1],birds[2][1],birds[3][1],birds[4][1]]
Detail = [birds[0][2],birds[1][2],birds[2][2],birds[3][2],birds[4][2]]

for i in range(len(LatinN)):
    print(LatinN[i])
for i in range(len(CommonN)):
    print(CommonN[i])
for i in range(len(Detail)):
    print(Detail[i])

# (2) Now do the same using conventional loops (you can choose to do this 
# before 1 !). 

LatinN1 = []
CommonN1 = []
Detail1 = []
for i in range(len(birds)):
    for j in range(3):
        if j == 0:
            LatinN1.append(birds[i][j])
        if j == 1:
            CommonN1.append(birds[i][j])
        if j == 2:
            Detail1.append(birds[i][j])

for i in range(len(LatinN1)):
    print (LatinN1[i])
for i in range(len(CommonN1)):
    print (CommonN1[i])
for i in range(len(Detail1)):
    print (Detail1[i])