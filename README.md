# dotfiles

This is a repo for various config files.  Simply copy them to the correponding
directory in your environment.  The root of this directory is assumed to be
your home directory.

Branch names correspond to various environments.  Master/main will be the
default config.

## Updates

# 20260409 - STOW

I'm thinking of moving to GNU STOW to manage this.  This gist kind of captures
the concept:

[Using GNU Stow to manage your dotfiles](https://gist.github.com/andreibosco/cb8506780d0942a712fc)

So I think I'll lay out this repo in accordance with the gist.  This will
allow me to programatically clone this repo (e.g. to a container) and "install"
my configs more repeatably.
