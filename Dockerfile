FROM alpine:edge

# Expose port to listen on
EXPOSE 3128/tcp

# Update and add missing packages
RUN apk update && apk add --no-cache squid incron

# Setup incron to listen on changes to squid config file and reload service
RUN echo "lockfile_dir = /home/proxy" >> /etc/incron.conf
RUN echo "/etc/squid/squid.conf IN_MODIFY /usr/sbin/squid -k reconfigure" > /etc/incron.d/squid.conf

# Copy basic squid config and entrypoint script
COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /sbin/entrypoint.sh

# Make entrypoint script executable
RUN chmod 755 /sbin/entrypoint.sh

# Allow squid to write to stdout
RUN chown squid.squid /dev/stdout

# Add proxy non-privileged user to use
RUN adduser -G squid -S -u 1000 proxy

# Switch to proxy user
USER 1000

# Start the service
CMD ["/sbin/entrypoint.sh"]
