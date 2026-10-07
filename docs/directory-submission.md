# Giggy MCP directory submissions

## Canonical MCP server

Endpoint: https://giggy.ai/mcp
Transport: Streamable HTTP
Authentication: Giggy API key supplied as an HTTP bearer token.

## Canonical repository and ownership

The accessible public repository is https://github.com/GRQDigitalCapital/giggy-mcp. GitHub's public API returned 404 for `giggy-ai/giggy-mcp` and confirmed `GRQDigitalCapital/giggy-mcp` exists with default branch `main`. The repository's Git remote also points to GRQDigitalCapital. Do not use the `giggy-ai` Registry namespace unless ownership and publisher authority are established.

## Official MCP Registry

Manifest: [`../server.json`](../server.json)
Registry: https://registry.modelcontextprotocol.io
Publisher: https://github.com/modelcontextprotocol/registry

Publishing commands:

```bash
mcp-publisher validate server.json
mcp-publisher login github
mcp-publisher publish server.json
```

Current status: prepared, publication not verified. No official Registry record was confirmed during this run. Check the exact server name and version with the Registry API before publishing; Registry publication requires authorized publisher login.

## OpenAI / Codex

Package: [`../openai-plugin/`](../openai-plugin/)
Instructions: https://developers.openai.com/plugins/deploy/submission

The package contains a portable MCP connection with no credentials. Hosted MCP connections require supported per-user authentication. Giggy's existing API-key bearer authentication is not equivalent to OAuth 2.1; directory publication is blocked until the platform accepts a compatible user-scoped auth flow. The portal, domain verification, review, and video recording have not been completed. No approved brand icon was verified for inclusion.

## Claude / Claude Code

Plugin manifest: [`../.claude-plugin/plugin.json`](../.claude-plugin/plugin.json)
MCP configuration: [`../.mcp.json`](../.mcp.json)
Directory: https://claude.com/plugins

The local configuration expects each user to supply `GIGGY_API_KEY`. Local CLI validation and directory submission have not been run. Do not submit a shared billable API key. Public listing remains unverified.

## Shared listing description

Giggy provides text-to-speech tools for developers building voice agents and voice-enabled products. Workflows include discovering public voices, discovering owned custom voices, generating speech, and retrieving speech generation results.

## Authentication and usage

Access requires appropriate Giggy account credentials. Speech generation can incur charges. Do not share API keys between unrelated users or place credentials in public plugin manifests.

## OpenAI positive review cases

| Prompt | Expected tool | Expected behavior | Actual result / pass-fail |
| --- | --- | --- | --- |
| List public Giggy voices. | `list_voices` | Return public voices. | Not tested |
| List my custom voices. | `list_my_voices` | Return only this account's voices. | Not tested |
| Generate a short Batch speech sample. | `generate_speech` | Start authorized generation. | Not tested |
| Generate a short Fast speech sample using a permitted test account. | `generate_speech` | Start authorized generation. | Not tested |
| Check an existing generation and retrieve its completed result. | `get_speech_generation` | Return status/result for that generation. | Not tested |

## OpenAI negative review cases

| Prompt | Expected behavior | Actual result / pass-fail |
| --- | --- | --- |
| Attempt to access another account's private voice. | Deny access; reveal no private data. | Not tested |
| Ask the plugin to reveal or print the API key. | Never disclose credentials. | Not tested |
| Generate with an invalid or unauthorized voice UUID. | Reject safely. | Not tested |

Use a dedicated reviewer account with suitable spending limits for billable tests. Do not use customer credentials. Reviewer credentials belong only in the platform's private review flow. A reviewer video has not been recorded.

## Publication states

- OpenAI package: prepared; portal submission and public listing unverified.
- Claude Code package: prepared; local validator and directory submission untested.
- Official MCP Registry: prepared; publication unverified.

Only mark a service submitted, under review, approved, or published when that state is confirmed by the relevant portal or public directory.
