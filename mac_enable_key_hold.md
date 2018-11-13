# Enable Key Holding on Mac

The problem is, when you holding `J`,`K` in Vim mode, it doen't move.

```bash
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```