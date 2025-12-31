#!/bin/bash

OUTPUT_FILE="$1"

TARGET="8.8.8.8"
COUNT=20

if [ -z "$OUTPUT_FILE" ]; then
  echo "Usage: collect_ping.sh <output_file>"
  exit 1
fi

echo "[collect_ping] Pinging $TARGET ..."
ping -c "$COUNT" "$TARGET" > "$OUTPUT_FILE"

echo "[collect_ping] Data saved to $OUTPUT_FILE"
