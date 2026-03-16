#!/usr/bin/env bash
set -e

OUTPUT=$(/app/OK_Benzin_Priser.sh)

echo "$OUTPUT" | msmtp -a gmail EMAIL-GOES-HERE
