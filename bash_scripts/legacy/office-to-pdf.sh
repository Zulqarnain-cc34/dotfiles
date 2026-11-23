#!/bin/bash
dir=$1

NUM_ARGS=1
if [[ "$#" != "$NUM_ARGS" ]]
then
        echo "Incorrect number of arguments. Retype the command $0 <dir>"
exit 2 
fi

#change directory(in case of failer exit code and echo failed 

cd "$dir" || exit

#for every folder in every directory in current directory
for folder in */
do
	#change directory to that folder
    cd "$folder" || (exit && echo "failed to convert in ${folder}")
       
	#convert files
    libreoffice --headless --convert-to pdf *.pptx *.docx *.doc *.ppt
  	#unoconv -f pdf *.pptx *.docx *.doc *.ppt
        
	#change directiory out of current one so the first for loop can proceed otherwise it will stay in this diectory.
	cd ..

done

#above solution is limited as it can only act in current directory and not recursively. To perform a action recursively use find command followed by xargs

exit 0
