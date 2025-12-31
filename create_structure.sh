#!/bin/bash

# Base directory
BASE_DIR=~/Desktop/Gproject/netdiag

# Create main directories
mkdir -p "$BASE_DIR/scripts"
mkdir -p "$BASE_DIR/netdiag"
mkdir -p "$BASE_DIR/data"
mkdir -p "$BASE_DIR/logs"
mkdir -p "$BASE_DIR/docs"

# Create placeholder files
touch "$BASE_DIR/scripts/collect_ping.sh"
touch "$BASE_DIR/netdiag/__init__.py"
touch "$BASE_DIR/netdiag/parser.py"
touch "$BASE_DIR/netdiag/analyzer.py"
touch "$BASE_DIR/netdiag/dashboard.py"
touch "$BASE_DIR/docs/usage.md"
touch "$BASE_DIR/README.md"
touch "$BASE_DIR/run.sh"

echo "Project structure created at $BASE_DIR"

