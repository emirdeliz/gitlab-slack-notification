#!/bin/bash

declare scriptDir
scriptDir="$(dirname "$0")"

declare baseDir
baseDir=$(dirname "$scriptDir")

SCRIPT_BASE_DIR="$scriptDir"
TEMPLATE_FOLDER_PATH="$baseDir/templates"
TEMPLATE_MERGE_PATH="$TEMPLATE_FOLDER_PATH/merge-template.json"
SLACK_WEBHOOK_URL_REQUEST_BASE="https://hooks.slack.com/services"

export SCRIPT_BASE_DIR
export TEMPLATE_FOLDER_PATH
export TEMPLATE_MERGE_PATH
export SLACK_CHANNEL_TARGET_KEY
export SLACK_WEBHOOK_URL_REQUEST_BASE