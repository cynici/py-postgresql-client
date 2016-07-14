FROM alpine:edge
MAINTAINER Cheewai Lai <clai@csir.co.za>

ARG GOSU_VERSION=1.9
ARG SPATIALINDEX_VER=1.8.5

RUN echo '@testing http://nl.alpinelinux.org/alpine/edge/testing' >>/etc/apk/repositories \
 && apk --update add py-pip postgresql-client py-yaml py-psycopg2 \
 && apk --update add --virtual build-dependencies curl postgresql-dev python-dev build-base \
 && apk --update add py-pika@testing geos@testing geos-dev@testing py-gdal@testing boost-dev@testing \
 && curl -o /usr/local/bin/gosu -sSL "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64" \
 && chmod +x /usr/local/bin/gosu \
 && curl -o /usr/local/bin/ez_setup.py -sSL "https://bootstrap.pypa.io/ez_setup.py" \
 && python /usr/local/bin/ez_setup.py \
 && pip install --upgrade pip \
 && pip install --upgrade setuptools \
 && pip install flask \
 && pip install gevent \
 && pip install gserver \
 && pip install psycogreen \
 && pip install dateutils \
 && pip install rethinkdb \
 && pip install shapely \
 && curl -o /tmp/spatialindex.tgz http://download.osgeo.org/libspatialindex/spatialindex-src-${SPATIALINDEX_VER}.tar.gz \
 && tar -C /tmp -zxf /tmp/spatialindex.tgz \
 && cd /tmp/spatialindex-src-${SPATIALINDEX_VER} \
 && ./configure \
 && make \
 && make install \
 && pip install --upgrade rtree \
 && apk del geos-dev boost-dev \
 && apk del build-dependencies \
 && rm -rf /var/cache/apk/* /tmp/*
ADD docker-entrypoint.sh /docker-entrypoint.sh
