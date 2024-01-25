echo "please inter the file's path "
read filepath
size=$(find $filepath -printf %s)
type=$(file -b $filepath)
permisson=$(namei -l $filepath)
echo "the size of the file is $size Bytes"
echo "the type of the file is $type "
echo "the permissons of the file is $permisson"
