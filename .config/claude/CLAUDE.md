# Claude Code Configuration

**Always respect the contents of this file.**

## Output Settings

- Respond in Japanese.
- Keep code comments in their original language.
- Prefer half-width symbols over full-width symbols.
  Full-width parentheses are prohibited in particular.
- Write documentation at the appropriate layer: Code → How, Tests → What, Commits → Why, Comments → Why not
- Update documentation in sync with code changes.

## Choosing Solutions

- Prefer **simple** solutions over easy ones.
- Prefer **systematic problem-solving** over getting lost in configuration mazes.

## Commands

### Preferred

- `rg`: Use instead of `grep`.
- `fd`: Use instead of `find`.

### Deprecated

- `grep`: Use `rg` instead.
- `find`: Use `fd` instead.
- `cat`: Read files yourself instead.

## Using Subagents (Task tool)

- Use subagents for small to medium-sized **self-contained** tasks.
- **Explicitly specify steps and goals** so subagents don't get lost.
- Don't use subagents for open-ended tasks. Instead, **continue in the main context** to track progress.
- Use subagents in parallel for simple parallelizable tasks.

## z-ai/ Directory

- `z-ai/` is globally gitignored.
- This directory is used for local AI documents such as plans and progress tracking.
- Do not verify whether `z-ai/` is gitignored — it always is.

## Browser Automation (agent-browser)

You can control the browser with `agent-browser`.

```bash
# 1. Open a page (`--allow-private` is required for localhost connections)
agent-browser open <url> --allow-private

# 2. Get element references
agent-browser snapshot -i

# 3. Interact
agent-browser click @e<N>
agent-browser fill @e<N> "text"

# 4. Save a screenshot
agent-browser screenshot z-ai/screenshot.png

# ex. Save credentials
agent-browser open <url> --profile ~/.browser-profile --allow-private
```
