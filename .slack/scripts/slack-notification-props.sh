#!/bin/bash

declare scriptDir
scriptDir="$(dirname "$0")"

declare baseDir
baseDir=$(dirname "$scriptDir")

WEBHOOK_URL_MERGE_REQUEST="<hook url>"
SLACK_CHANNEL_TARGET="test-integration"
SCRIPT_BASE_DIR="$scriptDir"
TEMPLATE_FOLDER_PATH="$baseDir/templates"
TEMPLATE_MERGE_PATH="$TEMPLATE_FOLDER_PATH/merge-template.json"
PARAMETERS_MERGE_PATH="$TEMPLATE_FOLDER_PATH/merge-parameters.json"

export WEBHOOK_URL_MERGE_REQUEST
export SLACK_CHANNEL_TARGET
export SCRIPT_BASE_DIR
export TEMPLATE_FOLDER_PATH
export TEMPLATE_MERGE_PATH
export PARAMETERS_MERGE_PATH