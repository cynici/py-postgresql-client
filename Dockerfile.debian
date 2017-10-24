#Broken gdal
#FROM python:2
FROM geodata/gdal
LABEL maintainer "Cheewai Lai <clai@csir.co.za>"

ARG SUEXEC_VER=0.2
ARG SPATIALINDEX_VER=1.8.5
ARG DOCKERIZE_VERSION=v0.5.0

USER root
RUN apt-get update \
 && apt-get -y install curl postgresql-client python-yaml python-psycopg2 rsync \
 && apt-get -y install python-pip python-pika \
 && curl -k -fsSL -o /tmp/suexec.tgz "https://github.com/ncopa/su-exec/archive/v${SUEXEC_VER}.tar.gz" \
 && cd /tmp \
 && tar xvf suexec.tgz \
 && cd "/tmp/su-exec-${SUEXEC_VER}" \
 && make \
 && cp -af su-exec /usr/bin/ \
 && curl -k -fsSL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz | tar xfz - -C /usr/bin \
 && pip install --upgrade pip \
 && pip install --upgrade setuptools \
 && pip install dateutils \
 && pip install flask \
 && pip install gevent \
 && pip install gserver \
 && pip install psycogreen \
 && pip install rethinkdb \
 && pip install shapely \
 && pip install blinker raven --upgrade \
 && curl -o /tmp/spatialindex.tgz http://download.osgeo.org/libspatialindex/spatialindex-src-${SPATIALINDEX_VER}.tar.gz \
 && tar -C /tmp -zxf /tmp/spatialindex.tgz \
 && cd /tmp/spatialindex-src-${SPATIALINDEX_VER} \
 && ./configure \
 && make \
 && make install \
 && ldconfig \
 && pip install --upgrade rtree \
 && apt-get -y remove --purge python-dev build-essential \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh \
 && chown root.root /docker-entrypoint.sh
