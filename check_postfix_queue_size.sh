#!/bin/bash

MAILQ=$(which mailq)

$MAILQ 2>/dev/null | grep -Ec '^[A-Z0-9]{10}'
