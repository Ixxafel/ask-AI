#! /usr/bin/env bash

ENDPOINT='localhost:11434'

if [ $OLLAMA_HOST ] ; then
  ENDPOINT=$OLLAMA_HOST
fi

MODEL=$(curl -s https://$ENDPOINT/api/tags \
  | jq '.models.[0]' \
)

if [ -z $MODEL ] ; then
  echo No model found. Please ensure that ollama is enabled and at least one \
  model is installed.
fi

PROMPT=$(printf "%s " $@)

MESSAGE="[
  \"role\": \"user\",
  \"content\": \"$PROMPT\"
]"

DATA="
  {
    \"model\": \"$MODEL\",
    \"prompt\": $MESSAGE,
    \"stream\": false,
    \"keep_alive\": \"15m\"
  }
"

curl -s http://localhost:11434/api/generate -d "$DATA" \
  | jq -r '.response' \
  | bat -pp -l md
