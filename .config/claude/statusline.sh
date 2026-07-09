#!/usr/bin/env bash

# Line 1: Model | Ctx: <tokens> | Ctx Used: <pct>% | Session: <5h-usage>%
# Line 2: <git root dir> | ⎇ <branch> | <cwd>
#
# All metrics come from the status JSON Claude Code passes on stdin:
# `.context_window` for context usage and `.rate_limits.five_hour` for
# session usage. No network or keychain access.
set -u

readonly SEP=" | "
readonly RESET=$'\033[0m'

c256() { printf '\033[38;5;%sm%s%s' "$1" "$2" "$RESET"; }

join_parts() {
  local out="" part
  for part in "$@"; do
    [[ -n "$out" ]] && out+="$SEP"
    out+="$part"
  done
  printf '%s' "$out"
}

# 1234 -> "1.2k", 1234567 -> "1.2M"
format_tokens() {
  awk -v t="$1" 'BEGIN {
    if (t >= 1000000 - 50) printf "%.1fM", t / 1000000
    else if (t >= 1000)    printf "%.1fk", t / 1000
    else                   printf "%d", t
  }'
}

main() {
  local model cwd ctx_tokens ctx_pct session_pct transcript
  # US (0x1f) delimiter: unlike tabs, non-whitespace IFS chars preserve empty fields in `read`
  IFS=$'\x1f' read -r model cwd ctx_tokens ctx_pct session_pct transcript < <(
    jq -r '
      def n(x): if (x | type) == "number" and x >= 0 then x else 0 end;
      def s(x): if (x | type) == "number" then (x | tostring) else "" end;
      (.context_window // {}) as $cw |
      ($cw.current_usage // null) as $u |
      (if ($u | type) == "object" then
         { len: (n($u.input_tokens) + n($u.cache_creation_input_tokens) + n($u.cache_read_input_tokens)),
           used: (n($u.input_tokens) + n($u.output_tokens) + n($u.cache_creation_input_tokens) + n($u.cache_read_input_tokens)) }
       elif ($u | type) == "number" then { len: $u, used: $u }
       else null end) as $t |
      (if ($cw.used_percentage | type) == "number" then s($cw.used_percentage)
       elif $t != null and ($cw.context_window_size | type) == "number" and $cw.context_window_size > 0 then
         ($t.used / $cw.context_window_size * 100 | tostring)
       else "" end) as $pct |
      [ (.model.display_name // .model.id // ""),
        (.workspace.current_dir // .cwd // ""),
        (if $t != null then ($t.len | tostring) else "" end),
        $pct,
        s(.rate_limits.five_hour.used_percentage),
        (.transcript_path // "") ] | join("\u001f")'
  )

  if [[ -z "$ctx_tokens" && -n "$transcript" && -f "$transcript" ]]; then
    ctx_tokens=$(tail -n 100 "$transcript" | jq -rs '
      [ .[] | select(.message.usage.input_tokens != null and .isSidechain != true) ] | last |
      if . == null then ""
      else (.message.usage | (.input_tokens // 0) + (.cache_creation_input_tokens // 0) + (.cache_read_input_tokens // 0) | tostring)
      end' 2>/dev/null)
  fi

  # ---- Line 1: Model | Ctx | Ctx Used | Session ----
  local -a line1=()
  if [[ -n "$model" ]]; then
    model=$(printf '%s' "$model" | sed -E 's/ *\([^)]*\)$//')
    line1+=("$(c256 109 "Model: $model")")
  fi
  if [[ -n "$ctx_tokens" ]]; then
    line1+=("$(c256 174 "Ctx: $(format_tokens "$ctx_tokens")")")
  fi
  if [[ -n "$ctx_pct" ]]; then
    line1+=("$(c256 180 "Ctx Used: $(printf '%.1f' "$ctx_pct")%")")
  fi
  if [[ -n "$session_pct" ]]; then
    line1+=("$(c256 110 "Session: $(printf '%.1f' "$session_pct")%")")
  fi

  # ---- Line 2: git root | branch | cwd ----
  local -a line2=()
  local git_root branch
  if git_root=$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null); then
    branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
    [[ -z "$branch" ]] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
    line2+=("$(c256 146 "${git_root##*/}")")
    line2+=("$(c256 140 "⎇ $branch")")
  else
    line2+=("$(c256 146 "no git")")
    line2+=("$(c256 140 "⎇ no git")")
  fi
  line2+=("$(c256 150 "$cwd")")

  join_parts ${line1[@]+"${line1[@]}"}
  printf '\n'
  join_parts ${line2[@]+"${line2[@]}"}
}

main
