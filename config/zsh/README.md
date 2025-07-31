# Zsh Configuration

## File Loading Order & Purpose

### `.zshenv`
**When:** Every zsh instance (scripts, commands, interactive shells)  
**Use for:** Minimal essentials only
- `DOTFILES` path
- XDG directories
- Critical PATH entries

### `.zprofile` 
**When:** Login shells only (terminal app, SSH login)  
**Use for:** Session setup
- Editor preferences (EDITOR, VISUAL)
- Sources `profile/` directory
- One-time initialization

### `.zshrc`
**When:** Interactive shells only  
**Use for:** Interactive features
- Sources platform-specific configs from `install/$PLATFORM/shell/`
- Sources `rc/` directory (aliases, functions, prompts)
- Completions and key bindings

## Directory Structure

```
.zsh/
├── profile/     # Login session setup (sourced by .zprofile)
│   ├── config.zsh    # User info (name, email)
│   ├── path.zsh      # PATH utility functions
│   └── platform.zsh  # OS/architecture detection
│
└── rc/          # Interactive configs (sourced by .zshrc)
    ├── aliases.zsh   # Command shortcuts
    └── *.zsh         # Tool integrations (git, ssh, starship, etc.)
```

## Key Principle

Keep `.zshenv` minimal! Every zsh script loads it, so extra weight here slows down all script execution.