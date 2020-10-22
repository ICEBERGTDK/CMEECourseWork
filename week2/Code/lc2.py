#!/usr/bin/env python3
"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'
"""

# Average UK Rainfall (mm) for 1910 by month
# http://www.metoffice.gov.uk/climate/uk/datasets
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

# (1) Use a list comprehension to create a list of month,rainfall tuples where
# the amount of rain was greater than 100 mm.

GreaterThan100 = []
for i in range(len(rainfall)):
    if rainfall[i][1] > 100:
        GreaterThan100.append(rainfall[i])
        print (rainfall[i])
"""greater than 100"""

# (2) Use a list comprehension to create a list of just month names where the
# amount of rain was less than 50 mm. 

LessThan50 = []
for i in range(len(rainfall)):
    if rainfall[i][1] < 50:
        LessThan50.append(rainfall[i][0])
        print (rainfall[i][0])
"""Less than 50"""

# (3) Now do (1) and (2) using conventional loops (you can choose to do 
# this before 1 and 2 !). 

