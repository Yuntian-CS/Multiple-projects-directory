#!/bin/bash
# 1. 验证用户/组是否存在
echo -e "\n1. List all groups and users..."
cat /etc/group | awk -F: '{print $1, $3, $4}' | while read group gid members; do
    if [[ "$group" == "Dev-Group"* ]]; then
	    echo "Developer group:"
	    getent group $group
      echo "Developer group $group contains:"

#    members=$members,$(awk -F: "\$4 == $gid {print \" \" \$1}" /etc/passwd);
    members=$(awk -F: "\$4 == $gid {print \$1}" /etc/passwd | tr '\n' ' ');
    echo "$members" | sed 's/,,*/ /g';
    	for user in $members; do
    		id "$user"
	done
    fi
done
#echo "Groups and users details:"
