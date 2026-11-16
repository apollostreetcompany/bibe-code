# Bibe Code for Claude Code and Codex

When your coding agent finishes a task, Bibe Code shows one short Bible reading under the final answer and moves your reading plan forward. Free WEB and KJV text comes bundled with the `bible-coder` command-line tool. The verses are shown to you, not added to the model's context, and the hook never blocks your agent.

This repository holds the plugin only: a Stop hook and four skills. The readings, your plan and your progress live in the `bible-coder` CLI on your machine.

## Install

You need Node.js and `bible-coder` 0.4.1 or newer.

```sh
npm i -g bible-coder
```

Claude Code:

```sh
claude plugin marketplace add apollostreetcompany/bibe-code
claude plugin install bible-coder@bibe-code
bible-coder setup --source plugin --client claude
```

Codex CLI:

```sh
codex plugin marketplace add apollostreetcompany/bibe-code
codex plugin add bible-coder@bibe-code
bible-coder setup --source plugin --client codex
```

Then, in Codex, type `/hooks` and trust the Stop hook from the bible-coder plugin (its command runs `hooks/bibe-stop.sh`). Codex asks again only if that hook changes, and Bibe Code keeps it fixed across updates.

## Silent until you switch it on

Installing the plugin changes nothing on its own. Its hook exits at once, with no output, until `bible-coder setup --source plugin --client <claude|codex>` switches that agent to the plugin. Setup keeps your Bible and reading goal, and removes Bibe Code's own settings hook for that agent (a backup is saved next to the settings file), so you get one reading, not two.

Check it with `bible-coder doctor --client claude` (or `codex`). It runs a test reading and shows when the plugin hook last ran.

## Switch back, pause, or remove

- Use Bibe Code's own settings hook again: `bible-coder setup --source settings --client claude`. The plugin stays installed but silent.
- Pause readings: `bible-coder mute`, `bible-coder stop`, `bible-coder start`.
- Turn readings off from both sources: `bible-coder hooks uninstall --client claude --yes`.
- Remove the plugin: `claude plugin uninstall bible-coder@bibe-code` or `codex plugin remove bible-coder@bibe-code`.

## Updates

Run `claude plugin marketplace update bibe-code` or `codex plugin marketplace upgrade bibe-code` to fetch new plugin versions. Update the CLI with `npm i -g bible-coder`.

## Privacy and terms

The plugin itself makes no network calls and collects nothing. The `bible-coder` CLI keeps your plan and progress on your machine and talks to Bibe Code only for features you turn on, such as sync or Pro Bibles. See the [privacy policy](https://bibecoder.com/privacy/), the [terms](https://bibecoder.com/terms/) and the [docs](https://bibecoder.com/docs/).

## License

The files in this repository are under the MIT License (see [LICENSE](LICENSE)). The license does not cover the Bibe Code name, logo or icon.
