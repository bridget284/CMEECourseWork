#!/Bridget/bin/env python3

"""Write three separate list comprehensions that create three different
lists containing the latin names, common names and mean body masses for
each species in birds, respectively. """

__appname__ = "[lc1.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"

birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
         )

#### EXERCISE 2 - conventional loops
latin1 = []
for species in birds:
        latin1.append(species[0])
print(latin1)

comon1 = []
for species in birds:
        comon1.append(species[1])
print(comon1)

avebm1 = []
for species in birds:
        avebm1.append(species[2])
print(avebm1)


#### EXERCISE 1 - list comprehensions
latin2 = {species[0] for species in birds}
print(latin2)

comon2 = {species[1] for species in birds}
print(comon2)

avebm2 = {species[2] for species in birds}
print(avebm2)