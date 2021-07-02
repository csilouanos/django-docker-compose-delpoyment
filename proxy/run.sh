#!/bin/sh

set -e

# Takes the default.conf.tpl and streams it to a new one with 
# the global variables replaced with the real values
envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf

# Starts the nginx server. Run it in foreground.
nginx -g 'daemon off;'