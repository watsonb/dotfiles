# dotfiles

This is a repo for various config files.  Simply copy them to the correponding
directory in your environment.  The root of this directory is assumed to be
your home directory.

Branch names correspond to various environments.  Master/main will be the
default config.

## Updates

### 20260409 - STOW

I'm thinking of moving to GNU STOW to manage this.  This gist kind of captures
the concept:

[Using GNU Stow to manage your dotfiles](https://gist.github.com/andreibosco/cb8506780d0942a712fc)

So I think I'll lay out this repo in accordance with the gist.  This will
allow me to programatically clone this repo (e.g. to a container) and "install"
my configs more repeatably.

#### Using STOW

For humans:

- clone this dotfiles repo to your home directory (e.g. ~, $HOME).
- cd ~/dotfiles
- run `stow <package_name>`
- example: `stow foo`
  - result: the foo package in this repo has a .foorc file.  This file should
    be a *hidden* file in your home dir.  Therefore, stow puts a symlink in
    your homedir matching the name and pointing to the foo/.foorc in *this*
    repo.

Some notes/strategies:

1. I'd recommend using the https git clone endpoint to put this dotfiles
  repo into your homedir.  Basically clone it in this specific location in a
  "read-only" form.  This must be a top-level directory in your homedir for
  the stow command to symlink where you expect.
2. Go ahead and use the ssh git endpoint to clone this again in your normal
  "workspace" folder for editing.  Then you edit in your "workspace", push,
  change to the "read-only" copy, pull, and stow.

For devcontainers:

- clone the repo
- run the install.sh as part of the stow feature
