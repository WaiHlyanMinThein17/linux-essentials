#!/bin/bash
# =============================================================================
# Topic 5.4: Special Directories and Files
# Date:    2026-05-19
# Author:  Wai Hlyan Min Thein
# =============================================================================

# -- Variables ----------------------------------------------------------------

WORK_DIR="/tmp/links_demo_54"
ORIGINAL="$WORK_DIR/original.txt"
HARDLINK="$WORK_DIR/hardlink.txt"
SYMLINK="$WORK_DIR/symlink.txt"
SYMLINK_REL="$WORK_DIR/symlink_relative.txt"


# -- Setup --------------------------------------------------------------------

mkdir -p $WORK_DIR
echo "This is the original file content." > $ORIGINAL
echo ""
echo "Working directory: $WORK_DIR"
echo ""


# Temporary directories -----------------------------------------
# /tmp and /var/tmp both have the sticky bit set (drwxrwxrwt).
# /run is always cleared on boot and holds runtime data.

echo "--- Temporary directories ---"
echo ""

echo "Permissions and sticky bit on temp directories:"
ls -ldh /tmp /var/tmp /run
echo ""

echo "Is /var/run a symlink to /run?"
ls -ld /var/run
echo ""


# Creating and identifying hard links ---------------------------
# A hard link is a second directory entry pointing to the same inode.
# ls -li shows inode numbers. Same inode = hard link.
# Link count increases by one for each hard link created.

echo "--- Hard links ---"
echo ""

ln $ORIGINAL $HARDLINK
echo "Created hard link: $HARDLINK"
echo ""

echo "ls -li output (note inode numbers and link count):"
ls -li $ORIGINAL $HARDLINK
echo ""

echo "Both files show the same inode number."
echo "Link count is 2 -- two directory entries point to the same data."
echo ""

echo "Reading content through the hard link:"
cat $HARDLINK
echo ""


# Hard link survives original deletion --------------------------
# Because a hard link points to the inode directly, deleting the original file only removes one directory entry. 
#The data remains on disk until all hard links are removed.

echo "--- Hard link after original is deleted ---"
echo ""

echo "Inode and link count before deletion:"
ls -li $ORIGINAL $HARDLINK
echo ""

rm $ORIGINAL
echo "Deleted $ORIGINAL"
echo ""

echo "Hard link still exists and link count is now 1:"
ls -li $HARDLINK
echo ""

echo "Data is still accessible through the hard link:"
cat $HARDLINK
echo ""

# Recreate original for the symlink sections
echo "This is the original file content." > $ORIGINAL


# Creating symbolic links ---------------------------------------
# ln -s creates a symbolic link.
# Always use an absolute path to prevent broken links if moved.
# The link shows l as its file type and displays the target path.

echo "--- Section 4: Symbolic links ---"
echo ""

ln -s $ORIGINAL $SYMLINK
echo "Created symbolic link with absolute path: $SYMLINK"
echo ""

echo "ls -li output (note different inode from original):"
ls -li $ORIGINAL $SYMLINK
echo ""

echo "First character is l -- symbolic link."
echo "The arrow shows the path the link points to."
echo ""

echo "Reading content through the symlink:"
cat $SYMLINK
echo ""


# Symlink breaks when target is deleted -------------------------
# A symbolic link points to a path. 
# If that path no longer exists, the link becomes a dangling link and cannot be read.

echo "--- Dangling symlink ---"
echo ""

rm $ORIGINAL
echo "Deleted $ORIGINAL"
echo ""

echo "Symlink still shows in ls -l but the target is gone:"
ls -l $SYMLINK
echo ""

echo "Attempting to read through the broken symlink:"
cat $SYMLINK 2>&1
echo ""

echo "Exit code from failed read: $?"
echo "A non-zero exit code confirms the link is broken."
echo ""

# Recreate original for remaining sections
echo "This is the original file content." > $ORIGINAL


# Symlink permissions vs target permissions ---------------------
# Symlinks always display lrwxrwxrwx in ls -l.
# These are the link's own permissions and are irrelevant.
# Actual access is controlled by the target file's permissions.

echo "--- Symlink permissions ---"
echo ""

chmod 600 $ORIGINAL
echo "Set target permissions to 600 (rw-------):"
ls -l $ORIGINAL
echo ""

echo "Symlink still shows rwxrwxrwx -- these belong to the link itself:"
ls -l $SYMLINK
echo ""

echo "But actual access follows the target permissions."
echo "Attempting to read target (owner has read, this should work):"
cat $SYMLINK
echo ""

chmod 000 $ORIGINAL
echo "Set target permissions to 000 (no permissions):"
ls -l $ORIGINAL
echo ""

echo "Attempting to read through symlink (should be denied):"
cat $SYMLINK 2>&1
echo "Exit code: $?"
echo ""

# Reset
chmod 644 $ORIGINAL


# Relative vs absolute symlink paths ----------------------------
# A relative symlink path is resolved from the directory containing the link. 
# Moving the link breaks it. An absolute path always works.

echo "--- Relative vs absolute path symlinks ---"
echo ""

# Create a subdirectory and move the relative symlink into it
SUBDIR="$WORK_DIR/subdir"
mkdir -p $SUBDIR

ln -s original.txt $SYMLINK_REL
echo "Created relative symlink pointing to: original.txt"
ls -l $SYMLINK_REL
echo ""

echo "Reading while in same directory (works):"
cat $SYMLINK_REL
echo ""

mv $SYMLINK_REL $SUBDIR/
echo "Moved relative symlink to subdirectory."
echo "Attempting to read from new location (will break):"
cat $SUBDIR/symlink_relative.txt 2>&1
echo "Exit code: $?"
echo ""

echo "Absolute symlink moved to same subdirectory (still works):"
cp $SYMLINK $SUBDIR/symlink_absolute.txt
cat $SUBDIR/symlink_absolute.txt
echo ""


# -- Cleanup ------------------------------------------------------------------

echo "--- Cleanup ---"
echo ""
rm -rf $WORK_DIR
echo "Removed $WORK_DIR"
echo ""

exit 0