# Postfix Docker
Postfix inside a Docker Container

## Setup

Build the image
```
docker build -t postfix-image .
```

## Running
```
docker run -it -p 25:25 postfix-image
```