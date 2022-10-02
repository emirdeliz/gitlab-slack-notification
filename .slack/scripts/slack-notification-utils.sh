#!/bin/bash

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-props.sh

function postMessage() {
	local -r message=$1
	local -r target=$2
	curl -X POST -H 'Content-type: application/json' --data "$message" "$target"
}

function prepareSlackMessage() {
	echo "{\"channel\": \"$SLACK_CHANNEL_TARGET\", \"blocks\": $content}"
}

function postMessageToSlack() {
	local -r content=$1
	local -r message=$(prepareSlackMessage "$content")
	postMessage "$message" "$WEBHOOK_URL_MERGE_REQUEST"
}

function getFileJsonFromPath() {
	local -r filePath=$1
	local -r json=$(cat "$filePath")
	echo "$json" 
}

function replaceString() {
	local str=$1
	local toRemove=$2
	local toReplace=$3

	local result
	result="${str//\$$toRemove/$toReplace}"
	echo "$result"
}

function prepareMessage() {
	local templatePath
	templatePath=$1

	local template
	template=$(getFileJsonFromPath "$templatePath")

	for arg in "$@"
	do
		argKey=$(echo "$arg" | cut -f1 -d=)
		argKeyLength=${#argKey}
		argValue="${arg:$argKeyLength+1}"
		template=$(replaceString "$template" "$argKey" "$argValue")
	done
	echo "$template"
}