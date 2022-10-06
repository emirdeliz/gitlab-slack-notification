#!/bin/bash

export NOTIFICATION_TYPE=merge
export GITLAB_USER_NAME="peter.vasquez"
export CI_MERGE_REQUEST_PROJECT_URL="https://repo.example.com/petera/sample-frontend-project"
export CI_COMMIT_REF_NAME="Ref-1217"
export CI_COMMIT_TIMESTAMP="4234234434334"
export CI_JOB_ID="32411115"
export CI_MERGE_REQUEST_IID="42311"
export SLACK_WEBHOOK_URL_REQUEST=THLSB1VM4/B0454PY9UEN/QGNcKFIvZCEr5yAzBGK037dx
export SLACK_CHANNEL_TARGET=test-integration
export CI_PROJECT_TITLE="Sample Frontend Project"
export CI_MERGE_REQUEST_TITLE="New Feature Xpto"

bash .slack/scripts/slack-notification.sh