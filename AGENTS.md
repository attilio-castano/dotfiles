# Repository Guidelines

## Project Structure & Module Organization
- `install/macos/`: macOS setup. Includes `Brewfile`, `setup.zsh`, and `tools/` for per-tool installers (e.g., `codex.zsh`, `opencode.zsh`, `claude-code.zsh`, `homebrew.zsh`, `fnm.zsh`).
- `install/shell.sh`: Makes `zsh` the default shell (cross‑platform helpers).
- `config/`: Stowable dotfile modules (zsh, nvim, tmux, ghostty, git, etc.).
- `README.md` / `TODO.md`: Quick start and backlog.

## Deep Tree & Discovery Tips
- Depth: files can live 5–6 levels deep, often inside hidden paths (e.g., `config/zsh/.zsh/rc/*.zsh`). Don’t assume a shallow repo.
- Hotspots:
  - `config/zsh/.zsh/profile/*.zsh`: login/session setup (sourced by `.zprofile`).
  - `config/zsh/.zsh/rc/*.zsh`: interactive features, aliases, functions (sourced by `.zshrc`).
  - `install/macos/tools/*.zsh`: per‑tool installers.
- Include hidden files: use `fd -H` or `rg -uu` to include dotfiles and hidden dirs.
- Quick scans:
  - `fd -H --max-depth 6 -e zsh`
  - `find . -maxdepth 6 -type f -name '*.zsh'`
  - `rg -uu --glob '!**/.git/**' 'function|alias' config/ install/`
- Tree view: `lt`/`lta` aliases (eza) or `eza --tree --level=5` to preview nested structure.

## Build, Test, and Development Commands
- Setup macOS: `zsh install/macos/setup.zsh` (installs Homebrew, Brewfile packages, Node via `fnm`, and npm tools).
- Homebrew only: `brew bundle --file=install/macos/Brewfile`.
- Link dotfiles: from repo root run `cd config && stow -nv */` (preview) then `stow -v */` (apply). Alternatively, stay at repo root and specify package names: `stow -nv zsh nvim tmux ghostty starship git`.
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
- Preview stow linking before applying: `cd config && stow -nv */`

## Commit & Pull Request Guidelines
- Commit messages: imperative mood with optional scope, e.g., `macos: install Codex via npm`. Follow with short bullets for details. Reference issues as `(#123)` when relevant.
- Formatting: keep subject ≤72 chars; add a blank line before the body; wrap body at ~100 chars; use Markdown bullets (`-`) and fenced code blocks for commands.
- Branch naming: short, hyphenated topic (e.g., `codex-npm`, `nvim-keybinds`).
 - Pull requests: clear description, rationale, example commands/output, and any breaking changes. Keep diffs focused; avoid unrelated refactors. Use simple Markdown headings: Summary, Changes, Testing, Notes.
 - GitHub CLI: use `--body-file` or `-F` with a Markdown file; avoid `-b` with `\n` since GitHub renders backslashes literally. Write the body via heredoc and pass the file to `gh pr create`.

## Security & Configuration Tips
- Ensure `DOTFILES` points to the repo path before running setup.
- Node is managed via `fnm`; run `eval "$(fnm env)"` in sessions that install npm tools.
- Avoid duplicate installs (e.g., uninstall brew-installed tools if switching to npm).

## Shell Helpers & Navigation
- Reset shell: run `reset_shell` to exec a fresh login shell (`$SHELL -l`). This fully re-reads `.zprofile` and `.zshrc`.
- Reload config: run `reload_shell` to source `~/.zshrc` without replacing the process.
- Stow helpers: `stow_preview_all` (dry-run) and `stow_apply_all` (apply all) operate from `$DOTFILES/config`.
- Deep tree navigation shortcuts:
  - `lt`/`lta`: tree view of current dir via `eza`.
  - `fcd`: fuzzy cd into any subdirectory (fd + fzf preview).
  - `ff`/`fe`: fuzzy find files; `fe` opens selection in `$EDITOR`.
  - `lg`/`rgl`: grep across repo with ripgrep + fzf preview.
  - `zf`: jump using zoxide with preview.
  - Tip: `zf` jumps globally via history; `fcd` searches under the current directory.
