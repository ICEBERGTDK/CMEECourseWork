# This function calculates heights of trees given distance of each tree 
# from its base and angle to its top, using  the trigonometric formula 
#
# height = distance * tan(radians)
#
# ARGUMENTS
# degrees:   The angle of elevation of tree
# distance:  The distance from base of tree (e.g., meters)
#
# OUTPUT
# The heights of the tree, same units as "distance"

TreeHeight <- function(degrees, distance){
  radians <- degrees * pi / 180
  height <- distance * tan(radians)
  print(paste("Tree height is:", height))
  
  return (height)
}
df1 = read.csv("../data/trees.csv",header=T)
df1$Tree.Height.m=TreeHeight(df1$Angle.degrees, df1$Distance.m)

df2 = write.csv(df1,"../results/TreeHts.csv")
