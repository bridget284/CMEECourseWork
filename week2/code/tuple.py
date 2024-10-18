#!/Bridget/bin/env python3

"""Birds is a tuple of tuples of length three: latin name, common name, mass.
 write a (short) script to print these on a separate line or output block by
 species """

__appname__ = "[tuple.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"


birds = ( ('Passerculus sandwichensis','Savannah sparrow',18.7),
          ('Delichon urbica','House martin',19),
          ('Junco phaeonotus','Yellow-eyed junco',19.5),
          ('Junco hyemalis','Dark-eyed junco',19.6),
          ('Tachycineata bicolor','Tree swallow',20.2),
        )

#loop that 
for species in birds:
    print(f"Latin name: {species[0]}; Common name: {species[1]}; Mass: {species[2]}")
