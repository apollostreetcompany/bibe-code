#!/bin/sh
# Bibe Code plugin hook for Claude Code and Codex. Silent until the user runs
# `bible-coder setup --source plugin`; then the same launcher as the settings hook runs.
# Hosts that load Claude-compatible hooks but discard their output never get further.
if [ "${GROK_HOOK_EVENT+x}${GROK_SESSION_ID+x}${GROK_HOOK_NAME+x}${GROK_WORKSPACE_ROOT+x}${GROK_PLUGIN_ROOT+x}${OPENHARNESS_HOOK_EVENT+x}${OPENHARNESS_HOOK_PAYLOAD+x}" ]; then exit 0; fi
# Codex exports PLUGIN_ROOT to plugin hooks; Claude Code does not.
client=claude
[ -n "${PLUGIN_ROOT:-}" ] && client=codex
dir="${XDG_DATA_HOME:-$HOME/.local/share}/bible-coder/hooks"
[ -f "$dir/plugin-$client.json" ] && [ -x "$dir/launch.sh" ] || exit 0
# Heartbeat for bible-coder doctor. `true`, not `:`: a failed redirection on a
# special builtin would end the script and lose the reading.
true 2>/dev/null >"$dir/plugin-$client.seen"
exec "$dir/launch.sh" hooks run --client "$client" --event Stop --mode bible --record --visibility notice --source plugin
