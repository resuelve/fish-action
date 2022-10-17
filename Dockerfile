FROM alpine:3.16

RUN apk --no-cache add curl ca-certificates bash jq git

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
