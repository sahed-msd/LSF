#!/bin/bash
# Simple Linux System Info тЖТ Send to Telegram

# ЁЯФз рждрзЛржорж╛рж░ Telegram Bot Token ржЖрж░ Chat ID ржмрж╕рж╛рждрзЗ рж╣ржмрзЗ
BOT_TOKEN="7888336988:AAFzsewYXVT0Grxx7fQwKydxcKNMlUkLXqk"
CHAT_ID="5634946920"

# рж╕рж┐рж╕рзНржЯрзЗржо ржЗржиржлрзЛ рж╕ржВржЧрзНрж░рж╣
INFO=$(echo -e "
ЁЯЦе Linux System Report

ЁЯСд User: $(whoami)
ЁЯТ╗ Hostname: $(hostname)
ЁЯЦе OS: $(uname -o) $(uname -r)
тП▒ Uptime: $(uptime -p)
ЁЯУВ Current Dir: $(pwd)

ЁЯТ╛ Disk Usage:
$(df -h / | tail -n 1)

ЁЯУж Memory Usage:
$(free -h | grep Mem)

ЁЯМР IP Address: $(hostname -I | awk '{print $1}')
")

# Telegram ржП ржкрж╛ржарж╛ржирзЛ
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
     -d chat_id="$CHAT_ID" \
     -d text="$INFO"
