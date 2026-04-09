return {
  "David-Kunz/gen.nvim",
  cmd = { "Gen" },
  keys = {
    {
      "<leader>om",
      ":<c-u>lua require('gen').select_model()<cr>",
      desc = "Select model",
      mode = { "n", "v" },
    },
    {
      "<leader>oat",
      ":Gen Generate_Ansible_Tasks<CR>",
      desc = "Generate Ansible Tasks",
      mode = { "n" },
    },
    {
      "<leader>oar",
      ":Gen Review_Ansible_Tasks<CR>",
      desc = "Review Ansible Tasks",
      mode = { "n" },
    },
  },
  config = function()
    local gen = require("gen")
    gen.setup({
      model = "codegemma", -- The default model to use.
      host = "localhost",
      port = "11434",
      quit_map = "q",
      retry_map = "<c-r>",
      display_mode = "split", -- The display mode. Can be "float" or "split".
      show_prompt = true, -- Shows the Prompt submitted to Ollama.
      show_model = true, -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false, -- Never closes the window automatically.
      -- I'm commenting out the init below as I have it setup to run as a systemd service
      --init = function(options)
      --  pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
      --end,
      -- Function to initialize Ollama
      command = function(options)
        return "curl --silent --no-buffer -X POST http://"
          .. options.host
          .. ":"
          .. options.port
          .. "/api/chat -d $body"
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a lua function returning a command string, with options as the input parameter.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      debug = false,
    })

    gen.prompts["Describe_Ansible_Snippet"] = {
      prompt = "Describe the purpose of this Ansible task:\n$text",
      replace = false,
    }

    gen.prompts["Review_Ansible_Tasks"] = {
      prompt = "Review the following Ansible tasks and make concise suggestions:\n```$filetype\n$text\n```",
      replace = false,
    }

    gen.prompts["Generate_Ansible_Tasks"] = {
      prompt = "Generate a list of Ansible tasks that accomplish the following:\n$input",
      replace = false,
    }
  end,
}
