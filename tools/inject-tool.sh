#!/usr/bin/env bash
# Strict shell mode ensures errors are caught early during script discovery
set -euo pipefail

# Determine the absolute directory hosting project tooling commands
tool_bin_directory="$(cd "$(dirname "${BASH_SOURCE[0]}")/bin" && pwd)"

# Verify whether the tools/bin directory actually exists before scanning
if [[ ! -d "$tool_bin_directory" ]]; then
  exit 0
fi

# Dynamically discover all executable files in tools/bin to maintain zero-maintenance tool listing
for target_tool_path in "$tool_bin_directory"/*; do
  # Skip non-executable entries to prevent running auxiliary documentation or text files
  if [[ ! -x "$target_tool_path" || -d "$target_tool_path" ]]; then
    continue
  fi

  target_tool_name="$(basename "$target_tool_path")"

  # Query tool description using the mandatory --desc discovery flag
  tool_description_text="$("$target_tool_path" --desc 2>/dev/null || echo "No description provided")"

  # Output standardized tool signature for agent context consumption
  echo "${target_tool_name}: ${tool_description_text}"
done
