#!/bin/bash
## 测试：ACL Masking（审计时临时限制组写权限）
user=$(whoami)
if [ "$user" != "Senior-Auditor" ]; then
        echo "Please run this command as Senior-Auditor"
        exit 1
fi
echo -e "\n1. Testing ACL Masking (Audit Mode - Group Write Restricted)..."

# Set mask first, then apply restrictive permissions
setfacl -m g:Dev-Group-B:r-x /Multiple-projects-directory/DevA
setfacl -m g:Dev-Group-B:r-x /Multiple-projects-directory/DevB

echo "Mask set to r-x. Testing A1, B1 write access (should fail):"
echo "Please enter password for A1."
su - A1 -c "touch /Multiple-projects-directory/DevA/audit_test.txt && echo '' >> /Multiple-projects-directory/DevA/audit_test.txt" && echo '✅ A1 writes file' || echo "❌ A1 cannot write"
echo "Please enter password for B1."
su - B1 -c "touch /Multiple-projects-directory/DevB/audit_test.txt && echo '' >> /Multiple-projects-directory/DevB/audit_test.txt" && echo '✅ B1 writes file' || echo "❌ B1 cannot write"

# Revert to normal mode
echo -e "\n2. Restoring normal permissions..."
setfacl -m g:Dev-Group-A:rwx /Multiple-projects-directory/DevA
setfacl -m g:Dev-Group-B:rwx /Multiple-projects-directory/DevB/

echo "Mask restored to rwx. Testing A1, B1 write access (should work):"
echo "Please enter password for A1."
su - A1 -c "touch /Multiple-projects-directory/DevA/normal_test.txt && echo '' >> /Multiple-projects-directory/DevA/normal_test.txt" && echo '✅ A1 writes file' || echo "❌ A1 cannot write"
echo "Please enter password for B1."
su - B1 -c "touch /Multiple-projects-directory/DevB/normal_test.txt && echo '' >> /Multiple-projects-directory/DevB/normal_test.txt" && echo '✅ B1 writes file' || echo "❌ B1 cannot write"

# Cleanup
echo -e "\n3. Cleaning up test files..."
rm -f /Multiple-projects-directory/DevA/audit_test.txt \
      /Multiple-projects-directory/DevA/normal_test.txt \
      /Multiple-projects-directory/DevB/audit_test.txt \
      /Multiple-projects-directory/DevB/normal_test.txt
echo "Cleanup complete."

