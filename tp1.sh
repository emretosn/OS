# 1.1
wget https://burakarslan.com/inf333/tp/tp1.tar.gz

# 1.2
mkdir tp1
cd tp1

# 1.3
tar -xzf ../tp1.tar.gz

# 1.4
ls -l

# 1.5
# We can learn the number of total files in the directory with
# the "ls -l | grep ^- | wc -l" command. There are 100 each
# 128 bytes so 12800 bytes in total. But "du -b" shows 16896 bytes.
# Block sizes, hard links and sparse files create the difference.
du -b

# 1.6
mkdir {1,2,3,4,5,6,7,8,9}

# 1.7
find . -maxdepth 1 -type f -name '[1-9]*' -exec bash -c 'mv "$1" "${1:2:1}/$1"' _ {} \;
# Explanation: The find command finds every file that start with
# numbers ranging from 1 to 9 with the depth restricted to the current
# directory. The executed command for each file found moves the file
# to the respected directory {1:2:1} taking the second argument in
# "./12266.bin" for example skipping "./"

# 1.8
ls [1-9]

# 1.9
find . -maxdepth 1 -type d -name '[1-9]' -exec chmod a-x {} \;
# Explanation: Finding the directories and executing the removal
# of the executable for each one found.

# 1.10
ls [1-9]
# Explanation: If we remove the executable bit from the directories
# we're essentially revoking our permission to view them. So the ls 
# command results in permission denied.

# 1.11
chmod +x [1-9]

# 1.12
find [1-9] -type f -exec mv -t . {} +
rm -r [1-9]

# 1.13
du -b
# The size is shown as 16896 so there is no change. Modifying the
# location of the files and changing the file permissions doesn't 
# effect the file size.
