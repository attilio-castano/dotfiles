# Octo.nvim Keybindings

Octo provides a comprehensive GitHub integration for Neovim, allowing you to manage pull requests, issues, and code reviews directly from your editor.

## Prerequisites

Before using Octo, you need to set up GitHub authentication:

### 1. Install GitHub CLI
```bash
# macOS
brew install gh

# Linux
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh
```

### 2. Authenticate with GitHub
```bash
gh auth login
```

### 3. Verify Setup
```bash
gh repo view  # Should show your current repository info
```

## Keybinding Types

Octo has two distinct types of keybindings:

### **Global Keybindings** (`<leader>`)
- **Scope**: Work anywhere in Neovim
- **Format**: Use `<leader>` (configured as `<Space>` in this setup)
- **Purpose**: Launch Octo functionality from any buffer

### **Buffer-Specific Keybindings** (`<space>`)
- **Scope**: Only work inside Octo buffers (PR/Issue views)
- **Format**: Use literal `<space>` (hardcoded by Octo plugin)
- **Purpose**: Interact with GitHub content (PRs, issues, comments)

> **Note**: Both use the same physical key (`Space`), but the notation differs to show context. `<leader>` = global, `<space>` = Octo buffer only.

## Global Keybindings

Access Octo from anywhere in Neovim:

| Keys | Action | Description |
|------|--------|-------------|
| `<leader>go` | Open Octo | Open Octo main interface |
| `<leader>gpr` | List PRs | Show all pull requests |
| `<leader>gpi` | List issues | Show all issues |
| `<leader>gpc` | Create PR | Create new pull request |
| `<leader>gic` | Create issue | Create new issue |

## Pull Request Management

### Opening and Viewing PRs

| Command | Description |
|---------|-------------|
| `:Octo pr list` | List all pull requests |
| `:Octo pr search <query>` | Search PRs with specific criteria |
| `:Octo pr edit <number>` | Edit specific PR |
| `:Octo pr create` | Create new PR |
| `:Octo pr close <number>` | Close specific PR |
| `:Octo pr reopen <number>` | Reopen specific PR |

### Inside Pull Request Buffer

When viewing a PR, these keybindings are active:

#### Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `]c` | Next comment | Jump to next comment |
| `[c` | Previous comment | Jump to previous comment |
| `]q` | Next changed file | Navigate to next file |
| `[q` | Previous changed file | Navigate to previous file |
| `gf` | Go to file | Open file under cursor |

#### PR Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<space>po` | Checkout PR | Checkout PR branch locally |
| `<space>pm` | Merge PR | Merge PR (commit merge) |
| `<space>psm` | Squash and merge | Squash and merge PR |
| `<space>pc` | List commits | Show PR commits |
| `<space>pf` | Changed files | Show PR changed files |
| `<space>pd` | Show diff | Show PR diff |
| `<space>pl` | List PRs | List all PRs |

#### PR Merge Commands

Octo provides comprehensive merge commands that respect your configuration defaults and allow fine-grained control:

##### Basic Merge Commands

**Note**: These commands work on the currently opened PR (via `:Octo pr edit <number>`)

| Command | Description | Default Behavior |
|---------|-------------|------------------|
| `:Octo pr merge` | Merge current PR using default method | Uses `default_merge_method` config |
| `:Octo pr merge commit` | Standard merge commit | Creates a merge commit |
| `:Octo pr merge squash` | Squash and merge | Combines commits into one |
| `:Octo pr merge rebase` | Rebase and merge | Rebases commits onto base branch |

##### Branch Deletion Options

You can control branch deletion by adding arguments:

| Command Example | Description |
|-----------------|-------------|
| `:Octo pr merge delete` | Force delete branch after merge |
| `:Octo pr merge nodelete` | Keep branch after merge |
| `:Octo pr merge squash delete` | Squash merge and delete branch |
| `:Octo pr merge rebase nodelete` | Rebase merge and keep branch |

Without specifying `delete` or `nodelete`, the command uses your `default_delete_branch` configuration.

##### Admin Merge Commands (Custom)

For repositories with branch protection, use admin privileges. Unlike the basic commands, these require a PR number since they use the GitHub CLI directly:

| Command | Description |
|---------|-------------|
| `:Octo pr merge_admin <PR>` | Admin merge with defaults |
| `:Octo pr merge_admin <PR> squash` | Admin squash merge |
| `:Octo pr merge_admin <PR> rebase` | Admin rebase merge |
| `:Octo pr merge_admin <PR> commit` | Admin standard merge |
| `:Octo pr merge_admin <PR> squash delete` | Admin squash merge and delete |
| `:Octo pr merge_admin <PR> nodelete` | Admin merge and keep branch |

Examples:
- `:Octo pr merge_admin 42` - Merge PR #42 with admin privileges using defaults
- `:Octo pr merge_admin 42 squash delete` - Squash merge PR #42 and delete branch
- `:Octo pr merge_admin` - Will prompt for PR number if not provided

##### Configuration Defaults

The merge behavior is controlled by these settings in your Octo config:
- `default_merge_method`: "commit" | "squash" | "rebase" (default: "commit")
- `default_delete_branch`: true | false (default: false)

#### Review Management
| Key | Action | Description |
|-----|--------|-------------|
| `<space>va` | Add reviewer | Add reviewer to PR |
| `<space>vd` | Remove reviewer | Remove reviewer from PR |

#### Comments and Reactions
| Key | Action | Description |
|-----|--------|-------------|
| `<space>ca` | Add comment | Add new comment |
| `<space>cd` | Delete comment | Delete comment |
| `<space>cs` | Add suggestion | Add code suggestion |
| `<space>r+` | 👍 reaction | Add/remove thumbs up |
| `<space>r-` | 👎 reaction | Add/remove thumbs down |
| `<space>rh` | ❤️ reaction | Add/remove heart |
| `<space>rp` | 🎉 reaction | Add/remove party |
| `<space>rr` | 🚀 reaction | Add/remove rocket |
| `<space>rl` | 😄 reaction | Add/remove laugh |
| `<space>rc` | 😕 reaction | Add/remove confused |
| `<space>re` | 👀 reaction | Add/remove eyes |

#### Utility
| Key | Action | Description |
|-----|--------|-------------|
| `<C-r>` | Reload | Refresh PR content |
| `<C-b>` | Open in browser | Open PR in GitHub |
| `<C-y>` | Copy URL | Copy PR URL to clipboard |

## Issue Management

### Opening and Viewing Issues

| Command | Description |
|---------|-------------|
| `:Octo issue list` | List all issues |
| `:Octo issue search <query>` | Search issues |
| `:Octo issue edit <number>` | Edit specific issue |
| `:Octo issue create` | Create new issue |
| `:Octo issue close <number>` | Close issue |
| `:Octo issue reopen <number>` | Reopen issue |

### Inside Issue Buffer

When viewing an issue, these keybindings are active:

#### Navigation
| Key | Action | Description |
|-----|--------|-------------|
| `]c` | Next comment | Jump to next comment |
| `[c` | Previous comment | Jump to previous comment |
| `<space>gi` | Go to issue | Navigate to local repo issue |

#### Issue Actions
| Key | Action | Description |
|-----|--------|-------------|
| `<space>ic` | Close issue | Close the issue |
| `<space>io` | Reopen issue | Reopen the issue |
| `<space>il` | List issues | List all issues |

#### Assignment and Labels
| Key | Action | Description |
|-----|--------|-------------|
| `<space>aa` | Add assignee | Add assignee to issue |
| `<space>ad` | Remove assignee | Remove assignee from issue |
| `<space>la` | Add label | Add label to issue |
| `<space>ld` | Remove label | Remove label from issue |
| `<space>lc` | Create label | Create new label |

#### Comments and Reactions
| Key | Action | Description |
|-----|--------|-------------|
| `<space>ca` | Add comment | Add new comment |
| `<space>cd` | Delete comment | Delete comment |
| `<space>r+` | 👍 reaction | Add/remove thumbs up |
| `<space>r-` | 👎 reaction | Add/remove thumbs down |
| `<space>rh` | ❤️ reaction | Add/remove heart |
| `<space>rp` | 🎉 reaction | Add/remove party |
| `<space>rr` | 🚀 reaction | Add/remove rocket |
| `<space>rl` | 😄 reaction | Add/remove laugh |
| `<space>rc` | 😕 reaction | Add/remove confused |
| `<space>re` | 👀 reaction | Add/remove eyes |

#### Utility
| Key | Action | Description |
|-----|--------|-------------|
| `<C-r>` | Reload | Refresh issue content |
| `<C-b>` | Open in browser | Open issue in GitHub |
| `<C-y>` | Copy URL | Copy issue URL to clipboard |

## Code Review

### Starting a Review

| Command | Description |
|---------|-------------|
| `:Octo review start` | Start reviewing a PR |
| `:Octo review submit` | Submit review |
| `:Octo review resume` | Resume pending review |

### Review Thread Navigation

When in a review thread:

| Key | Action | Description |
|-----|--------|-------------|
| `]c` | Next comment | Jump to next comment |
| `[c` | Previous comment | Jump to previous comment |
| `]q` | Next changed file | Navigate to next file |
| `[q` | Previous changed file | Navigate to previous file |
| `<C-c>` | Close review tab | Close review interface |

### Review Actions

| Key | Action | Description |
|-----|--------|-------------|
| `<space>ca` | Add comment | Add review comment |
| `<space>cs` | Add suggestion | Add code suggestion |
| `<space>cd` | Delete comment | Delete review comment |

### Review Diff Mode

When viewing diffs in review mode:

| Key | Action | Description |
|-----|--------|-------------|
| `<space>ca` | Add review comment | Add comment to specific line |
| `<space>cs` | Add suggestion | Add code suggestion |
| `<leader>e` | Focus files | Focus on changed files panel |
| `<leader>b` | Toggle files | Hide/show files panel |
| `]t` | Next thread | Move to next discussion thread |
| `[t` | Previous thread | Move to previous discussion thread |
| `<leader><space>` | Toggle viewed | Mark file as viewed/unviewed |
| `gf` | Go to file | Open file under cursor |
| `<C-c>` | Close review | Close review interface |

### File Panel (Review Mode)

When focused on the file panel:

| Key | Action | Description |
|-----|--------|-------------|
| `j` | Next file | Move to next changed file |
| `k` | Previous file | Move to previous changed file |
| `<cr>` | Select file | Show file diff |
| `R` | Refresh | Refresh file list |
| `<leader>e` | Focus files | Focus file panel |
| `<leader>b` | Toggle files | Hide/show file panel |
| `<leader><space>` | Toggle viewed | Mark as viewed/unviewed |

### Submit Review

In the submit review window:

| Key | Action | Description |
|-----|--------|-------------|
| `<C-a>` | Approve | Approve the PR |
| `<C-m>` | Comment | Submit as comment |
| `<C-r>` | Request changes | Request changes |
| `<C-c>` | Cancel | Cancel review submission |

## Advanced Usage

### Custom Commands

| Command | Description |
|---------|-------------|
| `:Octo actions` | Show available actions |
| `:Octo pr checks` | Show PR status checks |
| `:Octo pr ready` | Mark PR as ready for review |
| `:Octo pr draft` | Convert PR to draft |
| `:Octo issue browser` | Open issue in browser |
| `:Octo gist list` | List your gists |

### Telescope Integration

The configuration uses Telescope for fuzzy finding. When listing PRs or issues, you can:

| Key | Action | Description |
|-----|--------|-------------|
| `<C-b>` | Open in browser | Open selected item in browser |
| `<C-y>` | Copy URL | Copy URL to clipboard |
| `<C-o>` | Checkout PR | Checkout selected PR |
| `<C-m>` | Merge PR | Merge selected PR |

## Workflow Integration

### Complete Git → GitHub Flow

1. **Local Development**:
   - Use `gitsigns` for local changes
   - Use `neogit` for git operations
   - Use `diffview` for detailed diffs

2. **Create PR**:
   - `<leader>gpc` to create PR from current branch
   - Or `:Octo pr create` for more options

3. **Review Process**:
   - `<leader>gpr` to list PRs
   - Select PR and use review keybindings
   - Add comments, suggestions, reactions

4. **Merge**:
   - `<space>pm` to merge PR
   - Or `<space>psm` to squash and merge

### Issue Management Flow

1. **List Issues**: `<leader>gpi`
2. **Create Issue**: `<leader>gic`
3. **Manage**: Use issue keybindings for labels, assignees, comments
4. **Close**: `<space>ic` when resolved

## Configuration Notes

### Authentication
- Uses GitHub CLI (`gh`) for authentication
- Respects `gh` configuration and tokens
- Works with GitHub Enterprise if configured in `gh`

### Remotes
- Checks `upstream` remote first, then `origin`
- Configurable via `default_remote` setting
- Supports SSH aliases

### Performance
- Lazy loads on first `:Octo` command
- Caches data to reduce API calls
- Timeout configurable (default: 5 seconds)

## Troubleshooting

### Common Issues

1. **Authentication Error**:
   ```bash
   gh auth status  # Check authentication
   gh auth refresh  # Refresh token
   ```

2. **API Rate Limits**:
   - GitHub API has rate limits
   - Authenticated requests have higher limits
   - Wait or use personal access token

3. **Repository Not Found**:
   - Ensure you're in a git repository
   - Check remote configuration: `git remote -v`
   - Verify GitHub repository exists

4. **Keybinding Conflicts**:
   - Octo keybindings are buffer-specific
   - Only active in Octo buffers
   - Check `:map` for conflicts

### Debug Information

```
:Octo actions         " Show available actions
:checkhealth octo     " Check plugin health
:lua print(vim.inspect(require('octo.config').get_config()))  " Show config
```

## Tips

1. **Use with Neogit**: Perfect complement to local git operations
2. **Telescope Integration**: Fuzzy find PRs and issues efficiently  
3. **Review Workflow**: Use review mode for thorough code reviews
4. **Reactions**: Quick way to acknowledge comments without lengthy replies
5. **Draft PRs**: Use draft PRs for work-in-progress sharing

[Back to keybindings index](./README.md)