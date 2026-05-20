#!/bin/bash
# =============================================================================
# Topic 5.3: Managing File Permissions and Ownership
# Date:    2026-05-19
# Author:  Wai Hlyan Min Thein
# =============================================================================

# -- Variables ----------------------------------------------------------------

WORK_DIR="/tmp/permissions_demo_53"
TEST_FILE="$WORK_DIR/testfile.txt"
TEST_DIR="$WORK_DIR/testdir"
CURRENT_UID=$(id -u)


# -- Setup --------------------------------------------------------------------
# Create a working directory in /tmp for all demo files.
# Everything is cleaned up at the end.

mkdir -p $WORK_DIR
mkdir -p $TEST_DIR
echo "Permission demo file" > $TEST_FILE
echo ""
echo "Working directory: $WORK_DIR"
echo ""


# Reading ls -l output ------------------------------------------
# ls -l shows file type, permissions, links, owner, group, size, date, name.
# ls -lh shows human readable sizes.
# ls -la includes hidden files.

echo "--- Section 1: Reading ls -l output ---"
echo ""

echo "Long listing of test file:"
ls -l $TEST_FILE
echo ""

echo "Long listing of test directory:"
ls -ld $TEST_DIR
echo ""

echo "Column breakdown for the file above:"
echo "  Character 1    : file type (- = regular file, d = directory)"
echo "  Characters 2-4 : owner permissions"
echo "  Characters 5-7 : group permissions"
echo "  Characters 8-10: others permissions"
echo ""


# chmod symbolic mode -------------------------------------------
# Symbolic mode lets you modify one permission at a time.
# Useful when you want to add or remove without affecting the rest.

echo "--- Section 2: chmod symbolic mode ---"
echo ""

echo "Starting permissions:"
ls -l $TEST_FILE
echo ""

chmod u+x $TEST_FILE
echo "After chmod u+x (add execute for owner):"
ls -l $TEST_FILE

chmod g+w $TEST_FILE
echo "After chmod g+w (add write for group):"
ls -l $TEST_FILE

chmod o-r $TEST_FILE
echo "After chmod o-r (remove read from others):"
ls -l $TEST_FILE

chmod a=rw $TEST_FILE
echo "After chmod a=rw (set exactly rw for everyone):"
ls -l $TEST_FILE
echo ""


# chmod numeric mode --------------------------------------------
# Numeric mode sets all three permission groups at once.
# Each digit is the sum of r=4, w=2, x=1 for that group.

echo "--- Section 3: chmod numeric mode ---"
echo ""

chmod 755 $TEST_FILE
echo "chmod 755 (rwxr-xr-x):"
ls -l $TEST_FILE

chmod 644 $TEST_FILE
echo "chmod 644 (rw-r--r--):"
ls -l $TEST_FILE

chmod 600 $TEST_FILE
echo "chmod 600 (rw-------):"
ls -l $TEST_FILE

chmod 660 $TEST_FILE
echo "chmod 660 (rw-rw----):"
ls -l $TEST_FILE
echo ""


# Permission check order ----------------------------------------
# Linux checks owner first, then group, then others.
# The first matching category applies. The rest are ignored.

echo "--- Section 4: Permission check order ---"
echo ""

chmod 044 $TEST_FILE
echo "chmod 044 -- owner has NO permissions, group and others have read:"
ls -l $TEST_FILE
echo ""
echo "Your identity:"
id
echo ""
echo "If you own this file, you cannot read it even though group"
echo "and others have read permission. Owner match comes first."
echo ""

# Reset to a sensible permission before continuing
chmod 644 $TEST_FILE


# chown and chgrp -----------------------------------------------
# chown changes ownership. chgrp changes group ownership.
# Only root can change ownership to another user.

echo "--- Section 5: Ownership inspection ---"
echo ""

echo "Current ownership of test file:"
ls -l $TEST_FILE
echo ""

echo "Your current groups:"
groups
echo ""

# Change group to one you already belong to
# Find a secondary group the current user is in
SECONDARY_GROUP=$(groups | tr ' ' '\n' | grep -v "^$(id -gn)$" | head -1)

if [ -n "$SECONDARY_GROUP" ]
then
  chgrp $SECONDARY_GROUP $TEST_FILE
  echo "Changed group to $SECONDARY_GROUP (a group you belong to):"
  ls -l $TEST_FILE
  echo ""
  chgrp $(id -gn) $TEST_FILE
  echo "Changed back to primary group:"
  ls -l $TEST_FILE
else
  echo "No secondary group found to demonstrate chgrp."
fi
echo ""


# Special permissions -------------------------------------------
# Sticky bit, SGID, and SUID extend the standard permission model.

echo "--- Section 6: Special permissions ---"
echo ""

# Sticky bit on a directory
chmod +t $TEST_DIR
echo "Sticky bit set on directory (chmod +t):"
ls -ld $TEST_DIR
echo "The 't' in the others execute position indicates the sticky bit."
echo "Only file owners can delete their own files inside this directory."
echo ""

# SGID on a directory
chmod g+s $TEST_DIR
echo "SGID set on directory (chmod g+s):"
ls -ld $TEST_DIR
echo "The 's' in the group execute position indicates SGID."
echo "New files created here will inherit this directory's group."
echo ""

# SUID demonstration 
echo "Real world SUID example -- the passwd binary:"
ls -l $(which passwd)
echo "The 's' in the owner execute position is the SUID bit."
echo "This allows regular users to run passwd as root, which is"
echo "required to write the new password hash to /etc/shadow."
echo ""

# Numeric special permissions
chmod 1755 $TEST_DIR
echo "chmod 1755 (sticky bit + rwxr-xr-x):"
ls -ld $TEST_DIR

chmod 2755 $TEST_DIR
echo "chmod 2755 (SGID + rwxr-xr-x):"
ls -ld $TEST_DIR

chmod 0755 $TEST_DIR
echo "chmod 0755 (remove all special bits):"
ls -ld $TEST_DIR
echo ""


# Uppercase S and T ---------------------------------------------
# Uppercase S or T means the special bit is set but execute is absent.

echo "--- Section 7: Uppercase S and T ---"
echo ""

chmod 0644 $TEST_FILE

chmod u+s $TEST_FILE
echo "SUID set without execute permission (uppercase S):"
ls -l $TEST_FILE
echo "Uppercase S means SUID is set but owner has no execute permission."
echo "This is usually unintentional."
echo ""

chmod g+s $TEST_FILE
echo "SGID set without execute permission (uppercase S on group):"
ls -l $TEST_FILE
echo ""

# Reset
chmod 644 $TEST_FILE


# -- Cleanup ------------------------------------------------------------------

echo "--- Cleanup ---"
echo ""
rm -rf $WORK_DIR
echo "Removed $WORK_DIR"
echo ""

exit 0