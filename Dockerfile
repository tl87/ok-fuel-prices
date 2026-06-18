FROM ubuntu:latest

RUN apt-get update && apt-get install -y msmtp ca-certificates bash curl jq cron && apt-get clean

ENV TZ=Europe/Copenhagen
RUN apt-get update && \
    apt-get install -y --no-install-recommends tzdata && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY OK_Benzin_Priser.sh /app/OK_Benzin_Priser.sh
COPY send_email.sh /app/send_email.sh
COPY entrypoint.sh /app/entrypoint.sh
COPY msmtprc /etc/msmtprc
COPY crontab.txt /app/crontab.txt

RUN touch /var/log/cron.log /var/log/msmtp.log

RUN chmod 600 /etc/msmtprc
RUN chmod +x /app/*.sh

ENTRYPOINT ["/app/entrypoint.sh"]
