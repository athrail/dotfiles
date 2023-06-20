#!/usr/bin/env python

# This is a script for automatic repo creation and creating new project on gitlab
#
# Written by Antoine Calando / 2017 - Public domain

import subprocess
import re
import sys
import os
import argparse

code_dir = os.path.expanduser('~') + '/code'

parser = argparse.ArgumentParser()
parser.add_argument('name', help="Project name (will be used as directory name as well)")
args = parser.parse_args()

project_path = "{}/{}".format(code_dir, args.name)

if os.path.exists(project_path):
    print("There already directory with that name! Please choose a different one")
    exit(1)

os.mkdir(project_path)

if not os.path.exists(project_path):
    print("Couldn't create dir @ {}. Make sure you've got access rights.".format(project_path))
    exit(1)

os.chdir(project_path)

os.system('git init')
with open('{}/{}'.format(project_path, "readme.md"), 'x') as file:
    file.writelines([
        '# Project: {}\n'.format(args.name),
        '\n',
        'This is a new empty project created through create_project.py\n',
        '\n',
        'This is licensed under MIT license\n'
    ])

os.system('git add readme.md')
os.system('git commit -s -m "Initial commit"')
os.system('git push --set-upstream git@gitlab.com:athrail/{}.git master'.format(args.name))

os.system('cd {}'.format(project_path))

exit(0)