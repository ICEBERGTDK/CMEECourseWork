""" This is blah blah"""

# Use the subprocess.os module to get a list of files and directories 
# in your ubuntu home directory 

# Hint: look in subprocess.os and/or subprocess.os.path and/or 
# subprocess.os.walk for helpful functions

import subprocess

#################################
#~Get a list of files and 
#~directories in your home/ that start with an uppercase 'C'

# Type your code here:

# Get the user's home directory.
home = subprocess.os.path.expanduser("~")

# Create a list to store the results.
FilesDirsStartingWithC = []

# Use a for loop to walk through the home directory.
for (dir, subdir, files) in subprocess.os.walk(home):
    for name in files:
        if name[0] in ["C"]:
            FilesDirsStartingWithC.append(name)
    for name in subdir:
        if name[0] in ["C"]:
            FilesDirsStartingWithC.append(name)
    for name in dir:
        if name[0] in ["C"]:
            FilesDirsStartingWithC.append(name)
print(FilesDirsStartingWithC[:10])
FilesDirsStartingWithC.clear()
#################################
# Get files and directories in your home/ that start with either an 
# upper or lower case 'C'

# Type your code here:
for (dir, subdir, files) in subprocess.os.walk(home):

    for name in files:    
        if name[0] in ["c","C"]:
            FilesDirsStartingWithC.append(name)

    for name in subdir:
        if name[0] in ["c","C"]:
            FilesDirsStartingWithC.append(name)
    
    for name in dir:
        if name[0] in ["c","C"]:
            FilesDirsStartingWithC.append(name)
print(FilesDirsStartingWithC[:10])
#####################print()rint()############
# Get only directories in your home/ that start with either an upper or 
#~lower case 'C' 
FilesDirsStartingWithC.clear()
# Type your code here:
for (dir, subdir, files) in subprocess.os.walk(home):
    for name in subdir:    
        if name[0] in ["c","C"]:
            FilesDirsStartingWithC.append(name)
print(FilesDirsStartingWithC[:10])