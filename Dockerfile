FROM alpine:edge
MAINTAINER Cheewai Lai <clai@csir.co.za>

ARG GOSU_VERSION=1.9

RUN apk --update add py-pip postgresql-client py-yaml \
 && apk --update add --virtual build-dependencies curl postgresql-dev python-dev build-base \
 && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
 && chmod +x /usr/local/bin/gosu \
 && pip install --upgrade pip \
 && pip install psycopg2 \
 && pip install flask \
 && pip install gevent \
 && pip install gserver \
 && pip install psycogreen \
 && pip install dateutils \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/*
