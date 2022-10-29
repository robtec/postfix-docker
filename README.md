# Postfix Docker
Postfix inside a Docker Container

## Setup

Add add/update `files/users.txt` to control the system users created in the container

Build the image
```
docker build -t postfix-image .
```

## Generate TLS Certificates using certbot
```
# update command with your domain

certbot certonly --standalone --preferred-challenges http -d ${MY_DOMAIN}

# follow prompts and note where the Certificate and Key is saved
# usually found in /etc/letsencrypt/live/${MY_DOMAIN}/
```

## Running
```
# docker

docker run -d -e "MY_DOMAIN=localhost" --name postfix-mail -it -p 25:25 postfix-image

# or, docker compose

docker compose up -d --build
```

## Testing
```
# send a mail to a user, natively on the container

echo "hello my dear localhost" | docker exec --interactive postfix-mail mail -s "Sad subject" mary -

# read marys mail

docker exec -it postfix-mail cat /var/spool/mail/mary
```

### Telnet
```
telnet <HOST> 25

# copy/edit/paste below into terminal

MAIL FROM: <john@coolemails.com>

RCPT TO: <mary@localhost>

data
Subject: My Telnet Test Email

Hello,

This is an email sent by using the telnet command.

Your friend,
Me

.

```

## Docs

- Postfix Configs - http://www.postfix.org/BASIC_CONFIGURATION_README.html
