OUT = """
This is the first number {}
These are two strings {} {}
This is complicated {}
"""

OUT2 = """
This is the first number {3}
These are two strings {1} {2}
This is complicated {0}
""" # naast lege {} mag je ook een getal tussen de {} plaatsen dit geeft dan welke variabele aan de beurt is

print("Deze zin bevat een variabele waarde: {}".format(56))

print(OUT.format(5.13,"hello","world",[{'a':1},(1,2,3),'hello']))

print(OUT2.format(5.13,"hello","world",[{'a':1},(1,2,3),'hello']))

numbers = [1,2,3,4]

print("Getallen {} {} {} {}".format(*numbers))# Het * maakt dat de lijst wordt uitgepakt, dus aparte elementen

mydict={"who":"me","what":"world!"}

print("Hello {what}".format(**mydict)) # ** voor dictionaries