#!/bin/bash
## 9. 测试：密码复杂度策略
echo -e "\n9. Testing password complexity policy..."
echo "Trying to set weak password for devA1 (should fail):"
echo "Change user to A1, please enter password for A1."
su A1 -c 'echo "Please enter password for A1 again." && passwd'
if [ $? -eq 0 ]; then
    echo "OK, password sucessfully changed"
else
    echo FAILed
fi
echo "Trying to set strong password (14+ chars, mixed types):"
echo "try change password to StrongPass123!"
echo "Change user to A1, please enter password for A1."
su A1 -c 'echo "Please enter password for A1 again." && passwd'
if [ $? -eq 0 ]; then
    echo OK, password sucessfully changed
else
    echo FAILed
fi
