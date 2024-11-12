#! /usr/bin/env python

# Copyright (c) 2020-2024.

"""Rough draft of python wrapper for generating file hashes. THIS NEEDS TO BE CLEANED UP A BIT BEFORE it is anywhere near prod ready."""

import argparse


def parseArgs(arguments=[]):
	parser = argparse.ArgumentParser(description='gernerate and show file signatures.')
	action_group = parser.add_mutually_exclusive_group()
	action_group.add_argument(
		'-C', '--check', default=False, dest='io_action',
		action='store_true', help='Check the file hashes, and display'
	)
	action_group.add_argument(
		'-G', '--generate', default=True, dest='io_action',
		action='store_true', help='Generate the file hashes'
	)
	parser.add_argument('-f', '--file', required=True, help='the file to check')
	return parser.parse_args(arguments)


def extractRegexPattern(theInput_Str, theInputPattern):
	import re
	sourceStr = str(theInput_Str)
	prog = re.compile(theInputPattern)
	theList = prog.findall(sourceStr)
	return theList


def compactList(list, intern_func=None):
	if intern_func is None:
		def intern_func(x): return x
	seen = {}
	result = []
	for item in list:
		marker = intern_func(item)
		if marker in seen: continue
		seen[marker] = 1
		result.append(item)
	return result


def main(argv=None):
	args = parseArgs(argv)
	file = args.file
	generate_new = False
	theResult = dict({256:None, 512:None})
	if args.io_action is not None:
		generate_new = args.io_action
	if file is not None:
		import subprocess
		import os
		import os.path
		try:
			for hash_level in [256, 512]:
				cli_args = ["openssl", "dgst", str("-sha{}").format(str(hash_level)), str(os.path.abspath(file))]
				theResult[hash_level] = subprocess.check_output(cli_args)
		except Exception:
			theResult = None
		if theResult is not None:
			for key in theResult.keys():
				print(str("sha{}: {}").format(key, theResult[key]))
	exit(0)


if __name__ in '__main__':
	import sys
	main(sys.argv[1:])
