#!/bin/sh

set -e

python manage.py wait_for_db

# Will collect all the static files.
# Places all the static files to '/vol/web/static'
python manage.py collectstatic --noinput
python manage.py migrate

# workers: number of concurent workers
# master: run as the master daemon
# enable-threads: enables mutlithreading
# module: runs the app wsgi module 
uwsgi --socket :9000 --workers 4 --master --enable-threads --module app.wsgi