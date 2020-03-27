#!/bin/bash

if [[ "$1" == '' ]]; then
	echo "Path to wallpaper folder expected:"
	echo "./wpc.sh path/to/wallpapers"
	exit
fi

# Set directory to first arguement
dir=$1


# changed=0

# Loop
while (true)
do
	# Get current hour in 24h format
	currentHour=$(date +"%-H")

	# Reversed loop on all items in dir
	for t in $(ls -r $dir)
	do
		# Set base filename
		basefile=$(basename $t .png)
		# Check if current hour is higher than base filename
		if (( "$currentHour" >= "10#$basefile" )) ; then
			# Check if basefile image already is set
			if [[ "$currentImg" == "$basefile" ]] ; then
				changed=1
			else
				changed=0
				currentImg=$basefile
			fi
			# Change wallpaper if not set
			if [[ "$changed" == 0 ]] ; then
				changed=1
				echo "changing to $basefile.png"
				wal -a 85 -i $dir/$basefile.png
				break
			else
				break
			fi
		fi
	done



	# Sleep before repeating loop
	sleep 60
done
