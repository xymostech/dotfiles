#!/usr/bin/env bash

set -eo pipefail

echo "{"$(arc upload --json ~/screenshots/$(command ls -1 ~/screenshots | tail -1) | jq -r '.[].objectName')"}"
