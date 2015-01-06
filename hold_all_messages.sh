MAILQ=$(which mailq)

cnt=0
while read id
do
  postsuper -h $id
  cnt=$(( $cnt + 1 ))
done <<<"$( $MAILQ | grep -E '^[A-Z0-9]{10}[^\!]' | awk '{ print $1 }' | sed 's/[\*]//' )"

echo "held ${cnt} new messages"
