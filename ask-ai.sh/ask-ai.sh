#! /usr/bin/env bash

endpoint='localhost:11434'

if [ $OLLAMA_HOST ]; then
  endpoint=$OLLAMA_HOST
fi

model=$(curl -s http://$endpoint/api/tags \
  | jq -r '.models.[0].name // ""' \
)

if [ -z $model ]; then
  echo No model found. Please ensure that ollama is enabled and at least one \
  model is installed.
  exit 0
fi

prompt=$(printf "%s " $@)

message="{
  \"role\": \"user\",
  \"content\": \"$prompt\"
}"

messages="[
  $message
]"

data="
  {
    \"model\": \"$model\",
    \"messages\": $messages,
    \"stream\": false,
    \"keep_alive\": \"15m\"
  }
"
printf "%s " $message | jq .

printf "\n"

response=$( \
  curl -s http://$endpoint/api/chat -d "$data" \
    | jq '.message' \
)

printf "%s " $response | jq .

printf "%s " $response | jq -r '.content' | bat -pp -l md
