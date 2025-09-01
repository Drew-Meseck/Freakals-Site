#!/usr/bin/env bash

set -e

RUN_MANAGE_PY='poetry run -m src.manage'

echo 'Collecting Static files...'
$RUN_MANAGE_PY collectstatic --no-input

echo 'Running Migrations...'
$RUN_MANAGE_PY migrate --no-input

exec poetry run gunicorn \
    --bind 0.0.0.0:8000 \
    --workers 3 \
    --worker-class uvicorn.workers.UvicornWorker \
    src.project.asgi:application
