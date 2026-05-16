#!/bin/bash
#=========================================================================
# Topic 3.3 Lesson 1: Turning commands into a script
# Date: 2026-05-08
# Author: Wai Hlyan Min Thein
#=========================================================================

# -- Variables -----------------------------------------------------------
# Variables store values for reuse. No spaces around the equals sign.
# Case sensitive: name and Name are different variables.

name="Linux"
version=24

echo "Welcome to $name $version"
echo "Welcome to ${name} ${version}"

# -- Quote behavior ------------------------------------------------------
# Double quotes allow variable expansion.
# Single quotes treat everything as a literal string.

echo "Double quotes: Hello $name"
echo 'Single quotes: Hello $name'

# -- Command line arguments ------------------------------------------------
# $1, $2, ... represent the first, second, etc. command line arguments.
# $# gives the total number of arguments passed to the script.

echo "First argument: $1"
echo "Second argument: $2"
echo "Total arguments: $#"

# -- Conditional statements ------------------------------------------------
# Space is important in if statements. Use [ ] with spaces around them.
# Numeric operations: -eq -ne -gt -lt -ge -le
# String comparsion uses = and !=

if [ $# -eq 0]
then
    echo "Usage: ./lesson-01-script.sh <arg1> <arg2>"
    echo "Example: ./lesson-01-script.sh Carol"
    echo "Example: ./lesson-01-script.sh Carol Dave"

elif [ $# -eq 1 ]
then
    echo "Hello $1!"

elif [ $# -eq 2 ]
then
    echo "Hello $1 and $2!"

else 
    echo "Too many arguments. Please pass one or two names only."
    echo "You passed $# arguments."
fi