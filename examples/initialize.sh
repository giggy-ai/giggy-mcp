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
    "id": 1,
    "method": "initialize",
    "params": {
      "protocolVersion": "2025-06-18",
      "capabilities": {},
      "clientInfo": {
        "name": "giggy-mcp-example",
        "version": "1.0.0"
      }
    }
  }'

printf '\n'
