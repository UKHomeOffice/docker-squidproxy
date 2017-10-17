#!/bin/sh -e

# Configure incron to listen on modifications to Squid Proxy config and reconfigure service
echo "/etc/squid/squid.conf IN_MODIFY /usr/sbin/squid -k reconfigure" > /etc/incron.d/squid.conf

# Start listener for Squid config file
incrond

# Grant squid user access to stdout to write logs
chown squid.squid /dev/stdout

# Run the Squid Proxy service
/usr/sbin/squid -N
