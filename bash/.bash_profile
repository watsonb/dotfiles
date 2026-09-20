export PATH=$PATH:/home/ben/bin
. "$HOME/.cargo/env"

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi


# Added by Antigravity CLI installer
export PATH="/home/ben/.local/bin:$PATH"
