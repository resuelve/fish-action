#!/bin/bash -l

# Github actions add a prefix INPUT_ to all the availables input values
webhook_url="${INPUT_GOOGLE_CHAT_URL}"

images_folder="https://raw.githubusercontent.com/resuelve/fish-action/master/images"

if [ "$GITHUB_EVENT_NAME" == 'pull_request' ]; then
    message="Por favor CR..."
    image_url="$images_folder/please.png"
else
    if [ "$failure" ]; then
        message="Uh ..."
        image_url="$images_folder/ups.png"
    else
        message="Listo ..."
        image_url="$images_folder/success.png"
    fi
    
fi

repo="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY"

short_commit="${GITHUB_SHA:0:8}"
commit_link="$repo/commit/$GITHUB_SHA"

job_link="$repo/actions/runs/$GITHUB_RUN_ID"

data=$(jq -n \
  --arg title "$GITHUB_REPOSITORY" \
  --arg commit_text "$short_commit by $GITHUB_ACTOR" \
  --arg commit_link "$commit_link" \
  --arg job_link "$job_link" \
  --arg message "$message" \
  --arg image_url "$image_url" \
'{
  "cards": [
    {
      "header": {
        "title": $title
      },
      "sections": [
        {
          "widgets": [
            {
              "keyValue": {
                "topLabel": "Commit",
                "content": $commit_text,
                "onClick": {
                  "openLink": {
                    "url": $commit_link
                  }
                }
              }
            },
            {
              "keyValue": {
                "topLabel": "Job",
                "onClick": {
                  "openLink": {
                    "url": $job_link
                  }
                }
              }
            }
          ]
        },
        {
          "header": $message,
          "widgets": [
            {
              "image": {
                "imageUrl": $image_url
              }
            }
          ]
        }
      ]
    }
  ]
}')

curl -H "Content-Type: aplication/json" -X POST -d "$data" "$webhook_url"
