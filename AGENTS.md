# AnyAPI documentation agent instructions

This Mintlify repository is a customer-facing adapter in the AnyAPI ecosystem. The authoritative
wiring, contract invariants, impact classifier, repository gates, and rollout order live in the
main repository's [ECOSYSTEM.md](https://github.com/getanyapi-com/anyapi/blob/main/ECOSYSTEM.md).

Before changing discovery, catalog, search, pricing, schemas, MCP/OpenAPI/payment integration,
CLI/SDK guidance, skills, or related customer-facing copy:

1. Read `ECOSYSTEM.md` from the main repository.
2. Classify the change and create the impact ledger it requires.
3. Mark every ecosystem surface updated or unaffected with a concrete reason.
4. Follow the documented rollout order; do not infer it from this repository alone.

Do not duplicate discovery wire shapes or cross-repository topology here. This file owns only the
local Mintlify workflow and writing conventions. For Mintlify product knowledge, install its skill
with `npx skills add https://mintlify.com/docs`.

## About this project

- This is a documentation site built on [Mintlify](https://mintlify.com)
- Pages are MDX files with YAML frontmatter
- Configuration lives in `docs.json`
- Use the Mintlify MCP server, `https://mcp.mintlify.com`, to edit content and settings via MCP
- Use the Mintlify docs MCP server, `https://www.mintlify.com/docs/mcp`, to query information about using Mintlify via MCP

## Style preferences

- Use active voice and second person ("you")
- Keep sentences concise — one idea per sentence
- Use sentence case for headings
- Bold for UI elements: Click **Settings**
- Code formatting for file names, commands, paths, and code references

## Content boundaries

- Document only customer-visible AnyAPI behavior. Do not expose upstream provider identity or
  internal accounting details.
- Treat the generated OpenAPI snapshot as an adapter output. Update its source in the main
  repository and use the documented post-deploy sync workflow instead of hand-editing it.

## Local gate

Run `bash scripts/check-docs-nav.sh`, `mint validate --telemetry false`, and
`mint broken-links --telemetry false` before handing off customer-facing changes.
