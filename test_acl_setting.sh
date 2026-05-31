#!/bin/bash
## 测试：ACL Masking（审计时临时限制组写权限）
echo -e "\n1. Testing ACL Masking (Audit Mode - Group Write Restricted)..."
setfacl -m m:r-x /Multiple-projects-directory/DevA
echo "Mask set to r-x. Testing A1 write access (should fail):"
echo "Please enter password for A1."
su - A1 -c "touch /Multiple-projects-directory/DevA/audit_test.txt" 2>&1 || echo "❌ Expected: A1 cannot write during audit mode"

setfacl -m m:rwx /Multiple-projects-directory/DevA
echo "Mask restored to rwx. Testing A1 write access (should work):"
echo "Please enter password for A1."
su - A1 -c "touch /Multiple-projects-directory/DevA/audit_test.txt" 2>&1 || echo "❌ Expected: A1 cannot write during audit mode"
su - A1 -c "touch /Multiple-projects-directory/DevA/audit_test.txt" 2>&1 || echo "❌ Expected: A1 cannot write during audit mode"
su - A1 -c "touch /Multiple-projects-directory/DevA/normal_test.txt && echo '✅ A1 write access restored'"
