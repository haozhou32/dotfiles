#!/usr/bin/env bash

# clean-latex-aux.sh — PostToolUse hook for Claude Code
#
# Runs after Bash commands that involve LaTeX compilation.
# Cleans up auxiliary files with latexmk -c.

set -euo pipefail

# Read the hook input from stdin (JSON from Claude Code)
input="$(cat)"

# Extract the command that was run
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null)

# Skip if empty or not a LaTeX command
[[ -z "$cmd" || "$cmd" == "null" ]] && exit 0
if ! printf '%s' "$cmd" | grep -qE '(pdflatex|xelatex|lualatex|latexmk|tectonic)'; then
  exit 0
fi

# Extract working directory from tool input
cwd=$(printf '%s' "$input" | jq -r '.tool_input.workdir // ""' 2>/dev/null)
[[ -z "$cwd" || "$cwd" == "null" ]] && cwd="$HOME"

# Clean up auxiliary files
if command -v latexmk &>/dev/null; then
  cd "$cwd" && latexmk -c 2>/dev/null || true
else
  cd "$cwd"
  for ext in aux log out toc bbl blg synctex.gz fls fdb_latexmk nav snm vrb bcf run.xml lot lof idx ilg ind brf glo gls ist xmpdata thm; do
    rm -f ./*."$ext" 2>/dev/null
  done
fi
