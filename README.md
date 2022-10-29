# Postfix Docker
Postfix inside a Docker Container

## Setup

Add/update `files/users.txt` to control the system users created in the container

Build the image
```
docker build -t postfix-image .
```

## Generate TLS Certificate using certbot
```
# install certbot on your host machine, ubuntu for example

https://certbot.eff.org/instructions?ws=other&os=ubuntufocal

# update the following command with your domain then run

certbot certonly --standalone --preferred-challenges http -d ${MY_DOMAIN}

# follow prompts and note where the Certificate and Key is saved
# usually found in /etc/letsencrypt/live/${MY_DOMAIN}/

# docker will mount /etc/letsencrypt/ and use the cert/key
```

## Running
```
# docker compose (preferred)

docker compose up -d --build

# docker

docker run -d -e "MY_DOMAIN=localhost" -v /etc/letsencrypt/:/etc/letsencrypt --name postfix-mail -it -p 25:25 postfix-image
```

## Test

Using your own email client, send an email to `$USER@{$MY_DOMAIN}`

## Docs

Postfixs `main.cf` can be found under `files/main.cf`

- Postfix Configs - http://www.postfix.org/BASIC_CONFIGURATION_README.html
