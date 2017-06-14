"""
Description of the program....
Dit wordt bij de help van je programma door python getoond
"""
# Imports
import sys

# Constants

# Classes

# Functions
def process(filename):
    print(filename)
	return

def main(argv=None):
#Dit is altijd de laatste functie definitie
#Deze wordt niet automatische uitgevoerd zoals bijv in C
    if argv is None:
	    argv = sys.argv
		
	# hier komt de besturing van het programma
	filename = argv[1]
	result = process(filename)
	
	return result
	

if __name__ == "__main__":
    sys.exit(main())