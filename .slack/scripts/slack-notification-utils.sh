#!/bin/bash

# shellcheck source=/dev/null
. "$(dirname "$0")"/slack-notification-props.sh

function prepareSlackMessage() {
	local -r content=$1
	echo "{\"blocks\": $content}"
}

function postMessage() {
	local -r message=$1
	local -r target=$2
	curl -X POST -H 'Content-type: application/json' --data "$message" "$target"
}

function postMessageToSlack() {
	local -r content=$1
	local -r message=$(prepareSlackMessage "$content" "$@")
	local -r slackUrlRequest=$(readArgFromCommandLine "$SLACK_WEBHOOK_URL_REQUEST_KEY" "$@")
	local -r slackUrl="$SLACK_WEBHOOK_URL_REQUEST_BASE/$slackUrlRequest"
	postMessage "$message" "$slackUrl"
}

function getFileJsonFromPath() {
	local -r filePath=$1
	local -r json=$(< "$filePath")
	echo "$json"
}

function replaceString() {
	local -r str=$1
	local -r toRemove=$2
	local -r toReplace=$3
	local -r result="${str//\$$toRemove/$toReplace}"
	echo "$result"
}

function prepareMessage() {
	local -r templatePath=$1
	local template
	template=$(getFileJsonFromPath "$templatePath")

	for arg in "$@"
	do
		# shellcheck disable=SC2207
		local argMetadata=($(getArgKeyAndValue "$arg" "$@"))
		local argKey=${argMetadata[0]}
		local argValue=${argMetadata[1]}
		template=$(replaceString "$template" "$argKey" "$argValue")
	done
	echo "$template"
}

function getArgKeyAndValue() {
	local -r arg="$1"
	local -r argKey=$(echo "$arg" | cut -f1 -d=)
	local -r argValue=$(readArgFromCommandLine "$argKey" "$@")
	local result=("$argKey" "$argValue")
	echo "${result[@]}"
}

function readArgFromCommandLine() {
	local argValueResult;
	for i in "$@" ; 
	do
		local key=${i%=*}
		local val=${i#*=}
		[ "$1" = "$key" ] && argValueResult="$val"
	done
	echo "$argValueResult"
}