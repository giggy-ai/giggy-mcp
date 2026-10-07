#!/usr/bin/env bash
set -euo pipefail

: "${GIGGY_API_KEY:?Set GIGGY_API_KEY before running this script.}"

curl \
  --fail \
  --show-error \
  --silent \
  --request POST \
  "https://giggy.ai/mcp" \
  --header "Authorization: Bearer ${GIGGY_API_KEY}" \
  --header "Content-Type: application/json" \
  --data-raw '{
    "jsonrpc": "2.0",
    "id": 2,
    "method": "tools/list",
    "params": {}
  }'

printf '\n'
