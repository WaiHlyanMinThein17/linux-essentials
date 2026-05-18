#!/bin/bash
#===================================================================
# Topic 5.1: Basic Security and Identifying User Types
# Date: 2026-05-18
# Author: Wai Hlyan Min Thein
#===================================================================

# --- Current user identity ------------------------------
# id shows your UID, primary GID, and group memberships
# The prompt character $ indicates a regular user, while # indicates root

echo "--- Current user identity ---"
echo ""

echo "Current user: $USER"
echo "Home directory: $HOME"
echo ""
id
echo ""

# --- Detecting account type based on UID ----------------------
# UIDs below 1000 are system accounts.
# UIDS at 1000 and above are regular or service accounts.
# UID 0 is always root (superuser).

echo "--- Account type detection ---"
echo ""

current_uid=$(id -u)
echo "Your UID is: $current_uid"

if [ $current_uid -eq 0 ]
then
    echo "Account type: root (superuser)"
elif [ $current_uid -lt 1000 ]
then
    echo "Account type: system user"
else
    echo "Account type: regular user"
fi
echo "" 

# --- Reading /etc/passwd ---------------------------------
# /etc/passwd is readable by all users and contains user account information.

echo "--- Your entry in the /etc/passwd file ---"
echo ""

grep "^$USER:" /etc/passwd
echo ""

# Show the first few system accounts to illustrate the difference in UIDs
echo "Sample system accounts (UID below 1000):"
awk -F: '$3 < 1000 && $3 > 0 {print $1, "UID="$3, "Shell="$7}' /etc/passwd | head -5
echo ""

# --- Reading /etc/group --------------------------------
# /etc/group is readable by all users.
# It shows the groups you belong to, including your primary group.

echo "--- Your groups membership ---"
echo ""

echo "Groups for $USER:"
groups
echo ""

echo "Your primary group entry in /etc/group:"
primary_gid=$(id -g)
grep ":$primary_gid:" /etc/group
echo ""

# --- /etc/shadow access check -------------------------------
# /etc/shadow is readable by root only.
# It contains password hashes and is protected for security reasons.

echo "--- /etc/shadow access check ---"
echo ""

if [ $current_uid -eq 0 ]
then
    echo "Running as root -- reading your /etc/shadow entry:"
    grep "^$USER:" /etc/shadow
else
    echo "Running as regular user -- attempting to read your /etc/shadow entry:"
    cat /etc/shadow > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        echo "Access denied. /etc/shadow requires root privileges."
        echo "The file is protected."
    fi
fi
echo ""

# --- Active logins and login history --------------------------------
# who shows currently logged in users.
# last shows recent login history from /var/log/wtmp.

echo "--- Active logins and history ---"
echo ""

echo "Currently logged in users:"
who
echo ""

echo "Your recent login history (last 5 entries):"
last $USER | head -5 2>/dev/null || lastlog2 | grep "^$USER"
echo ""

exit 0