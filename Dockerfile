FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    ca-certificates postfix mailutils diceware gettext-base && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN adduser mailbucket --quiet --disabled-password \
    --shell /usr/sbin/nologin --gecos "Mail Bucket"

COPY entrypoint.sh .

COPY ./files/users.txt .

COPY ./files/main.cf /tmp/main.cf

ENTRYPOINT ["./entrypoint.sh"]
CMD ["postfix", "-v", "start-fg"]