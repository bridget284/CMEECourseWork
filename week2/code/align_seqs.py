#!/Bridget/bin/env python3

"""Find the best alignment between two DNA sequences and write it into a file called best_align.txt in the results folder"""

__appname__ = "[align_seqs.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"

#imports
import csv

#reading in data into a list called seq
def read_seqs(filepath):
    """Reads sequences from a CSV file"""
    try:
        with open(filepath, 'r') as f:
            csvread = csv.reader(f)
            seq = []
            for row in csvread:
                if row:  # Skip empty rows
                    seq.append(row[0])   # Extract the first column (assumes sequences are in the first column)

        if len(seq) < 2:
            raise ValueError("Input file must contain at least two sequences.")

        # Validate that sequences only contain DNA bases (A, T, C, G)
        for sequence in seq[:2]:
            if not all(base in "ATCG" for base in sequence.upper()):
                raise ValueError(f"Malformed sequence detected: {sequence}")

        # Assign first two sequences to seq1 and seq2
        seq1, seq2 = seq[0], seq[1]
        return seq1, seq2

    except FileNotFoundError:
        print(f"Error: File '{filepath}' not found. Please check the file path.")
        raise
    except ValueError as ve:
        print(f"Error: {ve}")
        raise
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        raise
    
    



# Assign the longer sequence s1, and the shorter to s2
# l1 is length of the longest, l2 that of the shortest
def make_s1_longer(seq1, seq2):
    """Assigns the longer sequence to s1, and shorter to s2"""
    l1 = len(seq1)
    l2 = len(seq2)
    if l1 >= l2:
        s1 = seq1
        s2 = seq2
    else:
        s1 = seq2
        s2 = seq1
        l1, l2 = l2, l1 # swap the two lengths
    return s1, s2, l1, l2

# A function that computes a score by returning the number of matches starting
# from arbitrary startpoint (chosen by user)
def calculate_score(s1, s2, l1, l2, startpoint):
    """Calculate alignment score for s1 and s2"""
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
def find_best_alignment(s1, s2, l1, l2):
    """Finds the best alignment between the sequences"""
    my_best_align = None
    my_best_score = -1

    for i in range(l1): # Note that you just take the last alignment with the highest score
        z = calculate_score(s1, s2, l1, l2, i)
        if z > my_best_score:
            my_best_align = "." * i + s2 # the number of "." before the allignment shows where along the sequence the allignment is
            my_best_score = z 
    return my_best_align, my_best_score

#write the best score and alignment into a text file
def main():
    """Main function to run file, and output the best alignment score to a text file"""
    # define file paths
    input_path = '../data/Sequence.csv'
    output_path = '../results/best_align.txt'

    seq1, seq2 = read_seqs(input_path)  # Read sequences
    s1, s2, l1, l2 = make_s1_longer(seq1, seq2)  # Assign longer/shorter sequences
    my_best_align, my_best_score = find_best_alignment(s1, s2, l1, l2)  # Find best alignment

    # Write results to file
    with open(output_path, "w") as g:
        g.write("Best alignment:\n")
        g.write(my_best_align + "\n")
        g.write("Best score:\n")
        g.write(str(my_best_score) + "\n")
        g.write("From the sequence:\n")
        g.write(s1)


if __name__ == "__main__":
    main()
