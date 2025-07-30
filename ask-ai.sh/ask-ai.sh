#! /usr/bin/env bash

MODEL=$(ollama list | awk 'NR > 1 {print $1}')

PROMPT=$(printf "%s " $@)

DATA="
  {
    \"model\": \"$MODEL\",
    \"prompt\": \"$PROMPT\",
    \"stream\": false
  }
"
# printf "%s " $DATA

curl -s http://localhost:11434/api/generate -d "$DATA" \
  | jq -r '.response' \
  | bat -pp -l md
