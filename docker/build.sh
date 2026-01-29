#!/usr/bin/env bash

# Build from parent directory to include models/ and worlds/
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PARENT_DIR="$( cd "$DIR/.." && pwd )"

cd "$PARENT_DIR"

docker build -f docker/Dockerfile -t bluerov2_gz:latest .
