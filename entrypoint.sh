#! /bin/sh

if [ -z "$TARGET_IP" ]; then
	echo "The TARGET_IP environment variable must be set!"
	exit 1
fi

if [ -z "$TARGET_PORT" ]; then
	export TARGET_PORT=8009
fi
 
envsubst '$TARGET_IP,$TARGET_PORT' < /etc/nginx/conf/nginx.conf.template > /etc/nginx/conf/nginx.conf

exec "$@"
