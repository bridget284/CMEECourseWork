#imports
import csv

#reading in data into a list called seq
with open('week2/data/Sequence.csv', 'r') as f:
    csvread = csv.reader(f)
    seq = []
    for row in csvread:
        seq.append(row)

# splitting the two sequences up and turing them into strings
seq2 = seq[0][0]
seq1 = seq[1][0]

# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
l1 = len(seq1)
l2 = len(seq2)
if l1 >= l2:
    s1 = seq1
    s2 = seq2
else:
    s1 = seq2
    s2 = seq1
    l1, l2 = l2, l1 # swap the two lengths

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
my_best_align = []
my_best_score = -1

for i in range(l1): # Note that you just take the last alignment with the highest score
    z = calculate_score(s1, s2, l1, l2, i)
    if z == my_best_score:
        my_best_align.append("." * i + s2) # the number of "." before the allignment shows where along the sequence the allignment is
    elif z > my_best_score:
        my_best_align = []
        my_best_align.append("." * i + s2) # the number of "." before the allignment shows where along the sequence the allignment is
        my_best_score = z 


#write the best score and alignment into a text file
g = open("../results/best_align.txt","w")
g.write("Best allignments:")
g.write(my_best_align + "\n") 
g.write("Best score:")
g.write(str(my_best_score) + "\n")
#g.write("From the sequence:")
#g.write(s1)
g.close()

