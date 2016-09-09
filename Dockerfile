FROM qnib/alpn-rsyslog

ARG MINIO_REL=2016-08-21T02-44-47Z
ENV GOPATH=/usr/local/

RUN apk add --update go git \
 && wget -qO- https://github.com/minio/minio/archive/RELEASE.${MINIO_REL}.tar.gz |tar xfz - -C /opt/ \
 && mkdir -p ${GOPATH}/src/github.com/minio/ \
 && mv /opt/minio-RELEASE.${MINIO_REL} ${GOPATH}/src/github.com/minio/minio \
 && wget -qO /usr/local/bin/go-wrapper https://raw.githubusercontent.com/docker-library/golang/master/1.6/go-wrapper \
 && chmod +x /usr/local/bin/go-wrapper \
 && cd ${GOPATH}/src/github.com/minio/minio/ \
 && go-wrapper download \
 && go-wrapper install \
 && apk del git go \
 && rm -rf /var/cache/apk/* /usr/local/src/github.com /usr/local/bin/go-wrapper
ADD etc/supervisord.d/minio.ini /etc/supervisord.d/
ADD etc/consul.d/minio.json /etc/consul.d/
ADD opt/qnib/minio/bin/start.sh /opt/qnib/minio/bin/
VOLUME /export/
