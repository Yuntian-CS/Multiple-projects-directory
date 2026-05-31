#!/bin/bash
## 9. 测试：密码复杂度策略
echo -e "\n9. Testing password complexity policy..."
echo "Trying to set weak password for devA1 (should fail):"
echo "123456" | passwd A1 --stdin 2>&1 || echo "❌ Expected: Weak password rejected"

echo "Trying to set strong password (14+ chars, mixed types):"
echo "StrongPass123!" | passwd A1 --stdin 2>&1 && echo "✅ Strong password accepted"
