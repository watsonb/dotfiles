local dap = require("dap")
dap.adapters.ansible = {
  type = "executable",
  command = "/home/ben/venvs/venv3_ansible-9.4.0/bin/python", -- or "/path/to/virtualenv/bin/python",
  args = { "-m", "ansibug", "dap" },
}

local ansibug_configurations = {
  {
    type = "ansible",
    request = "launch",
    name = "Debug playbook",
    playbook = "${file}",
  },
}

dap.configurations["yaml.ansible"] = ansibug_configurations

-- You may need to replace "yaml.ansible" with the filetype you use for ansible playbooks
-- "yaml.ansible" depends on a `ftdetect/ansible.vim` plugin with:
--      au BufRead,BufNewFile */playbooks/*.yml setlocal ft=yaml.ansible
--      au BufRead,BufNewFile */playbooks/*.yaml setlocal ft=yaml.ansible
