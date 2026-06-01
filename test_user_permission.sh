#!/bin/bash
#verify user is Senior-Auditor
user=$(whoami)
if [ "$user" != "Senior-Auditor" ]; then
        echo "Please run this command as Senior-Auditor"
        exit 1
fi

echo -e "\nChecking base directory permissions..."
ls -ld /Multiple-projects-directory/DevA /Multiple-projects-directory/DevB

# Don't pipe directly to while read - use process substitution
while read group gid members; do
    if [[ "$group" == "Dev-Group"* ]]; then

        members=$(awk -F: -v gid="$gid" '$4 == gid {print $1}' /etc/passwd | tr '\n' ' ')
        for user in $members; do
		# Skip users without passwords
#            password_field=$(grep "^$user:" /etc/shadow | cut -d: -f2)
 #           if [[ -z "$password_field" ]] || [[ "$password_field" =~ ^[!*]*$ ]]; then
  #              echo "⚠️  Skipping $user: no password set"
   #             continue
    #        fi
            	echo "Processing user: $user"
            	if [[ "$user" == A* ]]; then

                echo "Testing $user access to /Multiple-projects-directory/DevA..."
                echo "Please enter password for $user"

                # Use -S flag or redirect password prompt to /dev/tty
                su "$user" -c 'ls /Multiple-projects-directory/DevA >> /dev/null && echo "✅ '"$user"' can read DevA" || echo "❌ cannot access DevA"' </dev/tty

                echo "Please enter password for $user"
                su "$user" -c 'touch /Multiple-projects-directory/DevA/devA_'"$user"'_test.txt && echo "✅ '"$user"' can write to DevA" || echo "❌ cannot write to DevA"' </dev/tty
		elif [[ "$user" == B* ]]; then
                # Test Dev-Group-B users write permissions on DevB folder

                echo "Testing $user access to /Multiple-projects-directory/DevB..."
                echo "Please enter password for $user"

                su "$user" -c 'ls /Multiple-projects-directory/DevB >> /dev/null && echo "✅ '"$user"' can read and execute DevB directory" || echo "❌ '"$user"' cannot access DevB directory"' </dev/tty

                echo "Please enter password for $user"
                su "$user" -c 'touch /Multiple-projects-directory/DevB/devB_'"$user"'_test.txt && echo "✅ '"$user"' can write to DevB directory" || echo "❌ '"$user"' cannot write to DevB directory"' </dev/tty

            else
                # Optional: handle users that don't match A* or B*
                echo "Skipping $user (does not match A* or B* pattern)"
            fi
        done
    fi
done < <(awk -F: '{print $1, $3, $4}' /etc/group)
