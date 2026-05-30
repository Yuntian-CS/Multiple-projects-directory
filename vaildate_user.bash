#!/bin/bash
# 1. 验证用户/组是否存在
echo -e "\n1. Checking users and groups..."
id A1
id A2
id A3
id B1
id B2
id Senior-Auditor
getent group Dev-Group-A
getent group Dev-Group-B
