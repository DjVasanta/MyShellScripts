#!/bin/bash
#echo -e "First Name: \c  "
read -p "First Name: "  FNAME
#echo -e "Last Name: \c  "
read -p "Last Name: " LNAME
#echo -e "Department: \c  "
read -p "Department: " DEPT
#echo -e "Username: \c  "
read  -p "Username: " USER
#echo -e "Group: \c  "
read  -p "Group: " GROUP
#echo -e "Password: \c "

chpass ()
{
	read -sp "Password: " password
	echo -e "${password}\n${password}" | passwd $USER > /dev/null 2> /dev/null
	echo -e "\n"
}

useradd -c "$FNAME $LNAME [ $DEPT ]" -g $GROUP -m $USER  > /dev/null 2> /dev/null
if [ $? -eq 0 ]
then 
	chpass
	echo -e "\n\033[33mUser has been added to system!\033[0m"
else
	echo -e "\nFailed to add a user!" 
fi
