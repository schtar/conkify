#!/bin/bash
#
# Bash-script to display the currently playing track in Spotify
# Author: Niklas Engvall
# Version 0.1
#
# This work is licensed under the <license>
#
# Example for usage with Conky:
# ${texeci 1 sh /path/to/conkify.sh} in .conkyrc
#
#


DEST='org.mpris.MediaPlayer2.spotify'
OBJECT_PATH='/'
CALL_CMD='org.freedesktop.MediaPlayer2.GetMetadata'

# Check if spotify is running
PIDSPOTIFY=$(pidof spotify)
if [[ $PIDSPOTIFY == '' ]]; then 
	echo 'Spotify is not running'
	exit 1
fi


INFO=$(dbus-send --print-reply --dest=$DEST $OBJECT_PATH ${CALL_CMD})	# Call to grab info of track
ARTIST=$(echo "$INFO" | egrep -A 2 'xesam:artist' | tail -n1 | cut -b 24- | cut -d '"' -f 1)	# Get artist
TITLE=$(echo "$INFO" | egrep -A 1 'xesam:title' | tail -n1 | cut -b 38- | cut -d '"' -f 1)	# Get title

echo "$ARTIST - $TITLE"



