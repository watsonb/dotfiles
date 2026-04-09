# Ben's Notes

I'm going to leave some notes here as I keep expanding neovim functionality
and am too lazy to bake into my setup playbook.

## Rest.nvim

On ubuntu, need to install following packages:
  - libcurl4-openssl-dev
  - jq
  - tidy

Then need to make this symlink

```bash
sudo ln -s /usr/include/x86_64-linux-gnu/curl /usr/local/include/curl
```

Next, lazy config/install vhyrro/luarocks.nvim

Then, lazy config/install rest.nvim

If your playbook installs the above packages and sets up the symlink before
the neovim install/config, it all should "just work"

Given the above packages and symlink, you can also just run

`:RocksInstall <plugin>`

For example:

`RocksInstall lua-curl`
