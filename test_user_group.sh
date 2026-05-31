#!/bin/bash
# 1. 验证用户/组是否存在
echo -e "\n1. List all groups and users..."
cat /etc/group | awk -F: '{print $1, $3, $4}' | while read group gid members; do
    if [[ "$group" == "Dev-Group"* ]]; then
      echo "Developer group $group contains:"
    members=$members,$(awk -F: "\$4 == $gid {print \",\" \$1}" /etc/passwd);
    echo "$members" | sed 's/,,*/ /g';
    fi
done
echo "Groups and users details:"
getent group Dev-Group-A
getent group Dev-Group-B
id A1
id A2
id A3
id B1
id B2
id Senior-Auditor
