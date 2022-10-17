# Action to notify about events to Google Chat

Sends a message to Google chat channel with the result of the build, the result will be presented as a card.

## Inputs

| Input           | Required | Description                                                 |
|-----------------|----------|-------------------------------------------------------------|
| google_chat_url | yes      | Google webhook chat URL where the notification will be sent |

## Usage

```yaml
- name: Notify chat
  if: ${{ always() }}
  uses: resuelve/fish-action@v1
    with:
      google_chat_url: ${{ secrets.GOOGLE_CHAT_URL }}
```

Enjoy 🎉
