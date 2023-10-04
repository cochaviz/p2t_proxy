#!/usr/bin/env bash

TMP_FILE_NAME=".latex_ocr.tmp.png"
APP_NAME="Latex OCR"

gnome-screenshot -a -f $TMP_FILE_NAME

if [ -f $TMP_FILE_NAME ]; then
	RESULT=$(p2t.sh $TMP_FILE_NAME)

	if [ $? -eq 0 ]; then
		echo "$RESULT" | xclip -selection clipboard
		notify-send "Finshed processing screenshot!" \
			"Results pasted to clipboard." \
			-a "$APP_NAME" \
			-u critical \
			-i "/usr/share/icons/Adwaita/32x32/actions/edit-copy-symbolic.symbolic.png"
	elif [ $? -eq 1 ]; then
		notify-send "Could not connect to the server" \
			"Please check your internet connection." \
			-a "$APP_NAME" \
			-u critical \
			-i "/usr/share/icons/Adwaita/32x32/status/computer-fail-symbolic.symbolic.png"
	else
		notify-send "Could not properly process the latex equation." \
			"Make sure you are taking a picture of a clear rendered latex math." \
			-a "$APP_NAME" \
			-u critical \
			-i "/usr/share/icons/Adwaita/32x32/status/computer-fail-symbolic.symbolic.png"
	fi

	rm $TMP_FILE_NAME 
else
	notify-send "Screenshot aborted (or somehow not found)" \
		-u normal \
		-i "/usr/share/icons/Adwaita/32x32/status/dialog-information-symbolic.symbolic.png"
fi

