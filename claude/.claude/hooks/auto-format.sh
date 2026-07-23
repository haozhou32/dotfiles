#!/usr/bin/env bash

# auto-format.sh — Hook script for Claude Code
#
# Hooks run automatically at certain lifecycle events.
# See: https://docs.anthropic.com/en/docs/claude-code/files-and-configuration#hooks
#
# Available hooks:
#   pre-line
#   post-line
#   before-read
#   after-read
#   before-write
#   after-write
#   before-command
#   after-command
#   on-files-changed
#   on-start
#   on-stop

set -euo pipefail

# TODO: Add formatting logic here.
# For example, to auto-format files after edits:
# if command -v prettier &>/dev/null; then
#   prettier --write "$@"
# fi
