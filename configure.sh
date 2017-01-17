#!/bin/bash
# Script to create symbolic link to the correct build of the sdk 

# Test each build of bardecode to see which one returns 1
# Which one works depends on the system architecture and versions of libtiff
# and libjpeg installed on the system.
count=0
list=""
for dir in build/*
do
	t=`eval $dir/bin/bardecode 2> /dev/null | grep -i softek`
	if test -n "$t"
	then
		list="$list $dir"
		count=`expr $count + 1`
	fi
done

if test $count -eq 0
then
	# No build will work on this system
	echo "Sorry - no build of bardecoder will work on this os"
	echo "Please contact support@bardecode.com for further advice"
	exit
fi

if test $count -eq 1
then
	# Only one build will work on this system
	echo "Creating links to the following build of bardecoder..."
	cat $list/name
	rm arch
	ln -s $list arch
	rm -f lib/*
	for file in arch/lib/*
	do
		ln -s ../$file lib/`basename $file`
	done
	exit
fi

# Muliple builds will work on this system
echo "Please select the most appropriate version for your system...."

id=1
for dir in $list
do
	name=`cat $dir/name`
	echo $id: $name
	id=`expr $id + 1`
done

echo -n "> "
read response

id=1
for dir in $list
do
	if test $id = "$response"
	then
		echo "Creating links to the following build of bardecoder..."
		cat $dir/name
		rm arch
		ln -s $dir arch
		rm -f lib/*
		for file in arch/lib/*
		do
			ln -s ../$file lib/`basename $file`
		done
	fi
	id=`expr $id + 1`
done



