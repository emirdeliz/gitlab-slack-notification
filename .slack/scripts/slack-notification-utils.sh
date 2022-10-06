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
	local -r message=$(prepareSlackMessage "$content")
	local -r slackUrlRequest=$SLACK_WEBHOOK_URL_REQUEST
	local -r slackUrl="$SLACK_WEBHOOK_URL_REQUEST_BASE/$slackUrlRequest"
	postMessage "$message" "$slackUrl"
	# echo "$message" >&2
}

function getFileJsonFromPath() {
	local -r filePath=$1
	local -r json=$(< "$filePath")
	echo "$json"
}

function replaceString() {
	local -r str="$1"
	local -r toReplaced="$2"
	local -r toAdd="$3"
	local -r result="${str//$toReplaced/$toAdd}"
	echo "$result"
}

function prepareMessage() {
	local -r templatePath=$1
	local template
	template=$(getFileJsonFromPath "$templatePath")

	local envArgs
	envArgs="$(env)"
	envArgs=("${envArgs//$' '/zzzyzzz}")S

	for arg in $envArgs
	do
		# shellcheck disable=SC2207
		local argMetadata=($(getKeyAndValueFromQueryParam "$arg" "$(env)"))
		local argKey=${argMetadata[0]}
		local argValue
		argValue=$(replaceString "${argMetadata[1]}" "zzzyzzz" " ")
		template=$(replaceString "$template" "\${$argKey}" "$argValue")
	done
	echo "$template"
}

function getKeyAndValueFromQueryParam() {
	local -r param="$1"
	local -r paramKey=$(echo "$param" | cut -f1 -d=)
	local -r paramValue=$(readArgFromCommandLine "$paramKey" "$@")
	local result=("$paramKey" "$paramValue")
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