---
tool: claude-code
model: claude-sonnet-5
date: 2026-09-15
status: draft
related: [nvim/.config/nvim/lua/config/keymaps.lua, nvim/.config/nvim/lua/plugins/sidekick.lua, nvim/.config/nvim/lua/plugins/smart-splits.lua, ai_assisted/proposals/herdr_sidekick_backend.claude.lua, ai_assisted/archive/herdr_sidekick_keymap.claude.lua]
---

# Survey: herdr SKILL files + Neovim herdr plugins (before building custom navigation)

Goal: solve "`<leader>ah` launches a herdr-tracked pane, but I'm keyboard-trapped in it —
no h/j/k/l way back to the Neovim split on the left." Surveyed the ecosystem before
writing a custom `smart-splits`-style integration. All repos below were verified live
via `gh api` (real repo, stars, last-push date) — not taken on faith from search
snippets. `herdr` here is v0.9.0 (`~/.local/bin/herdr`), confirmed to have a `herdr
plugin` subcommand (install/link/action/pane), which every plugin below depends on.

## Why this is a known gap, not a config mistake

`devxplay/herdr.nvim`'s README states it plainly: **"Herdr does not currently expose
tmux-style process-aware key forwarding."** Unlike tmux/wezterm/kitty (which
`smart-splits.nvim`'s built-in `multiplexer_integration` already supports),
herdr has no built-in "if the focused pane is running Vim, forward the key into Vim,
otherwise move pane focus" behavior. Every navigation plugin below re-implements that
bridge, using the same two herdr primitives our own draft
(`herdr_sidekick_backend.claude.lua`) already found: `herdr pane focus --direction` and
`herdr pane neighbor`/`process-info`. None of them are built into herdr itself — they
all require `herdr plugin install|link` on the herdr side *and* an nvim plugin on the
editor side, plus manual keybind wiring in `~/.config/herdr/config.toml`.

## Neovim navigation plugins (the core ask)

| Plugin | Stars | Approach | Fit for us |
|---|---|---|---|
| [lmilojevicc/herdr-splits.nvim](https://github.com/lmilojevicc/herdr-splits.nvim) | 61 | Explicitly "inspired by smart-splits.nvim, ported to Herdr's CLI." Same `<C-hjkl>` move / `<M-hjkl>` resize split we already use. Adds plugin-aware ignore list (snacks/neo-tree/dadbod-ui/aerial, floats), configurable `at_edge` (wrap/stop/split), count-prefix support (`3<C-h>`). | **Best match** — mirrors the smart-splits config we already have in `nvim/.config/nvim/lua/plugins/smart-splits.lua`, so muscle memory carries over exactly. |
| [paulbkim-dev/vim-herdr-navigation](https://github.com/paulbkim-dev/vim-herdr-navigation) | 107 | Literal `vim-tmux-navigator` port. herdr side checks the focused pane's foreground process via `herdr pane process-info`; if Vim, forwards the keypress with `herdr pane send-keys`, else calls `herdr pane focus`. Editor side maps to `wincmd h/j/k/l` and falls through to `herdr pane focus` at an edge. Uses `$HERDR_PANE_ID` (same env var our keymap already reads via `vim.fn.getcwd`/pane JSON). | Most-starred, most battle-tested; good alternative if herdr-splits.nvim's extra features (resize, plugin-aware ignore list) aren't needed. |
| [devxplay/herdr.nvim](https://github.com/devxplay/herdr.nvim) | 11 | Different mechanism: nvim writes a per-pane marker file; a compiled Rust helper (`herdr-navigator`) bound in herdr checks the marker to decide "forward into nvim" vs "move herdr focus." Notably **detects and coexists with `vim-tmux-navigator`** if you're ever inside both tmux and herdr. | Worth knowing about only if we end up nesting herdr inside tmux (we don't currently) — otherwise more moving parts (Rust build step) for no extra benefit over the two above. |
| [bojackduy/nvim-herdr-navigation](https://github.com/bojackduy/nvim-herdr-navigation) | 6 | Same idea as vim-herdr-navigation, two-part install, requires explicitly blanking herdr's built-in `focus_pane_*` keybindings in `config.toml` so the plugin intercepts first. | Functionally redundant with the two higher-starred options above. |

**Recommendation if we pursue a plugin instead of the custom backend**:
`lmilojevicc/herdr-splits.nvim` first — it's the one explicitly modeled on the plugin
already in `nvim/.config/nvim/lua/plugins/smart-splits.lua`, so the keybinds
(`<C-h/j/k/l>` move, `<A-h/j/k/l>` resize) match what's already muscle memory, and
it explicitly ignores the same kind of sidebar/float buffers our smart-splits config
already excludes (`ignored_filetypes`/`ignored_buftypes`).

## Other Neovim ↔ herdr plugins (not navigation, but adjacent — for context)

| Plugin | Stars | What it does |
|---|---|---|
| [ChmaraX/herdr-nvim](https://github.com/ChmaraX/herdr-nvim) | 181 | Full nvim-as-sidebar-inside-herdr: toggles a persistent nvim pane, fuzzy-picks files the agent recently touched, sends code annotations back to the agent. Highest-starred herdr+nvim project overall, but solves a different problem (agent-aware file review UI) than pane navigation. |
| [ctbaum/herdr-agents.nvim](https://github.com/ctbaum/herdr-agents.nvim) | 4 | Bridges `claudecode.nvim`/`codex.nvim` into real herdr sibling panes without losing editor connection — closest in spirit to our own `herdr_sidekick_backend.claude.lua` draft (a herdr-backed sidekick session), built by someone else already. Worth reading before finishing that draft — may replace it outright. |
| [makyinmars/herdr-context.nvim](https://github.com/makyinmars/herdr-context.nvim) | 10 | Select code/lines in nvim, pick a live herdr agent, stage that selection into the agent's prompt without submitting. |
| [MomePP/herd.nvim](https://github.com/MomePP/herd.nvim) | 3 | Inverts the model: nvim is the top-level UI, herdr agents show as nvim floating terminals while herdr runs as background daemon owning the PTYs. |
| [raymondware/herdr.nvim](https://github.com/raymondware/herdr.nvim) | 4 | Just status visibility — floating terminal, lualine component, agent-state highlight groups. No navigation. (Note: name collides with `devxplay/herdr.nvim` above — different, unrelated plugin.) |

## AI Skill files for herdr

herdr ships exactly **one** official skill, already on this machine — running
`herdr --skill` prints it directly (confirmed live, `name: herdr` frontmatter). It's
also on GitHub and installable generically:

```bash
npx skills add herdrdev/herdr --skill herdr -g
```

That's the skill our `herdr agent`/`herdr pane` keymap code and the two
`ai_assisted/proposals` drafts were already written against — nothing to add there.

Beyond the official one, GitHub code search turned up mostly **personal vendored
copies** of that same official skill inside people's dotfiles (not distinct
skills) — `TechDufus/dotfiles`, `dkarter/dotfiles`, `mozumasu/dotfiles`,
`yuucu/dotfiles`, `edmundmiller/dotfiles`, `dmmulroy/skills`, `sammcj/agentic-coding`.
That pattern (vendoring the skill into your own dotfiles repo under `agents/skills/` or
`.claude/skills/`) is worth noting for our own setup if we want the skill pinned/offline
rather than fetched via `npx` each time.

Two genuinely distinct **third-party** skills exist for multi-agent orchestration atop
herdr (not navigation-related, but relevant if we ever want an agent to *drive* other
herdr agents):

| Skill | Repo | What it teaches |
|---|---|---|
| herdr-peer-agents-skill | [msadig/herdr-peer-agents-skill](https://github.com/msadig/herdr-peer-agents-skill) | Start a named peer agent, assign it work, collect its result. |
| herdr-orchestrator-skill | [HarshaLakkaraju/herdr-orchestrator-skill](https://github.com/HarshaLakkaraju/herdr-orchestrator-skill) | Multi-agent workflow coordination: planning, model routing, shared artifacts, review, testing, pane cleanup. |

## Bottom line / decision points

1. **Navigation gap is real and common** — not something to route around with a custom
   hack; several maintained plugins already solve exactly this, with `herdr-splits.nvim`
   the closest match to our existing smart-splits setup.
2. Every option needs a two-sided install (`herdr plugin install|link ...` **and** an
   nvim plugin spec) plus a `~/.config/herdr/config.toml` keybind block — none of this
   is automatic out of the box.
3. Before finishing `ai_assisted/proposals/herdr_sidekick_backend.claude.lua` (the
   sidekick session-backend draft), it's worth reading `ctbaum/herdr-agents.nvim` — it
   may already implement that exact idea.
4. None of this was applied — this file is a survey only, per the review-first
   workflow. Next step, if any of these look right, is a `proposals/` entry wiring the
   chosen plugin(s) into `lazy.nvim` + a `herdr plugin install` step, for review.
