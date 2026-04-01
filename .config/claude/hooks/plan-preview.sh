#!/bin/bash
INPUT=$(cat)
FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)
if [[ "$FILE" == */z-ai/plans/*.md ]]; then
  mo --no-open "$FILE"
fi
