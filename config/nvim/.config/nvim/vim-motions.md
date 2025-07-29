# Vim Motions Reference

## Mode Switching

| Command | Action | From mode |
|---------|--------|-----------|
| `Esc` | Enter NORMAL mode | INSERT |
| `i` | Insert before cursor | NORMAL |
| `I` | Insert at beginning of line | NORMAL |
| `a` | Insert after cursor | NORMAL |
| `A` | Insert at end of line | NORMAL |
| `o` | Open line below | NORMAL |
| `O` | Open line above | NORMAL |

## Navigation (NORMAL mode)

| Command | Action |
|---------|--------|
| `h/j/k/l` | Move left/down/up/right |
| `w` | Next word |
| `e` | End of word |
| `b` | Previous word |
| `0` | Beginning of line |
| `$` | End of line |
| `^` | First non-blank character |
| `gg` | Beginning of input |
| `G` | End of input |

## Editing (NORMAL mode)

| Command | Action |
|---------|--------|
| `x` | Delete character |
| `dd` | Delete line |
| `D` | Delete to end of line |
| `dw/de/db` | Delete word/to end/back |
| `cc` | Change line |
| `C` | Change to end of line |
| `cw/ce/cb` | Change word/to end/back |
| `.` | Repeat last change |

## Additional Useful Commands

### Undo/Redo
| Command | Action |
|---------|--------|
| `u` | Undo |
| `Ctrl-r` | Redo |

### Copy/Paste
| Command | Action |
|---------|--------|
| `yy` | Yank (copy) line |
| `yw/ye/yb` | Yank word/to end/back |
| `p` | Paste after cursor |
| `P` | Paste before cursor |

### Visual Mode (Selection)
| Command | Action |
|---------|--------|
| `v` | Enter visual mode (character selection) |
| `V` | Enter visual line mode (line selection) |
| `Ctrl-v` | Enter visual block mode (column selection) |
| `Esc` | Exit visual mode |

### Selecting with Visual Mode

#### Basic Selection Workflow
1. Position cursor at start of text
2. Press `v` to enter visual mode
3. Use motion commands to extend selection
4. Perform action (y/d/c) or Esc to cancel

#### Common Selection Patterns
| Pattern | Action | Example |
|---------|--------|---------|
| `viw` | Select inner word | Selects word under cursor |
| `vaw` | Select around word | Includes surrounding spaces |
| `vi"` | Select inside quotes | Content between quotes |
| `va"` | Select around quotes | Includes the quotes |
| `vi(` or `vib` | Select inside parentheses | Content between () |
| `va(` or `vab` | Select around parentheses | Includes the () |
| `vi{` or `viB` | Select inside braces | Content between {} |
| `va{` or `vaB` | Select around braces | Includes the {} |
| `vit` | Select inside tag | HTML/XML tag content |
| `vat` | Select around tag | Includes the tags |

#### Visual Line Selection (V)
| Pattern | Action |
|---------|--------|
| `V` | Select current line |
| `Vj` | Select current + next line |
| `V3j` | Select current + 3 lines down |
| `Vk` | Select current + previous line |
| `VG` | Select from current to end |
| `Vgg` | Select from current to beginning |

#### Visual Block Selection (Ctrl-v)
| Pattern | Action |
|---------|--------|
| `Ctrl-v` then `j/k` | Select column down/up |
| `Ctrl-v` then `h/l` | Adjust column width |
| `Ctrl-v` then `$` | Select to end of lines |

#### Actions on Selected Text
| Command | Action |
|---------|--------|
| `y` | Yank (copy) selection |
| `d` | Delete selection |
| `c` | Change (delete and enter insert) |
| `>` | Indent selection |
| `<` | Outdent selection |
| `~` | Toggle case |
| `u` | Make lowercase |
| `U` | Make uppercase |

#### Tips for Beginners
1. **Visual feedback**: Selected text is highlighted
2. **Practice with `viw`**: Easy way to select words
3. **Use counts**: `v3w` selects next 3 words
4. **Combine motions**: `v$` selects to end of line
5. **Reselect**: `gv` reselects last visual selection