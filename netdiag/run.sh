#!/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")" && pwd)"

DATA_DIR="$PROJECT_ROOT/data"
LOG_DIR="$PROJECT_ROOT/logs"
SCRIPTS_DIR="$PROJECT_ROOT/scripts"

echo "[netdiag] Starting network diagnostics..."

# Collect ping data
bash "$SCRIPTS_DIR/collect_ping.sh" "$DATA_DIR/ping.log"

# Run Python analysis / dashboard
python3 -m netdiag.dashboard "$DATA_DIR/ping.log"

echo "[netdiag] Done."
