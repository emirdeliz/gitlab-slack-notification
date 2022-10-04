#!/bin/bash
sh flut_poc_web/.slack/scripts/slack-notification.sh \
	TYPE=merge \
	SLACK_WEBHOOK_URL_REQUEST=THLSB1VM4/B044X86RB38/8NOpn5ecojX2JjlSeBNC8P2h \
	SLACK_CHANNEL_TARGET=test-integration \
	GITLAB_USER_NAME=peter.vasquez \
	GITLAB_REPO_URL=https://repo.example.com/petera/cc-web \
	CI_PROJECT_TITLE=CC Web \
	CI_COMMIT_TIMESTAMP=4234234434334 \
	CI_JOB_ID=32411115 \
	CI_COMMIT_REF_NAME=Ref-12178 \
	CI_JOB_STATUS=done

# payload='{"blocks": [{"type":"section","text":{"type":"mrkdwn","text":"$CI_PROJECT_TITLE"}},{"type":"divider"},{"type":"section","fields":[{"type":"mrkdwn","text":"*Stage:*\\nBuild"},{"type":"mrkdwn","text":"*Pushed By:*\\n$GITLAB_USER_NAME *at*: $CI_COMMIT_TIMESTAMP"},{"type":"mrkdwn","text":"*Job URL:*\\n$GITLAB_REPO_URL/$CI_JOB_ID"},{"type":"mrkdwn","text":"*Commit URL:*\\n$GITLAB_REPO_URL $(git rev-parse HEAD)"},{"type":"mrkdwn","text":"*Commit Branch:*\\n$CI_COMMIT_REF_NAME"},{"type":"mrkdwn","text":"*Pipeline Status:*\\n$CI_JOB_STATUS"}]},{"type":"divider"}]}'
# curl -X POST -H 'Content-type: application/json' --data "$payload" https://hooks.slack.com/services/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
