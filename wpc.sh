#!/bin/bash

#	CONFIG
# ---------------------------


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
		feh --bg-scale $imgPath
		#feh --bg-scale $imgPath
		changed=0

		# Print info
		if [[ "$img" ==  "$iMorning" ]] ; then
			echo "[X] Morning"
			echo "[ ] Day"
			echo "[ ] Evening"
			echo "[ ] Night"
		elif [ "$img" =  "$iDay" ] ; then
			echo "[ ] Morning"
			echo "[X] Day"
			echo "[ ] Evening"
			echo "[ ] Night"
		elif [ "$img" =  "$iAfternoon" ] ; then
			echo "[ ] Morning"
			echo "[ ] Day"
			echo "[X] Evening"
			echo "[ ] Night"
		elif [ "$img" =  "$iNight" ] ; then
			echo "[ ] Morning"
			echo "[ ] Day"
			echo "[ ] Evening"
			echo "[X] Night"
		fi
		echo "---------------"

	fi


	# Seconds to sleep before checking the time again -- default 600 (10 minutes)
	sleep 600

done
