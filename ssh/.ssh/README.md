# Stow and .ssh

This doesn't work as well as you think it does, especially given your private
version of this repo.  You can't stow both repos to a common location locally.
Bummer, but that's just the way it is.  So we can maintain the spirit of using
stow by maintaining our config files in these repo(s), but we won't run the
stow command for ssh.  We'll just manually copy/link stuff.
