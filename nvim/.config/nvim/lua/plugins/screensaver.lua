return {
  "Root-lee/screensaver.nvim",
  config = function()
    require("screensaver").setup({
      idle_ms = 60 * 1000 * 10, -- Idle time in milliseconds (2 minutes)
      -- 🚀 Automatically start screensaver after idle time (set to false for manual only)
      auto_start = false,

      -- 🛡️ Disable auto-start when Neovim loses focus (e.g. switching tmux windows)
      -- Requires `set -g focus-events on` in your tmux.conf
      disable_on_focus_lost = true,

      -- ⌨️ Key to exit the screensaver
      exit_key = "<Esc>",

      custom_commands = {
        -- Aquarium (requires asciiquarium installed)
        aquarium = "asciiquarium -t",

        -- Matrix-style digital rain (requires cmatrix installed)
        cmatrix = "cmatrix -s",

        -- Rainbow cat animation (requires nyancat installed)
        nyancat = "nyancat",

        -- Fire effect (requires aafire installed)
        -- Note: aafire exits after one run, so we use a loop
        aafire = "while true; do aafire; done",

        -- Steam locomotive (requires sl installed)
        -- Note: sl exits after one run, so we use a loop
        sl = "while true; do sl -aF; done",

        -- Custom figlet animation
        figlet = "watch -n 1 'echo Neovim | figlet | lolcat'",
      },

      -- 🎬 List of enabled animations (defaults to all available)
      animations = {
        "aquarium",
        "bounce",
        "cmatrix",
        --"figlet",
        --"fire",
        "game_of_life",
        "matrix",
        "move_left",
        "move_right",
        "nyancat",
        "pipes",
        "rain",
        "random_case",
        "scramble",
        "sl",
        "snow",
        "starfield",
        "zoo",
      },

      -- 👻 Window transparency (0-100)
      winblend = 80,
    })
  end,
}
