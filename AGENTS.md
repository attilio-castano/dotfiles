# Repository Guidelines

## Project Structure & Module Organization
- `install/macos/`: macOS setup. Includes `Brewfile`, `setup.zsh`, and `tools/` for per-tool installers (e.g., `codex.zsh`, `opencode.zsh`, `claude-code.zsh`, `homebrew.zsh`, `fnm.zsh`).
- `install/shell.sh`: Makes `zsh` the default shell (cross‑platform helpers).
- `config/`: Stowable dotfile modules (zsh, nvim, tmux, ghostty, git, etc.).
- `README.md` / `TODO.md`: Quick start and backlog.

## Build, Test, and Development Commands
- Setup macOS: `zsh install/macos/setup.zsh` (installs Homebrew, Brewfile packages, Node via `fnm`, and npm tools).
- Homebrew only: `brew bundle --file=install/macos/Brewfile`.
- Link dotfiles: `stow -nv */` (preview) then `stow -v */` (apply).
- Install a single npm tool: `source install/macos/tools/codex.zsh && install_codex` (similar for `install_opencode`, `install_claude_code`).

## Coding Style & Naming Conventions
- Shell: prefer `zsh` for macOS tool scripts, `bash` for cross‑platform. Use `set -e` in installers, 4‑space indentation.
- Functions: `install_<tool>()`, `setup_<area>()`; keep output concise and emoji‑friendly where used.
- Filenames: lowercase with hyphens (e.g., `homebrew.zsh`, `codex.zsh`). One installer per file under `tools/`.
- Keep `setup.zsh` phased (Xcode → Homebrew → Brewfile → Node → npm tools).

## Testing Guidelines
- No formal test suite. Validate by running commands and checking versions:
  - `zsh install/macos/setup.zsh`
  - `brew --version`, `stow --version`, `node -v`, `npm -v`
  - `codex --version`, `opencode --version`, `claude-code --version`
- Use `stow -nv */` before linking to avoid conflicts.

## Commit & Pull Request Guidelines
- Commit messages: imperative mood with optional scope, e.g., `macos: install Codex via npm`. Follow with short bullets for details. Reference issues as `(#123)` when relevant.
- Formatting: keep subject ≤72 chars; add a blank line before the body; wrap body at ~100 chars; use Markdown bullets (`-`) and fenced code blocks for commands.
- Branch naming: short, hyphenated topic (e.g., `codex-npm`, `nvim-keybinds`).
- Pull requests: clear description, rationale, example commands/output, and any breaking changes. Keep diffs focused; avoid unrelated refactors. Use simple Markdown headings: Summary, Changes, Testing, Notes.

## Security & Configuration Tips
- Ensure `DOTFILES` points to the repo path before running setup.
- Node is managed via `fnm`; run `eval "$(fnm env)"` in sessions that install npm tools.
- Avoid duplicate installs (e.g., uninstall brew-installed tools if switching to npm).
