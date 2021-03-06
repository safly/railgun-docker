#!/bin/sh

ip=$1

cat <<END
# Port to listen on
wan.port = 2408

# Static map of IPs for use in NAT environments
map.file = /etc/railgun/railgun-nat.conf
stderr.file = /var/log/railgun/panic.log
pid.file = /var/run/railgun/railgun.pid

# Log only errors by default
#
# 0 - log only errors
# 5 - full debug logging (not for production use)
log.level = $LOG_LEVEL

# Disable origin server SSL certificate validation by
# default. This is done to prevent potential errors for
# Railgun instances that don't have the needed origin
# server certificates installed
validate.cert = 0

# CA Bundles
# Railgun includes its own certificate authority bundle for
# common certificate providers. Comment ca.bundle out
# to use the default openssl bundle provided with the OS
ca.bundle = /etc/ssl/railgun-ca-certs.crt

# Memcached pools
#
# Use of a socket is recommended for best performance
# if your memcached does not require network connectivity
#
# Multiple memcached servers (host:port format) can be separated
# with a space
memcached.servers = $MEMCACHED_SERVERS

# Timeout for memcached lookup responses in milliseconds
# Increase this value if memcached I/O timeouts are occurring
# in the Railgun logs
memcached.timeout = 100

# The maximum size (in bytes) of an item that will be stored
# in memcached. Default to 1000000.
memcached.limit = 1000000

# The expiration time of individual memcached items in seconds.
# The default is 600 seconds (10 minutes). If set to 0 then
# the expiration time is infinite.
memcached.expiration = 600

# Statistics reporting
#
# Railgun provides key metrics by JSON over HTTP, syslog, and/or
# POSTs to a URL
#
# Set to 1 to enable statistics gathering and reporting
stats.enabled = 0

# Sets the URL (e.g. http://stats.example.com:9090/) to POST to.
# Defaults to nothing indicating that stats will not be POSTed anywhere
# stats.url = http://localhost:9090

# Determines whether stats are periodically written to the log file.
# Set to 1 to enable
stats.log = 1

# How often (in minutes) stats are generated (and logged and
# POSTed to the stats.url)
stats.interval = 1

# host:port on which to listen and create a simple HTTP API through
# which stats can be read
stats.listen = :24088

# Activation details
#
#     Website Owners: activation.token can be found at
#     https://www.cloudflare.com/my-railguns
#
#     CloudFlare Hosting Partners: activation.token can be found at
#     https://partners.cloudflare.com
#
# Set activation.railgun_host to the external IP, or a hostname that
# resolves to the external IP, of your Railgun instance.
activation.token = $ACCOUNT_TOKEN
activation.railgun_host = $ip

END
