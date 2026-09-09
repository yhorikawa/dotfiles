# Claude Code Configuration

**Always respect the contents of this file.**

## Output Settings

- Think in English → Respond in Japanese.
- Keep code comments in their original language.
- Prefer half-width symbols over full-width symbols.
  Full-width parentheses are prohibited in particular.
- Write documentation at the appropriate layer: Code → How, Tests → What, Commits → Why, Comments → Why not
- Update documentation in sync with code changes.
- Never leave tool-specific markers in code comments (e.g. ponytail:). The tool is optional and the marker turns into noise the moment it is gone. Use LIMITATION: for a deliberate simplification with a known ceiling.

## Choosing Solutions

- Prefer **simple** solutions over easy ones.
- Prefer **systematic problem-solving** over getting lost in configuration mazes.

## Using Subagents (Task tool)

- Use subagents for small to medium-sized **self-contained** tasks.
- **Explicitly specify steps and goals** so subagents don't get lost.
- Don't use subagents for open-ended tasks. Instead, **continue in the main context** to track progress.
- Use subagents in parallel for simple parallelizable tasks.

## z-ai/ Directory

- `z-ai/` is globally gitignored.
- This directory is used for local AI documents such as plans and progress tracking.
- Do not verify whether `z-ai/` is gitignored — it always is.
