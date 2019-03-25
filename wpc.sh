#!/bin/bash

#	CONFIG
# ---------------------------

# Set either nitrogen or feh to 1
# to select which dependency you
# want to use
nitrogen=1
feh=0

# At which hour wallpaper should change
tMorning=07
tDay=10
tAfternoon=15
tNight=19

# Dir to images you want to use
dir=~/Pictures/Mojave/

# Images in dir you want to use
iMorning=morning.png
iDay=day.png
iAfternoon=afternoon.png
iNight=night.png


# Monitor -- use monitor0 if default does work (Default: monitorLVDS1)
monitor=monitorLVDS1




#	END OF CONFIG
# ---------------------------



echo "---------------"

# Keep looping every 10 minutes
while (true)
do
	# Get current hour in 24h format
	curh=$(date +"%-H")

	# Prepare image to be set as wallpaper depending on time
	if (( "$curh" >= "$tMorning" && "$curh" < "$tDay" )) ; then
		if [[ "$img" == $iMorning ]] ; then
			changed=1
		else
			changed=0
			img=$iMorning
		fi
	elif (( "$curh" >= "$tDay" && "$curh" < "$tAfternoon" )) ; then
		if [[ "$img" == $iDay ]] ; then
			changed=1
		else
			changed=0
			img=$iDay
		fi
	elif (( "$curh" >= "$tAfternoon" && "$curh" < "$tNight" )) ; then
		if [[ "$img" == $iAfternoon ]] ; then
			changed=1
		else
			changed=0
			img=$iAfternoon
		fi
	elif (( "$curh" >= "$tNight" || "$curh" < "$tMorning" )) ; then
		if [[ "$img" == $iNight ]] ; then
			changed=1
		else
			changed=0
			img=$iNight
		fi
	fi


	# Concatenate the image name on the directory it is in
	imgPath="$dir$img"


	# Change wallpaper if it's not already set 
	if [[ "$changed" == 0 ]] ; then
		changed=0
		if [[ "$nitrogen" == 1 ]] ; then
			nitrogen --set-scaled $imgPath
		elif [[ "$feh" == 1 ]] ; then
			feh --bg-scaled $imgPath
		fi

		# Clear screen
		clear

		# Print info
		if [[ "$img" ==  "$iMorning" ]] ; then
			echo "Morning"
		elif [ "$img" =  "$iDay" ] ; then
			echo "Day"
		elif [ "$img" =  "$iAfternoon" ] ; then
			echo "Evening"
		elif [ "$img" =  "$iNight" ] ; then
			echo "Night"
		fi

	fi


	# Seconds to sleep before checking the time again -- default 600 (10 minutes)
	sleep 600

done
