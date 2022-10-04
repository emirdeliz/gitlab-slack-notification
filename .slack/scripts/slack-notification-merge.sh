#!/bin/bash

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-props.sh

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-utils.sh

function sendNotificationMerge() {
	local -r message=$(prepareMessage "$TEMPLATE_MERGE_PATH" "$@")
	postMessageToSlack "$message" "$@"
}
