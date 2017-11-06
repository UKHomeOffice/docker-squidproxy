#!/bin/sh -e

# Start incron listener to detect changes to the squid config file
incrond

# Run the Squid Proxy service
/usr/sbin/squid -N
