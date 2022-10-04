#!/bin/bash
sh flut_poc_web/.slack/scripts/slack-notification.sh \
	TYPE=merge \
	SLACK_WEBHOOK_URL_REQUEST=<url> \
	SLACK_CHANNEL_TARGET=test-integration \
	GITLAB_USER_NAME=peter.vasquez \
	GITLAB_REPO_URL=https://repo.example.com/petera/cc-web \
	CI_PROJECT_TITLE=CC Web \
	CI_COMMIT_TIMESTAMP=4234234434334 \
	CI_JOB_ID=32411115 \
	CI_COMMIT_REF_NAME=Ref-12178 \
	CI_JOB_STATUS=done