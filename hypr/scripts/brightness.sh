#!/usr/bin/env bash

export PATH=/usr/bin:/usr/local/bin:$PATH

BRIGHTNESSCTL=/usr/bin/brightnessctl
BC=/usr/bin/bc
DUNSTIFY=/usr/bin/dunstify

notify_brightness() {
	MAX_BRIGHTNESS=$($BRIGHTNESSCTL max)
	CURRENT_BRIGHTNESS=$($BRIGHTNESSCTL get)

	BRIGHTNESS_PERCENT=$(
		$BC <<<"scale=1; $CURRENT_BRIGHTNESS / $MAX_BRIGHTNESS * 100"
	)

	$DUNSTIFY -t 3000 -a "  Brightness" \
		-h int:value:"$BRIGHTNESS_PERCENT" "%"
}

# Args check
if [[ "$#" != 1 || ! ("$1" == "inc" || "$1" == "dec") ]]; then
	exit 1
fi

# Adjust brightness
if [[ "$1" == "inc" ]]; then
	$BRIGHTNESSCTL set +10% >/dev/null
	notify_brightness
elif [[ "$1" == "dec" ]]; then
	$BRIGHTNESSCTL set 10%- >/dev/null
	notify_brightness
fi
