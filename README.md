# AnyAPI docs

The documentation site for [AnyAPI](https://getanyapi.com) — *any API, one wallet,
USD, no subscriptions.* Built with [Mintlify](https://mintlify.com) and deployed
automatically on push to `main`.

## Structure

- `docs.json` — site config: theme, navigation, branding.
- `*.mdx` — content pages (`index`, `quickstart`, `mcp`).
- `openapi.json` — API reference spec, generated from the gateway registry (see
  `CLAUDE.md`).
- `logo/`, `favicon.svg`, `styles.css` — AnyAPI brand assets.

See `CLAUDE.md` / `AGENTS.md` for writing conventions and brand rules.

## Local preview

```bash
npm i -g mint
mint dev          # http://localhost:3000
```

## Publishing

Pushing to `main` deploys to production via the Mintlify GitHub app.
