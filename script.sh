#!/bin/bash
TEMPLATE_FOLDER_PATH="templates"
TEMPLATE_MERGE_PATH="./$TEMPLATE_FOLDER_PATH/merge/merge-template.json"
PARAMETERS_MERGE_PATH="./$TEMPLATE_FOLDER_PATH/merge/merge-parameters.json"
WEBHOOK_URL_MERGE_REQUEST="https://hooks.slack.com/services/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"

function readTemplate() {
	local templatePath=$1
	echo "cat $templatePath"
}

function replaceString() {
	local str=$1
	local toRemove=$2
	local toReplace=$3

	# echo "s/[$toRemove]+/$toReplace/g"

	# echo "$str" | sed -r "s/[$toRemove]+/$toReplace/g"

	echo "toReplace: $toReplace toRemove: $toRemove"

	local result
	result=$(echo "$str" | jq ". |= (sub(\"$toRemove\";\"$toReplace\")")
	echo "$result"
}

function getKeyAndValueFromJson() {
	local filePathJson=$1
	local keyValue
	keyValue=$(<"cat$filePathJson" jq -r 'to_entries[] | "\(.key), \(.value)"')
	echo "$keyValue"
}

function getFileJsonFromPath() {
	local filePath=$1
	local json;
	json=$(jq '.[]' "$filePath")
	echo "$json" 
}

function applyTemplateParams() {
	local template
	local params
	
	template=$(getFileJsonFromPath "$1")
	params=$(getFileJsonFromPath "$2")

	for i in $params; do
		# template=$(replaceString "${template}" "$i" "$$i")
		replaceString "${template}" "$i" "\${$i}"
	done
	# echo "$template"
}

function postMessage() {
	local content=$1
	curl -X POST \ --data-urlencode "payload=$($content)" \ "${WEBHOOK_URL_MERGE_REQUEST}"
}

function sendNotificationMerge() {
	local message
	message=$(applyTemplateParams "$TEMPLATE_MERGE_PATH" "$PARAMETERS_MERGE_PATH")
	# postMessage "$message"
}

function sendNotification() {
	local notificationType=$1
	case $notificationType in
		"merge") sendNotificationMerge;;
		*)
			echo -n "Unknown the notification type. The valid options are (merge)."
			;;
	esac
} 

applyTemplateParams "$TEMPLATE_MERGE_PATH" "$PARAMETERS_MERGE_PATH"

# sendNotificationMerge
