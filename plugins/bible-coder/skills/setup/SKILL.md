---
name: setup
description: Turn on Bibe Code readings for this agent. Installs the bible-coder CLI if the user agrees, switches this agent to the Bibe Code plugin with bible-coder setup --source plugin, and walks Codex users through trusting the plugin's Stop hook.
---

# Set Up Bibe Code Readings

Use this skill when the user wants Bibe Code readings under their agent's answers, or says the Bibe Code plugin shows nothing.

The plugin is silent until the user switches it on with the `bible-coder` CLI. Then, when a task finishes, one short reading from the user's plan appears under the final answer.

Steps:
1. Check the CLI: run `bible-coder help` and look for `setup [--source plugin`. If the command is missing or that line is absent, ask the user before installing anything, then run `npm i -g bible-coder`.
2. Switch this agent to the plugin:
   - Claude Code: `bible-coder setup --source plugin --client claude`
   - Codex: `bible-coder setup --source plugin --client codex`

   Setup asks for the Bible and the reading goal; pressing Enter keeps the current answers. Without a terminal, run it with no input (`bible-coder setup --source plugin --client claude < /dev/null`) to keep the current answers or start with the Gospel of John. Setup removes Bibe Code's own settings hook for that agent (a backup is saved next to the settings file), so only the plugin shows readings.
3. Codex only: ask the user to type `/hooks` in Codex and trust the Stop hook from the bible-coder plugin (its command runs `hooks/bibe-stop.sh`). Only the user can trust a hook.
4. Check: `bible-coder doctor --client claude` (or `--client codex`) should say "healthy — readings come from the Bibe Code plugin". The first reading appears under the answer of the next finished task, and doctor then shows when the plugin hook last ran.

Switching back or off:
- `bible-coder setup --source settings --client claude` makes the plugin silent and restores Bibe Code's own settings hook.
- `bible-coder hooks uninstall --client claude --yes` turns readings off from both sources.
- `bible-coder mute`, `stop` and `start` work the same with the plugin.

Do not edit the agent's settings files, the activation file or the plugin's files by hand.
