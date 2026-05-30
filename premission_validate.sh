#!/bin/bash
# 2. 验证目录权限基础
echo -e "\n2. Checking base directory permissions..."
ls -ld /Multiple-projects-directory/DevA /Multiple-projects-directory/DevB

# 3. 测试 DevA 用户权限
echo -e "\n3. Testing A1 access to /Multiple-projects-directory/DevA..."
su - A1 -c "ls -la /Multiple-projects-directory/DevA && echo '✅ A1 can read DevA directory'"
su - A1 -c "touch /Multiple-projects-directory/DevA/devA_test.txt && echo '✅ A1 can write to DevA directory'"

# 4. 测试 DevB 用户访问 DevA（应该被拒绝）
echo -e "\n4. Testing B1 access to /Multiple-projects-directory/DevA (should fail)..."
su - B1 -c "ls /Multiple-projects-directory/DevA" 2>&1 || echo "❌ Expected: devB1 cannot access DevA directory"

# 5. 测试审计员权限（只能读，不能写）
echo -e "\n5. Testing Senior-Auditor permissions..."
su - Senior-Auditor -c "ls -la /Multiple-projects-directory/DevA && echo '✅ Auditor can read DevA directory'"
su - Senior-Auditor -c "touch /Multiple-projects-directory/DevA/auditor_test.txt" 2>&1 || echo "❌ Expected: Auditor cannot write to DevA directory"
