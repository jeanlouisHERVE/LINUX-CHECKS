#User account monitoring script: Monitor user account activity and report any unauthorized access attempts.

#sudo apt install acct

#variable 
main_user="jean-louis"
find_users=""

###check if another user was connected 
find_users=$(ac -p | grep -v -e $main_user -e "total") 
echo "$find_users"