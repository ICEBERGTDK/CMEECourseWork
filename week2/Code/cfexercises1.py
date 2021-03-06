#!/usr/bin/env python3

"""Writing a Program with Control flows Practical"""
__author__ = 'Dengkui Tang (dengkui.tang20@imperial.ac.uk)'
__version__ = '0.0.1'

import sys
# What does each of foo_x do? 
def foo_1(x):
    return x ** 0.5   
"""x**0.5"""

def foo_2(x, y):
    if x > y:
        return x
    return y
"""x>y"""

def foo_3(x, y, z):
    if x > y:
        tmp = y
        y = x
        x = tmp
    if y > z:
        tmp = z
        z = y
        y = tmp
    return [x, y, z]
"""x>y,y>z"""

def foo_4(x):
    result = 1
    for i in range(1, x + 1):
        result = result * i
    return result
"""x!"""

def foo_5(x): # a recursive function that calculates the factorial of x
    if x == 1:
        return 1
    return x * foo_5(x - 1)
"""x!"""

def foo_6(x): # Calculate the factorial of x in a different way
    facto = 1
    while x >= 1:
        facto = facto * x
        x = x - 1
    return facto
"""x!"""

def main(argv): # the main function
    print(foo_1(2))
    print(foo_2(3,8))
    print(foo_3(7,5,3))
    print(foo_4(5))
    print(foo_5(10))
    print(foo_6(5))
    return 0
"""the main function"""

if (__name__ == "__main__"):
    status = main(sys.argv)
    sys.exit(status)