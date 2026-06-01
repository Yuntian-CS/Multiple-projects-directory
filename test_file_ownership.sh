#!/bin/bash
## 6. 测试文件不可变保护
user=$(whoami)
if [ "$user" != "Senior-Auditor" ]; then
        echo "Please run this command as Senior-Auditor"
        exit 1
fi
echo -e "\n6. Testing immutable file protection..."
lsattr /Multiple-projects-directoryDevA/config.ini
echo "Trying to modify config.ini (should fail)..."
echo "test" > /Multiple-projects-directoryDevA/config.ini 2>&1 || echo "❌ Expected: Cannot modify immutable file"

# 7. 测试：新文件继承父目录权限，忽略 umask
echo -e "\n7. Testing default ACL inheritance (ignores umask)..."
echo "Please enter password for A1."
su - A1 -c "echo 'A1 original umask:'; umask"
echo "Please enter password for A1."
su - A1 -c "touch /Multiple-projects-directory/DevA/inherit_test1.txt"
echo "create inherit_test1.txt："
ls -l /Multiple-projects-directory/DevA/inherit_test1.txt
getfacl /Multiple-projects-directory/DevA/inherit_test1.txt
echo "Please enter password for A1."
su - A1 -c "umask 077; touch /Multiple-projects-directory/DevA/inherit_test2.txt"
echo -e "\nchange umask=077 and create inherit_test2.txt："
ls -l /Multiple-projects-directory/DevA/inherit_test2.txt
getfacl /Multiple-projects-directory/DevA/inherit_test2.txt
echo -e "\n✅ expected：two files ACL are same，not affected by umask"

