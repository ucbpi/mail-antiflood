#!/bin/sh

SOURCE="${BASH_SOURCE[0]}"
DIR=$(cd $( dirname $SOURCE ) && pwd )

THRESHOLD=0
NOTIFY=arusso@berkeley.edu
MESSAGE="Active messages in the mail queue exceeded threshold of ${THRESHOLD}.\n
These messages have been held to prevent rate-limiting of email accounts, and to be a good mail user.\n
To review these messages, hop on to $HOSTNAME and review the mailq, thawing or deleting messages as necessary."

ACTIVE_COUNT=$(sh ${DIR}/check_postfix_queue_size.sh | sed 's/:/ /g' | awk '{print $4 }')
if [ $ACTIVE_COUNT -ge $THRESHOLD ]; then
  # hold all messages
  # 
  ${DIR}/hold_active_messages.sh
  printf "$MESSAGE" | mail -s "Nagios Anti-Spam System Activated" $NOTIFY
else
  echo "message count below threshold ($ACTIVE_COUNT < $THRESHOLD)"
fi
