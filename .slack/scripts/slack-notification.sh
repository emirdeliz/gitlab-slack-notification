#!/bin/bash

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-merge.sh

function sendNotification() {
	local -r notificationType=$1
	case $notificationType in
		"merge") sendNotificationMerge;;
		*)
			echo -n "Unknown the notification type. The valid options are (merge)."
			;;
	esac
} 

sendNotification "$1"

# clear && bash .slack/scripts/slack-notification.sh merge