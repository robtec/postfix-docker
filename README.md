# Postfix Docker
Postfix inside a Docker Container

## Setup

Build the image
```
docker build -t postfix-image .
```

## Running
```
docker run -d --name postfix-mail -it -p 25:25 postfix-image
```

## Testing
```
# send a mail to root user, natively on the container

echo "hello my dear localhost" | docker exec --interactive postfix-mail mail -s "Sad subject" root -

# read root user mailbox
docker exec -it postfix-mail cat /var/spool/mail/root
```

## Docs

- Postfix Configs - http://www.postfix.org/BASIC_CONFIGURATION_README.html