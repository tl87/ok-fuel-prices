# Info

Simple application, that will use the OK API to get fuel prices.

---

## How to use?

First we need to modify files, then build the container and run it.

In the file `send_email.sh`, please modify the e-mail account field (EMAIL-GOES-HERE). This is the e-mail account that will receive the prices.

In the file `msmtprc`, please modify the `from`, `user` and `password`. We are using Gmail and the sender platform.

The file `crontab.txt` is for setting how often you want the application to run and send a notification. Default is Monday to Friday, at 07:00 and 15:00. You can change it to fit your needs.

Modify the file `OK_Benzin_Priser.sh` and find the line where `CITIES` are, these are the fuel stations where prices are collected from. Modify to fit your need. OK website can help you find cities, where fuel stations are located.

1. Build the container with the command below:

Modify depending on container runtime (*podman* or *docker*):

```bash
docker build -t ok-fuel-email .
```

2. Start/run the container:

```bash
docker run -d --rm --name ok-fuel-email
```

3. Done. The container will keep runing, until you stop it or something fails on the host running the container.

---

## Check logs

If you want to check log files, then you can use the command below to see e-mail and script runtime log output:

```bash
docker logs -ft ok-fuel-email
```

---

## Clean up

When you are done or need to clean up, you can simple stop the container and remove container images.

---
