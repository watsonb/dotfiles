return {
  {
    "folke/sidekick.nvim",
    opts = {
      cli = {
        -- mux = {
        --   enabled = true,
        --   backend = "tmux",
        -- },
        win = {
          split = {
            width = 80,
          },
        },
        tools = {
          copilot = {
            native_scroll = true,
          },
          claude = {
            native_scroll = true,
          },
          gemini = {
            native_scroll = true,
          },
        },
      },
      copilot = {
        status = {
          level = vim.log.levels.OFF,
        },
      },
    },
  },
}
