import re
'''blackbird'''
# Read the file (using a different, more python 3 way, just for fun!)
with open('../data/blackbirds.txt', 'r') as f:
    text = f.read()

# replace \t's and \n's with a spaces:
text = text.replace('\t',' ')
text = text.replace('\n',' ')
# You may want to make other changes to the text. 

# In particular, note that there are "strange characters" (these are accents and
# non-ascii symbols) because we don't care for them, first transform to ASCII:

text = text.encode('ascii', 'ignore') # first encode into ascii bytes
text = text.decode('ascii', 'ignore') # Now decode back to string
# print(text)

matches = re.compile(r'(Kingdom\s\w+)|(Phylum\s\w+)|(Species\s\w+\s\w+)')
for match in matches.finditer(text):
    print(match.group())

# Now extend this script so that it captures the Kingdom, Phylum and Species
print(re.findall(r"(Kingdom\s\w+)",text))
print(re.findall(r'(Phylum\s\w+)',text))
print(re.findall(r'(Species\s\w+\s\w+)',text))
# name for each species and prints it out to screen neatly.


# Hint: you may want to use re.findall(my_reg, text)... Keep in mind that there
# are multiple ways to skin this cat! Your solution could involve multiple
# regular expression calls (slightly easier!), or a single one (slightly harder!)

