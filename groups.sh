members(){
   g_line=`getent group "$1"`
   [ -n "$g_line" ] || { echo "No such group $1." >&2 ; return 1 ; }
   getent passwd | awk -F":" '$4 == "'`echo "$g_line" | cut -d: -f3`'" { printf("%s ",$1) }'
   echo "$g_line" | cut -d: -f4 | tr , ' '
}
read -p "Group Name: " GNAME
members $GNAME
