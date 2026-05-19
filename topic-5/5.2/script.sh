#!/bin/bash
#==========================================================================
# Topic 5.2: Creating Users and Groups
# Date: 2026-05-18
# Author: Wai Hlyan Min Thein
#==========================================================================

if [ $(id -u) -ne 0 ] 
then 
    echo "This script must be run with sudo."
    echo "Usage: sudo ./script.sh"
    exit 1
fi

# -- Variables --------------------------------------------------------------------------------

TEST_USER="testuser_512"
TEST_GROUP="testgroup_512"

# --- Inspect /etc/skel before creating user --------------------------------------------------
# /etc/skel contains template files copied into every new user's home directory.
# ls -Al show hidden files that ls alone would not display.

echo "--- /etc/skel contents ---"
echo ""
echo "Files that will be copied into the new user's home directory:"
ls -Al /etc/skel
echo ""

# --- CCreate a test group ---------------------------------------------------------------
# Groups must exit before assigning them to users witu useradd -G.
# groupadd with no option assigns the next avaialable GID automatically.

echo "--- Create test group ---"
echo ""

groupadd $TEST_GROUP
echo "Created group: $TEST_GROUP"
echo ""

# --- Create a test user ----------------------------------------------------------------------
# -m creates the home directory.
# -G add the user to the test group as a secondary group.
# -c sets the GECOS comment field.
# The account is locked until passwd is used to set a password.

echo "--- Create test user ---"
echo ""

useradd -m -G $TEST_GROUP -c "Test User for 5.2" $TEST_USER
echo "Created user: $TEST_USER"
echo ""

echo "Entry in /etc/passwd:"
grep "^$TEST_USER:" /etc/passwd
echo ""

echo "Entry in /etc/shadow (locked -- no password set yet):"
grep "^$TEST_USER:" /etc/shadow
echo ""

echo "Home directory contents (copied from /etc/skel):"
ls -Al /home/$TEST_USER
echo ""

# --- Set password ----------------------------------------------------------------
# passwd sets the password for a user.
# After setting, the shadow entry changes from locked to a hash.
# --stdin allows non-interactive password setting for scripting purposes.

echo "--- Set password ---"
echo "" 

echo "testpassword123" | passwd --stdin $TEST_USER 2>/dev/null

if [ $? -ne 0 ]
then
    echo "testpassword123" | chpasswd
fi

echo "Password set for $TEST_USER"
echo ""

echo "Shadow entry after password set:"
grep "^$TEST_USER:" /etc/shadow
echo ""

# --- Lock and unlock account ----------------------------------------------------------------
# Locking adds ! prefix to the hash in /etc/shadow.
# Unlocking removes it.
# This is how you can disable an account without deleting it.

echo "--- Lock and unlock account ---"
echo ""

passwd -l $TEST_USER > /dev/null
echo "Account locked. Shadow entry:"
grep "^$TEST_USER:" /etc/shadow
echo ""

passwd -u $TEST_USER > /dev/null
echo "Account unlocked. Shadow entry:"
grep "^$TEST_USER:" /etc/shadow
echo ""

# --- Verify group membership ----------------------------------------------------------------------
# id shows the user's UID, primary GID, and all group memberships.
# groups shows just the group names the user belongs to.

echo "--- Verify group membership ---"
echo ""

id $TEST_USER
echo ""
groups $TEST_USER
echo ""

# --- File permissions on access control files ------------------------------------------------------
# /etc/passwd and /etc/group are world-readable 
# /etc/shadow and /etc/gshadow are root-readable only for security reasons.

echo "--- Access control file permissions ---"
echo ""

ls -l /etc/passwd /etc/group /etc/shadow /etc/gshadow
echo ""

# -- Cleanup --------------------------------------------------------------------------------
# userdel -r removes the user, their home directory, and mail spool.
# groupdel removes the group.

echo "--- Cleanup ---"
echo ""

userdel -r $TEST_USER 2>/dev/null
echo "Deleted user: $TEST_USER"

groupdel $TEST_GROUP 2>/dev/null
echo "Deleted group: $TEST_GROUP"
echo ""

echo "Confirming removal -- these should return no output:"
grep "^$TEST_USER:" /etc/passwd
grep "^$TEST_GROUP:" /etc/group
echo "Cleanup complete."
echo ""

exit 0