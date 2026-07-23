# Claude Code Configuration

## Setup

The macOS installer installs and configures Claude Code:

```sh
cd ~/dotfiles
./install.sh
```

To apply only the Claude stow package:

```sh
cd ~/dotfiles
stow --target="$HOME" claude
```

## Managed Files

| Repo path | Home path | Purpose |
|---|---|---|
| `claude/.claude/settings.json` | `~/.claude/settings.json` | Core settings (model, plugins, effort, editor mode) |
| `claude/.claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Global system prompt |
| `claude/.claude/.claudeignore` | `~/.claude/.claudeignore` | File scan ignore patterns |
| `claude/.claude/mcp.json` | `~/.claude/mcp.json` | Global MCP server definitions |
| `claude/.claude/skills/` | `~/.claude/skills/` | Custom local skills |
| `claude/.claude/agents/` | `~/.claude/agents/` | Custom subagent definitions |
| `claude/.claude/commands/` | `~/.claude/commands/` | Custom slash commands |
| `claude/.claude/hooks/` | `~/.claude/hooks/` | Lifecycle hook scripts |
| `claude/.claude/rules/` | `~/.claude/rules/` | Modular instruction files |

## What Is Not Tracked

Runtime data such as interaction history (`history.jsonl`), sessions, caches,
backups, projects, tasks, telemetry, plugins, and IDE integration files are
gitignored and remain local to your machine.

## Adding Custom Skills

Create a new directory under `skills/` with a `SKILL.md` file:

```sh
mkdir -p claude/.claude/skills/my-tool
touch claude/.claude/skills/my-tool/SKILL.md
```

See the `skills/my-skill/SKILL.md` template for the format.

## Adding Hooks

Create an executable script under `hooks/`:

```sh
touch claude/.claude/hooks/on-start.sh
chmod +x claude/.claude/hooks/on-start.sh
```

## Loading Rules

Rule files in `rules/` are instruction modules that you can reference by asking
Claude to load specific files. Each `.md` file contains focused instructions
for a particular domain (testing, formatting, architecture, etc.).
