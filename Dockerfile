FROM alpine:3.6

RUN apk update && apk add --no-cache squid incron

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp

CMD ["entrypoint.sh"]
