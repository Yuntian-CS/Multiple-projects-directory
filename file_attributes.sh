#!/bin/bash
## 6. 测试文件不可变保护
echo -e "\n6. Testing immutable file protection..."
lsattr /Multiple-projects-directoryDevA/config.ini
echo "Trying to modify config.ini (should fail)..."
echo "test" > /Multiple-projects-directoryDevA/config.ini 2>&1 || echo "❌ Expected: Cannot modify immutable file"

# 7. 测试：新文件继承父目录权限，忽略 umask
echo -e "\n7. Testing default ACL inheritance (ignores umask)..."
su - A1 -c "echo 'A1 原始 umask:'; umask"
su - A1 -c "touch /Multiple-projects-directory/DevA/inherit_test1.txt"
echo "新建 inherit_test1.txt 权限："
ls -l /Multiple-projects-directory/DevA/inherit_test1.txt
getfacl /Multiple-projects-directory/DevA/inherit_test1.txt

su - A1 -c "umask 077; touch /Multiple-projects-directory/DevA/inherit_test2.txt"
echo -e "\n改 umask=077 后新建 inherit_test2.txt 权限："
ls -l /Multiple-projects-directory/DevA/inherit_test2.txt
getfacl /Multiple-projects-directory/DevA/inherit_test2.txt
echo -e "\n✅ 预期：两个文件 ACL 完全一样，不受 umask 影响"

