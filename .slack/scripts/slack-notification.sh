#!/bin/bash

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-merge.sh

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-utils.sh

function sendNotification() {
	local -r notificationType=$(readArgFromCommandLine "TYPE" "$@")
	case $notificationType in
		"merge") sendNotificationMerge "$@";;
		*)
			echo -n "Unknown the notification type '$notificationType'. The valid options are (merge)."
			;;
	esac
} 
sendNotification "$@"