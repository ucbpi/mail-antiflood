#!/bin/bash

MAILQ=$(which mailq)
AWK="$(which awk) --re-interval"

$MAILQ 2>/dev/null | $AWK 'BEGIN { total_count=0; held_count=0; } /^[A-Z0-9]{10}/ { total_count++ } /^[A-Z0-9]{10}[!]/ { held_count++ } END { print "total:"total_count,"active:"total_count-held_count,"held:"held_count }'
