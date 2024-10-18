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

taxa_dic = {}
orders = []
for species in taxa:
    if species[1] in orders:
        taxa_dic[species[1]].extend([species[0]])
    else:
        orders.append(species[1])
        taxa_dic.update({species[1]:[species[0]]})
print(taxa_dic)



taxa_dic = {orders: [species[0] for species in taxa if species[1] == orders] \
            for orders in set(species[1] for species in taxa)}

print(taxa_dic)