while read x name rest; do
	content=`echo $rest | sed 's/"\(.*\)".*/\1/'`;
	echo "$content" >> text/$name.txt
done < cmu_us_slt_arctic/etc/txt.done.data
