#!/bin/bash
# Simple Linux System Info → Send to Telegram

# 🔧 তোমার Telegram Bot Token আর Chat ID বসাতে হবে
BOT_TOKEN="7888336988:AAFzsewYXVT0Grxx7fQwKydxcKNMlUkLXqk"
CHAT_ID="5634946920"

# সিস্টেম ইনফো সংগ্রহ
INFO=$(echo -e "
🖥 Linux System Report

👤 User: $(whoami)
💻 Hostname: $(hostname)
🖥 OS: $(uname -o) $(uname -r)
⏱ Uptime: $(uptime -p)
📂 Current Dir: $(pwd)

💾 Disk Usage:
$(df -h / | tail -n 1)

📦 Memory Usage:
$(free -h | grep Mem)

🌐 IP Address: $(hostname -I | awk '{print $1}')
")

# Telegram এ পাঠানো
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$INFO"
