```python
import argparse

parser = argparse.ArgumentParser(description='Desc line 1\n' + 'line 2', 
	formatter_class=argparse.RawTextHelpFormatter)
parser.add_argument('--arg1', action='store_true', dest='arg1', required=False,
				help='arg1 description')
subparsers = parser.add_subparsers(required=True, dest='arg2',
							   help='Subparsers for the different options for arg2')
subparser_ex1 = subparsers.add_parser('arg3', help='arg3 description')
subparser_ex2 = subparsers.add_parser('arg4', help='arg4 description',
							formatter_class=argparse.RawTextHelpFormatter)
subparser_ex2.add_argument('--arg5', type=str, action='store', dest='arg5', 
						required=True, help='arg5 description',
                        choices=['name1', 'name2', 'name3'])
subparser_ex2.add_argument('--arg6', type=float, action='store', dest='arg6',
						   required=True, help='arg6 description')

# Parse arguments
arguments = parser.parse_args()

# Access arguments
print(arguments.arg1) 
print(arguments.arg2) # This will be equal to the subparsers (arg3 or arg4)
print(arguments.arg5)

# To run and see argument options: 
# python3 test_parse.py -h -> See main options
# python3 test_parse.py -h -> See argument 4 options
```