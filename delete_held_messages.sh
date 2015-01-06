#!/bin/sh

MAILQ=$(which mailq)
AWK="$(which awk) --re-interval"

cnt=0
while read id
do
  [[ "$id" == "" ]] && continue
  postsuper -d $id &>/dev/null
  cnt=$(( $cnt + 1 ))
done <<< "$($MAILQ | $AWK '/^[A-Z0-9]{10}[!]/ { print $1 }' | sed 's/!//')"
echo "$cnt messages deleted!"
