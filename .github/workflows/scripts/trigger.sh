#!/bin/bash
# Usage: ./trigger.sh <OWNER> <REPO> <WORKFLOW_FILE> <BRANCH> "<INPUTS_JSON>"

OWNER=$1
REPO=$2
WORKFLOW_FILE=$3
BRANCH=$4
INPUTS=$5

TOKEN=$GITHUB_TOKEN   # read from secret in GitHub Actions

if [ -z "$INPUTS" ]; then
  DATA="{\"ref\":\"$BRANCH\"}"
else
  DATA="{\"ref\":\"$BRANCH\", \"inputs\": $INPUTS}"
fi

curl -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  https://api.github.com/repos/$OWNER/$REPO/actions/workflows/$WORKFLOW_FILE/dispatches \
  -d "$DATA"
