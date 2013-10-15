#!/bin/bash
# set -x
banner ()
{
clear
echo -e "\033[35m##########################################################################################"
echo "##########################################################################################"
echo "##                                                                                      ##"
echo -e "##                        \033[32m\033[4mWelcome to User Managment Console\033[0m            \033[35m                 ##"
echo "##                                                                                      ##"
echo "##########################################################################################"
echo "##########################################################################################"
echo -e "\033[0m"
}

createuser ()
{
banner
echo -e "\033[1mFirst Name:\033[0m \c "
read FName

echo -e "\033[1mLast  Name:\033[0m \c "
read LName

echo -e "\033[1mDepartment:\033[0m \c "
read DEPT

CNT=1
while [ $CNT -eq 1 ]
do
echo -e "\033[1mLogin Name:\033[0m \c "
read logname

TUSR=/tmp/.user
TGRP=/tmp/.group
TGRP1=/tmp/.group1
grep -w "^$logname" /etc/passwd > $TUSR
	if [ $? = 0 ]
	then
		banner
		echo -e "\033[1m---------------------------------------- WARNING -----------------------------------------\033[0m"
		echo -e "\033[31m                       User with Login Name $logname already exist.\033[0m"
		echo -e "\033[1m------------------------------------------------------------------------------------------\033[0m"
		echo -e "\033[1mFirst Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f1`\033[0m"
		echo -e "\033[1mLast  Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f2`\033[0m"
		echo -e "\033[1mDepartment: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f4`\033[0m"
		id -Gn $logname > $TGRP
		GRP=`id -gn $logname`
		sed s/"$GRP"// $TGRP > $TGRP1
		echo -e "\033[1mLogin Name: \033[33m`cut -d: -f1 $TUSR`\033[0m \033[1mUserID: \033[33m`cut -d: -f3 $TUSR`\033[0m"
		echo -e "\033[1mPrimary Group: \033[33m`id -gn $logname`\033[0m\c "
		TST=`wc -w $TGRP1 | cut -d" " -f1`
		if [ $TST -eq 0 ]
		then
			echo -e "\033[1m Secondary Groups: \033[34mNone\033[0m"
		else
			echo -e "\033[1m Secondary Groups:\033[33m`cat $TGRP1`\033[0m"
		fi
		echo -e "\033[1m------------------------------------------------------------------------------------------\033[0m"
	NNT=1
	while [ $NNT -eq 1 ]
	do
		echo -e "\033[34mWould you like to use another Login Name(Yes or No):\033[0m \c "
		read CNF
		YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
		NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
		if [ $YES -eq 1 ]
		then
			CNT=1
			NNT=0
		elif [ $NO -eq 1 ]
		then
			NNT=0
			mainmenu
		else
			banner
			tput bold
			echo -e "\033[31m\t\t\t\tEnter Yes or No only\033[0m"
			NNT=1
		fi
	done
		
	else
		echo -e "\033[33mYou Can Create New User with Login Name $logname.\033[0m"
		CNT=0
	fi
done

echo -e "\033[1mGroup Name:\033[0m \c "
read grpname
CNT=1
while [ $CNT -eq 1 ]
do
	echo -e "\033[1mLike to Set Home Directory?\n[Default path will be(/home/$logname) if not set] Please Enter Yes or No:\033[0m \c "
	read CNF
	YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
	NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
	if [ $YES -eq 1 ]
	then
		echo -e "\033[1mEnter Home Directory Path:\033[0m \c "
		read hpath
		CNT=0
	elif [ $NO -eq 1 ]
	then
		hpath="/home/$logname"
		CNT=0
	else
		echo -e "\033[1mEnter Yes or No only\033[0m"
		CNT=1
	fi
done
}
########################################################################################################################
mainmenu ()
{
banner
echo -e "\033[1m1. Create User"
echo "2. Check User Details"
echo "3. Delete User"
echo "4. Modify User Properties"
echo -e "5. Exit Utility\033[0m"
echo -e "\033[35m\nSelect Action: \033[0m\c "
read SLCT
case "${SLCT}" in
	1)
		createuser
	;;
	2)
CNT=1
while [ $CNT -eq 1 ]
do
echo -e "\033[1mUsername to check:\033[0m \c "
read logname

TUSR=/tmp/.user
TGRP=/tmp/.group
TGRP1=/tmp/.group1
grep -w "^$logname" /etc/passwd > $TUSR
        if [ $? = 0 ]
        then
        	banner
                echo -e "\033[34m------------------------------------------------------------------------------------------\033[0m"
                echo -e "\033[33m                       User $logname details given below.\033[0m"
                echo -e "\033[34m------------------------------------------------------------------------------------------\033[0m"
                echo -e "\033[1mFirst Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f1`\033[0m"
                echo -e "\033[1mLast  Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f2`\033[0m"
                echo -e "\033[1mDepartment: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f4`\033[0m"
                id -Gn $logname > $TGRP
                GRP=`id -gn $logname`
                sed s/"$GRP"// $TGRP > $TGRP1
                echo -e "\033[1mLogin Name: \033[33m`cut -d: -f1 $TUSR`\033[0m \033[1mUserID: \033[33m`cut -d: -f3 $TUSR`\033[0m"
                echo -e "\033[1mPrimary Group: \033[33m`id -gn $logname`\033[0m\c "
                TST=`wc -w $TGRP1 | cut -d" " -f1`
                if [ $TST -eq 0 ]
                then
                        echo -e "\033[1m Secondary Groups: \033[34mNone\033[0m"
                else
                        echo -e "\033[1m Secondary Groups:\033[33m`cat $TGRP1`\033[0m"
                fi
                echo -e "\033[1m------------------------------------------------------------------------------------------\033[0m"
        	NNT=1
        	while [ $NNT -eq 1 ]
        	do
                	echo -e "\033[34mWould you like to check another user details(Yes or No):\033[0m \c "
                	read CNF
                	YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
                	NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
                	if [ $YES -eq 1 ]
                		then
                        		CNT=1
                        		NNT=0
                	elif [ $NO -eq 1 ]
                		then
                        		NNT=0
                        		mainmenu
                	else
                        		banner
                       		 	tput bold
                        		echo -e "\033[31m\t\t\t\tEnter Yes or No only\033[0m"
                        		NNT=1
                	fi
        	done

        	else
                	echo -e "\033[31m------------------------------------------------------------------------------------------\033[0m"
          		echo -e "\033[31m             Error(User Not Found): User $logname is not on the System.\033[0m"
                	echo -e "\033[31m------------------------------------------------------------------------------------------\033[0m"

        		NNT=1
        		while [ $NNT -eq 1 ]
        		do
                		echo -e "\033[34mWould you like to check another user details(Yes or No):\033[0m \c "
                		read CNF
                		YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
                		NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
                		if [ $YES -eq 1 ]
                			then
                        			CNT=1
                        			NNT=0
              	  		elif [ $NO -eq 1 ]
                			then
                        			NNT=0
                        			mainmenu
                		else
                        			banner
                        			tput bold
                        			echo -e "\033[31m\t\t\t\tEnter Yes or No only\033[0m"
                    				NNT=1
                		fi
        	done
        fi
done


	;;
	3)
		echo "Delete User"
CNT=1
while [ $CNT -eq 1 ]
do
echo -e "\033[1mUsername to Delete:\033[0m \c "
read logname

TUSR=/tmp/.user
TGRP=/tmp/.group
TGRP1=/tmp/.group1
grep -w "^$logname" /etc/passwd > $TUSR
        if [ $? = 0 ]
        then
        	banner
                echo -e "\033[34m------------------------------------------------------------------------------------------\033[0m"
                echo -e "\033[33m                       User $logname details given below.\033[0m"
                echo -e "\033[34m------------------------------------------------------------------------------------------\033[0m"
                echo -e "\033[1mFirst Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f1`\033[0m"
                echo -e "\033[1mLast  Name: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f2`\033[0m"
                echo -e "\033[1mDepartment: \033[33m`cut -d: -f5 $TUSR | cut -d" " -f4`\033[0m"
                id -Gn $logname > $TGRP
                GRP=`id -gn $logname`
                sed s/"$GRP"// $TGRP > $TGRP1
                echo -e "\033[1mLogin Name: \033[33m`cut -d: -f1 $TUSR`\033[0m \033[1mUserID: \033[33m`cut -d: -f3 $TUSR`\033[0m"
                echo -e "\033[1mPrimary Group: \033[33m`id -gn $logname`\033[0m\c "
                TST=`wc -w $TGRP1 | cut -d" " -f1`
                if [ $TST -eq 0 ]
                then
                        echo -e "\033[1m Secondary Groups: \033[34mNone\033[0m"
                else
                        echo -e "\033[1m Secondary Groups:\033[33m`cat $TGRP1`\033[0m"
                fi
                echo -e "\033[1m------------------------------------------------------------------------------------------\033[0m"
        	NNT=1
        	while [ $NNT -eq 1 ]
        	do
                	echo -e "\033[34mWould you like to Delete another user(Yes or No):\033[0m \c "
                	read CNF
                	YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
                	NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
                	if [ $YES -eq 1 ]
                		then
                        		CNT=1
                        		NNT=0
                	elif [ $NO -eq 1 ]
                		then
                        		NNT=0
                        		mainmenu
                	else
                        		banner
                       		 	tput bold
                        		echo -e "\033[31m\t\t\t\tEnter Yes or No only\033[0m"
                        		NNT=1
                	fi
        	done

        	else
                	echo -e "\033[31m------------------------------------------------------------------------------------------\033[0m"
          		echo -e "\033[31m             Error(User Not Found): User $logname is not on the System.\033[0m"
                	echo -e "\033[31m------------------------------------------------------------------------------------------\033[0m"

        		NNT=1
        		while [ $NNT -eq 1 ]
        		do
                		echo -e "\033[34mWould you like to Delete another user details(Yes or No):\033[0m \c "
                		read CNF
                		YES=$(echo $CNF | grep -i yes | wc -w | awk '{print($1)}')
                		NO=$(echo $CNF | grep -i no | wc -w | awk '{print($1)}')
                		if [ $YES -eq 1 ]
                			then
                        			CNT=1
                        			NNT=0
              	  		elif [ $NO -eq 1 ]
                			then
                        			NNT=0
                        			mainmenu
                		else
                        			banner
                        			tput bold
                        			echo -e "\033[31m\t\t\t\tEnter Yes or No only\033[0m"
                    				NNT=1
                		fi
        	done
        fi
done

	;;
	4)
		echo "Modify User"
	;;
	5)
		exit 1
	;;
	*)
		echo "Wrong Input"
		mainmenu
	;;
esac
}
mainmenu
