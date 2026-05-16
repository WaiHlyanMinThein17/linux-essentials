#!/bin/bash
#=========================================================================
# Topic 3.3 Lesson 2: Exit codes, Loops, and Input Validation
# Date: 2026-05-08
# Author: Wai Hlyan Min Thein
#=========================================================================

# --- Exit codes ---------------------------------------------------------
# Every command returns an exit code. 0 means success, non-zero means error.
# You can check the exit code of the last command with $?.

echo "--- Exit codes ---"
ls /home > /dev/null
echo "ls exit code: $?"

ls /nonexistent_directory > /dev/null 2>&1
echo "ls exit code: $?"

# --- Argument check ------------------------------------------------------
# exit terminates the script immediately with the given code.
# Anything after exit will not be executed.

echo ""
echo "--- Argument check ---"

if [ $# -eq 0 ]
then 
    echo "Usage: ./lesson-02-script.sh <arg1> <arg2> ..."
    echo "Example: ./lesson-02-script.sh Carol Dave Henry"
    exit 1
fi

# --- shift command ------------------------------------------------------
# shift removes the first argument and shifts all others to the left.
echo ""
echo "--- shift ---"

first=$1
echo "First argument: $first"
echo "All arguments before shift: $@"

shift

echo "All arguments after shift: $@"
echo "Total remaining arguments: $#"

# --- echo with -n option ------------------------------------------------------
# Build a single line of output across multiple echo commands.

echo ""
echo "--- echo with -n ---"

echo -n "Arguments remaining after shift: "
for item in $@
do
    echo -n "$item "
done
echo ""

# --- Input validation with grep and for loop --------------------------------------
# grep -E "^[A-Za-z]*$" checks if the username contains only letters.
# grep returns 0 if it finds a match, 1 if it doesn't, and 2 for errors.
# Redirecting output to /dev/null hides the grep output, we only care about the exit code.

echo ""
echo "--- Input validation and for loop ---"
echo "Validating and greeting: $first $@"
for username in $first $@
do 
    echo $username | grep -E "^[A-Za-z]*$ > /dev/null

    if [ $? -eq 1 ]
    then 
        echo "Error: '$username' contains invalid characters. Letters only."
        exit 2
    else
        echo "Hello, $username!"
    fi
done

exit 0