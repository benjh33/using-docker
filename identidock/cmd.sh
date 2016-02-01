#!/bin/bash
set -e

if [ "$ENV" = 'DEV' ]; then
    echo "Running development server"
    python identidock.py
elif [ "$ENV" = 'UNIT' ]; then
    echo "Running unit tests"
    python tests.py
else
    echo "Running production server"
    exec uwsgi --http 0.0.0.0:9090 --uwsgi-file /app/identidock.py \
        --callable app --stats 0.0.0.0:9191
fi