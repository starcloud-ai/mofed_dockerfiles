#!/bin/bash
set -e

# Set memlock limit to unlimited
ulimit -l unlimited

exec "$@"