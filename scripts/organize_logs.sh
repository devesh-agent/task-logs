#!/usr/bin/env bash
# organize_logs.sh — Archive previous month's daily logs into a single monthly file.
# Runs on the 1st of each month via cron.

set -euo pipefail

DOCS_DIR="/home/gcpuser/docs"
LOGS_DIR="$DOCS_DIR/logs"
ARCHIVE_DIR="$DOCS_DIR/archive"

# Determine previous month
YEAR=$(date -d "last month" +%Y)
MONTH=$(date -d "last month" +%m)
MONTH_LABEL=$(date -d "last month" +%B\ %Y)
PREFIX="${YEAR}-${MONTH}"
ARCHIVE_FILE="$ARCHIVE_DIR/${PREFIX}.md"

# Find daily logs from last month
FILES=$(ls "$LOGS_DIR"/${PREFIX}-*.md 2>/dev/null | sort || true)

if [ -z "$FILES" ]; then
  echo "$(date): No logs to archive for $MONTH_LABEL" >> "$DOCS_DIR/organize.log"
  exit 0
fi

echo "# Task Log Archive — $MONTH_LABEL" > "$ARCHIVE_FILE"
echo "" >> "$ARCHIVE_FILE"

for f in $FILES; do
  day=$(basename "$f" .md)
  echo "---" >> "$ARCHIVE_FILE"
  cat "$f" >> "$ARCHIVE_FILE"
  echo "" >> "$ARCHIVE_FILE"
  rm "$f"
done

echo "$(date): Archived $MONTH_LABEL logs → $ARCHIVE_FILE" >> "$DOCS_DIR/organize.log"

# Commit the archive to git
cd "$DOCS_DIR"
git add -A
git commit -m "archive: $MONTH_LABEL task logs"
git push origin main
