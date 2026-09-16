#!/usr/bin/env bash

set -u

log_file="${1:-app.log}"
output_file="${2:-cleaned.log}"

if [[ ! -f "$log_file" ]]; then
    printf 'Error: file not found: %s\n' "$log_file" >&2
    exit 1
fi

if [[ ! -r "$log_file" ]]; then
    printf 'Error: file is not readable: %s\n' "$log_file" >&2
    exit 1
fi

# Transform the log:
# 1. Remove leading and trailing whitespace.
# 2. Replace ERROR with WARNING.
# 3. Remove DEBUG lines.
# 4. Remove blank lines.
sed \
    -e 's/^[[:space:]]*//' \
    -e 's/[[:space:]]*$//' \
    -e 's/ERROR/WARNING/g' \
    -e '/^[[:space:]]*DEBUG/d' \
    -e '/^[[:space:]]*$/d' \
    "$log_file" > "$output_file"

printf 'Processed log written to: %s\n' "$output_file"

printf '\nProcessed content:\n'
cat "$output_file"
