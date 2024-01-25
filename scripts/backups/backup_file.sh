echo "this tool is for backup home directory"
currentdir=$(pwd)
echo "the backup file will be in $currentdir"
tar -cf "$currentdir/my_backup_$(date +%d-%m-%Y_%H-%M-%S).tar" $HOME 2>/dev/null
echo "backup successes"
