#User account monitoring script: Monitor user account activity and report any unauthorized access attempts.

#sudo apt install acct
##commands
#ac : find number of hours 

#variable 
main_user="jean-louis"
find_users=$(ac -p | grep -v -e $main_user -e "total")
number_extra_users=0

###check if another user was connected 
number_extra_users=$($find_users | wc -l ) 

if [ $number_extra_users -ne 0] then; 
    exit 1 
else
    exit 0