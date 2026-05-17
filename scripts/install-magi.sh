#!/usr/bin/env bash
set -euo pipefail

OPENCLAW_HOME="${OPENCLAW_HOME:-$HOME/.openclaw}"
HOST_WORKSPACE="${HOST_WORKSPACE:-$OPENCLAW_HOME/workspace}"
INSTALL_HOST_SKILL=0
NO_BACKUP=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --openclaw-home)
      OPENCLAW_HOME="$2"
      shift 2
      ;;
    --host-workspace)
      HOST_WORKSPACE="$2"
      shift 2
      ;;
    --install-host-skill)
      INSTALL_HOST_SKILL=1
      shift
      ;;
    --no-backup)
      NO_BACKUP=1
      shift
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_ROOT="$OPENCLAW_HOME/backups/magi-tribunal-$TIMESTAMP"

copy_overlay_with_backup() {
  local source="$1"
  local destination="$2"
  local label="$3"

  if [[ ! -d "$source" ]]; then
    echo "Missing source: $source" >&2
    exit 1
  fi

  if [[ -e "$destination" && "$NO_BACKUP" -eq 0 ]]; then
    mkdir -p "$BACKUP_ROOT"
    cp -a "$destination" "$BACKUP_ROOT/$label"
  fi

  mkdir -p "$destination"
  cp -a "$source"/. "$destination"/
}

copy_overlay_with_backup "$REPO_ROOT/workspace-magi" "$OPENCLAW_HOME/workspace-magi" "workspace-magi"
copy_overlay_with_backup "$REPO_ROOT/workspace-magi-melchior" "$OPENCLAW_HOME/workspace-magi-melchior" "workspace-magi-melchior"
copy_overlay_with_backup "$REPO_ROOT/workspace-magi-balthasar" "$OPENCLAW_HOME/workspace-magi-balthasar" "workspace-magi-balthasar"
copy_overlay_with_backup "$REPO_ROOT/workspace-magi-casper" "$OPENCLAW_HOME/workspace-magi-casper" "workspace-magi-casper"

if [[ -f "$OPENCLAW_HOME/openclaw.json" && "$NO_BACKUP" -eq 0 ]]; then
  mkdir -p "$BACKUP_ROOT"
  cp -a "$OPENCLAW_HOME/openclaw.json" "$BACKUP_ROOT/openclaw.json"
fi

if [[ "$INSTALL_HOST_SKILL" -eq 1 ]]; then
  copy_overlay_with_backup \
    "$REPO_ROOT/host-integration/skills/magi-tribunal" \
    "$HOST_WORKSPACE/skills/magi-tribunal" \
    "host-skill-magi-tribunal"
  echo "Installed host skill -> $HOST_WORKSPACE/skills/magi-tribunal"
  echo "Add host-integration/AGENTS.snippet.md to the host AGENTS.md routing rules."
fi

echo "Installed MAGI workspaces under $OPENCLAW_HOME"
echo "Next step: merge openclaw.magi.example.json5 into $OPENCLAW_HOME/openclaw.json"
echo "Keep the explicit workspace fields and magi.subagents.allowAgents."
