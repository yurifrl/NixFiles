# Emacs

## Basics

- **C-c p a** Projectile find file
- **C-x** Read e(X)ecute
- **M** Unit defined by language
- **C** Independent unit
- **b** Backward
- **f** Forward
- **p** Previous (line)
- **n** Next (line)
- **a** Begin
- **e** End
- **C-x** Character extend
- **M-x** Named command extend
Arrows On helm list buffer navigate, opens file if press right?
You don’t want to do buffer management, just use C-c p

## Buffer

- **Ctrl+SPC** Flag buffer for deletion
- **Alt+Shift+D** Delete flagged buffers

## Dired

- **C-j** Enter file dir
- **C-l** Go up a level
- **C-r** Go back

## Important

- **<SPC>-Tab** Switch to last open buffer
- **C-c d** Close buffer on helm buffer list
- **C-x C-b** List buffers
- **C-x b** Quick buffer switch
- **C-x k** Kill buffer
- **C-x C-<left/right>** Quick switch buffers
- **C-x 1** Closes all windows except the one in focus
- **C-x 0** Closes current window, only use when on split
- **C-h f** Get help with function under cursor
- **C-h k** CMD Display CMD help
- **C-h c** CMD Display CMD short help
- **C-h m** Display docs on current major mode

### Config

- **SPC-f-e-R** Reload config

## [Multiple Cursors](https://github.com/syl20bnr/spacemacs/tree/develop/layers/%2Bmisc/multiple-cursors)  And [Iedit](https://github.com/syl20bnr/evil-iedit-state)

- **#** Highlights the word under the cursor and its other ocurrencences
- **SPC-s-e** iedit enable
- **n** Navigate to next occurrence of the word
- **C-V g r I** Multi cursor line begin
- **Cl-V g r A** Multi cursor line end

## Go

- **C-c C-j** Jump to definition
- **C-c C-d** Show short description
- **, h h** <godoc-at-point>

## My Keybinds

- **C-c p** helm-projectile

## Commands

- projectile-switch-project -> C-c C-p
- Describe-mode C-h m

### ????

- Start editing line above
- Start editing line below
- Start editing end of word
- Start editing begin word
- Replace word
- Move to line X
- Move X lines down
- Navigate window
- Rename, Delete, Move file & folder

## Not Important

- **C-a & C-e** Move cursor in the line (begin & end)
- **C-b|f|p|n** Move cursor
- **M-b|f|p|n** Move cursor by word
- **C-x C-s** Save file
- **C-u** NUMBER CMD Adds a number to the next command
- **M-f & M-b** Move cursor by word (forward & backward)
- **C-f & C-b** Move cursor (forward & backward)
- **M-a & M-e** Move cursor a paragraph (begin & end)
- **M-d** Delete word under the cursor
- **C-k** Kill from cursor to the end of line
- **C-o** Create line above
- **C-/** Undo
- **C-g C-/** Redo
- **C-x z** Repeat last command, hit z to keep repeating
- **C-<spc> C-w** Selects text and deletes selection
- **C-a C-k C-y** Move to the begin of line kill line and yank
- **C-x C-f** Find file
- **C-x s** Save buffer
- **C-z** leave emacs temporarily
- **C-h m** Show docs on current mode
- **C-s C-r** Search
- **C-x o** Move cursor to the “other” window
- **C-x C-c** End session
- **C-V & M-v** Scroll entire screen up and down respectively
- **C-l** Bring the cursor to mid window

## Spacemacs

- **<SPC> f e d** Open config
- **<SPC> f e R** Reload config