#!/usr/bin/env python3

"""align DNA sequences Practical 2"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'

import sys

# Two example sequences to match
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"

def ReadSeq(): # read seqs from align_seq.csv and store seqs in ListSeq
    ListSeq = []
    f = open('../Data/align_seqs.csv','r')
    for line in f:
        ListSeq.append(line)
    f.close()
    return ListSeq
"""readseq"""

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest

def SwapSeq(seq1,seq2):
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1,s2,l1,l2
"""swapseq"""

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    matched = "" # to hold string displaying alignements
    score = 0
    for i in range(l2):
        if (i + startpoint) < l1:
            if s1[i + startpoint] == s2[i]: # if the bases match
                matched = matched + "*"
                score = score + 1
            else:
                matched = matched + "-"

    # some formatted output
    print("." * startpoint + matched)
    print("." * startpoint + s2)
    print(s1)
    print(score) 
    print(" ")

    return score
"""calculate_score"""

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences

def GetScore(s1,s2,l1,l2):
    my_best_align = None
    my_best_score = -1
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    filename = 'align_seqs_result.csv'
    with open ('../results/'+filename,'w') as file_object:
        file_object.write(my_best_align)
        file_object.write(s1)
        file_object.write("Best score:"+str(my_best_score))
        file_object.write("\n")
    print(my_best_align)
    print(s1)
    print("Best score:", my_best_score)

"""getscore"""

def main(argv): # the main function
    ListSeq = ReadSeq()
    s1,s2,l1,l2 = SwapSeq(ListSeq[0],ListSeq[1])
    GetScore(s1,s2,l1,l2)
    return 0
"""the main function"""

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
