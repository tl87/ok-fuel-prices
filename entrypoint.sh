#!/usr/bin/env bash
set -e

# Install crontab
crontab /app/crontab.txt

# Start cron
cron

# Stream logs to container output
tail -F /var/log/cron.log /var/log/msmtp.log
