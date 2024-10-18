
#!/Bridget/bin/env python3

"""Write a python script to populate a dictionary called taxa_dic derived from
taxa so that it maps order names to sets of taxa and prints it to screen."""

__appname__ = "[dictionary.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"
 
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

#### EXERCISE 1 - conventional dictionary

taxa_dic = {}
orders = []
for species in taxa:
    if species[1] in orders:
        taxa_dic[species[1]].extend([species[0]])
    else:
        orders.append(species[1])
        taxa_dic.update({species[1]:[species[0]]})
print(taxa_dic)



#### EXERCISE 2 - list comprehension

taxa_dic = {orders: [species[0] for species in taxa if species[1] == orders] \
            for orders in set(species[1] for species in taxa)}
print(taxa_dic)









