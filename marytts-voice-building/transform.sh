while read x name rest; do
	content=`echo $rest | sed 's/"\(.*\)".*/\1/'`;
	echo "$content" >> text/$name.txt
done < txt.done.data
