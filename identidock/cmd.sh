#!/bin/bash
set -e
DIR=$(pwd)
if [ "$ENV" = 'DEV' ]; then
    echo "Running development server"
    python $DIR/identidock.py
elif [ "$ENV" = 'UNIT' ]; then
    echo "Running unit tests"
    python $DIR/tests.py
else
    echo "Running production server"
    exec uwsgi --http 0.0.0.0:9090 --wsgi-file /app/identidock.py \
        --callable app --stats 0.0.0.0:9191
fi
