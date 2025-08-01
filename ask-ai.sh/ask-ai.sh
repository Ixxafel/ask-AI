#! /usr/bin/env bash

endpoint='localhost:11434'

if [ $OLLAMA_HOST ]; then
  endpoint=$OLLAMA_HOST
fi

model=$(curl -s http://$endpoint/api/tags \
  | jq -r '.models.[0].name // ""' \
)

if [ -z $model ]; then
  >&2 echo No model found. Please ensure that ollama is enabled and at least \
  one model is installed.
  exit 1
fi

cachedir=~/.cache/askai/
memoryfile=memory.json

mkdir -p $cachedir
touch $cachedir/$memoryfile

prompt=$(printf "%s " $@)

message="{
  \"role\": \"user\",
  \"content\": \"$prompt\"
}"

messages="[
  $(cat $cachedir/$memoryfile)
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

response=$( \
  curl -s http://$endpoint/api/chat -d "$data" \
    | jq '.message // ""' \
)

if [ -z $response ]; then
  >&2 echo Bad response from remote.
  exit 2
fi

printf "%s " $response | jq -r '.content' | bat -pp -l md;

printf "%s " $message >> $cachedir/$memoryfile
printf ",\n" >> $cachedir/$memoryfile
printf "%s " $response >> $cachedir/$memoryfile
printf ",\n" >> $cachedir/$memoryfile
