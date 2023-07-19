#User account monitoring script: Monitor user account activity and report any unauthorized access attempts.

#sudo apt install acct
##commands
#ac : find number of hours 

#variable 
main_user="jean-louis"
find_users=$(ac -p | grep -v -e $main_user -e "total")
echo "$find_users"
number_extra_users=0

###check if another user was connected 
number_extra_users=$(echo "$find_users"| wc -l ) 
echo "$number_extra_users"

if [ $number_extra_users -ne 0 ]; then
    echo "[DANGER]  >> user << some extra users detected : $number_extra_users "
    exit 1 
else
    echo "[INFO]  >> user << none extra users detected"
    exit 0
fi