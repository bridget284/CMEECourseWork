# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.
# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 
# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 


#!/Bridget/bin/env python3

"""Using lists to create a list of month,rainfall tuples where
 the amount of rain was greater than 100 mm, create a list of just month names where the
 amount of rain was less than 50 mm, with conventional loops and list comprehension"""

__appname__ = "[lc2.py]"
__author__ = "Bridget Smith (bridget.smith24@imperial.ac.uk)"
__version__ = "0.0.1"



rainfall = (('JAN',111.4),
            ('FEB',126.1),
            ('MAR', 49.9),
            ('APR', 95.3),
            ('MAY', 71.8),
            ('JUN', 70.2),
            ('JUL', 97.1),
            ('AUG',140.2),
            ('SEP', 27.0),
            ('OCT', 89.4),
            ('NOV',128.4),
            ('DEC',142.2),
           )

#### EXERCISE 3 - conventional lists

high_rain1 = []
for month in rainfall:
    if month[1] > 100:
        high_rain1.append(month)
print(high_rain1)

loww_rain1 = []
for month in rainfall:
    if month[1] < 50:
        loww_rain1.append(month)
print(loww_rain1)



#### EXERCISE 1 & 2 - list comprehension
high_rain2 = {month for month in rainfall if month[1] > 100}
print(high_rain2)

loww_rain2 = {month for month in rainfall if month[1] < 50}
print(loww_rain2)