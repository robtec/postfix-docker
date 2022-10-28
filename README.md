# Postfix Docker
Postfix inside a Docker Container

## Setup

Build the image
```
docker build -t postfix-image .
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
# send a mail to root user, natively on the container

echo "hello my dear localhost" | docker exec --interactive postfix-mail mail -s "Sad subject" root -

# read root user mailbox

docker exec -it postfix-mail cat /var/spool/mail/root
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
