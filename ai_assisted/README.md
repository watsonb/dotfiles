# ai_assisted/

AI-generated artifacts for this repository — proposals, research, and drafts produced
by coding assistants (Claude Code, Gemini CLI, etc.) for human review. Nothing in this
directory is live code: the repo owner reviews each artifact and integrates it into the
codebase manually.

## Layout

| Directory    | Contents                                                                            |
|--------------|-------------------------------------------------------------------------------------|
| `proposals/` | Changes intended for THIS repo: task/playbook YAML, diffs/patches, config snippets   |
| `research/`  | Reviews, analysis, comparisons, reference material                                   |
| `outbound/`  | Drafts destined outside this repo: GitHub issues, emails, tickets, wiki pages        |
| `archive/`   | Applied, rejected, or superseded artifacts kept for reference                        |

## Conventions (for humans and agents)

- **Naming**: `<topic_snake_case>.<tool>.<ext>` — e.g. `app_reg.gemini.yml`,
  `easy_auth_review.claude.md`. The tool suffix records authorship.
- **Frontmatter**: every `.md` file starts with:

  ```yaml
  ---
  tool: claude-code            # claude-code | gemini-cli | ...
  model: claude-fable-5        # if known
  date: 2026-06-11
  status: proposed             # draft | proposed | applied | rejected | superseded
  related: [tasks/app_reg.yml] # repo files this artifact concerns
  ---
  ```

  Non-markdown files (YAML, patches) carry the same fields in a leading `#` comment
  block. `status` is required for proposals; optional for research/outbound.
- **Lifecycle**: when a proposal is applied or rejected, update `status` and move the
  file to `archive/` — or simply delete it. This directory is tracked, so git history
  preserves everything; pruning `archive/` periodically is safe and encouraged.
- **No secrets.** This directory is committed. Resource names, client IDs, and object
  IDs are fine; passwords, keys, tokens, and connection strings are not.

## For agents

When asked to propose a code change in this repo, write the artifact here (usually
under `proposals/`) following the conventions above instead of editing tracked files,
unless the user explicitly asks for a direct edit.
