#!/usr/bin/env python3

"""align DNA sequences Groupwork Practical"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'

import sys
import re

# Two example sequences to match
# seq2 = "ATCGCCGGATTACGGG"
# seq1 = "CAATTCGGAT"

"""
def extract_seq(filename):
    # Extract seq from file (and header if present)
    
    with open(filename) as f:
        line1 = f.readline().strip()
        pattern = "^[A-Z]+$"
        no_header = re.match(pattern,line1)
        if no_header:
            # if there is no header (just seq)...
            f.seek(0) # Go back to first line
            head = None
            seq = ''.join(line.strip() for line in f) # join all lines into seq
        else:
            # If there a header...
            head = line1
            seq = ''.join(line.strip() for line in f)
    return seq, head
"""    

def ReadSeq(): # read seqs from align_seq.csv and store seqs in ListSeq
    try:
        file1_name = sys.argv[1]
    except:
        file1_name = "../../week1/Data/fasta/407228326.fasta"
    try:
        file2_name = sys.argv[2]
    except:
        file2_name = "../../week1/Data/fasta/407228412.fasta"
    f1 = open(file1_name,'r')
    f2 = open(file2_name,'r')
    seq1 = ''
    seq2 = ''
    ListSeq1 = []
    ListSeq2 = []
    Letter = "^[A-Z]+$"
    for line in f1:
        if re.match(Letter, line):
            ListSeq1.append(line.strip("\n"))
    for line in f2:
        if re.match(Letter, line):
            ListSeq2.append(line.strip("\n"))
    for i in range(len(ListSeq1)):
        seq1 += ListSeq1[i]
    for i in range(len(ListSeq2)):
        seq2 += ListSeq2[i]
    return seq1,seq2

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

# Test the function with some example starting points:
# calculate_score(s1, s2, l1, l2, 0)
# calculate_score(s1, s2, l1, l2, 1)
# calculate_score(s1, s2, l1, l2, 5)

# now try to find the best match (highest score) for the two sequences

def GetScore(s1,s2,l1,l2):
    my_best_align = []
    my_best_score = -1
    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            #my_best_align = "." * i + s2 # think about what this is doing!
            my_best_score = z 
    for i in range(l1):
        z = calculate_score(s1,s2,l1,l2,i)
        if z>= my_best_score:
            my_best_align.append("."*i+s2)
    for align in my_best_align:
        print(align)
        print(s1)
    print("Best score:", my_best_score)

    filename = 'align_seqs_fasta_result.txt'
    with open ('../results/'+filename,'w') as file_object:
        for i in range(len(my_best_align)):
            file_object.write(my_best_align[i]+"\n")
            file_object.write(s1+"\n")
            file_object.write("\n")
        file_object.write("Best score:"+str(my_best_score))


def main(argv): # the main function
    seq1,seq2 = ReadSeq()
    s1,s2,l1,l2 = SwapSeq(seq1,seq2)
    GetScore(s1,s2,l1,l2)
    return 0

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)
