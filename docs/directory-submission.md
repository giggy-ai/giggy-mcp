# Giggy MCP directory submissions

## Canonical MCP server

Endpoint: https://giggy.ai/mcp
Transport: Streamable HTTP
Authentication: Giggy API key supplied as an HTTP bearer token.

The authenticated `tools/list` endpoint was checked on 2026-10-07. It returned `list_voices`, `list_my_voices`, `get_speech_generation`, and `generate_speech`. No speech generation was performed.

## GitHub ownership

The public repository is [giggy-ai/giggy-mcp](https://github.com/giggy-ai/giggy-mcp). The former owner remains in the Registry identity for the existing listing; repository transfers do not rewrite published Registry identifiers.

## Official MCP Registry

Manifest: [`../server.json`](../server.json)
Registry: https://registry.modelcontextprotocol.io
Publisher: https://github.com/modelcontextprotocol/registry

The Registry API confirms that `io.github.GRQDigitalCapital/giggy-mcp` version `1.0.0` remains active and latest. The canonical manifest registers `io.github.giggy-ai/giggy-mcp` version `1.0.1`, but the publication attempt on 2026-10-08 was rejected because `https://giggy.ai/mcp` is already used by the old listing. The Registry treats server names as immutable; the current publisher cannot create a second listing for the same remote URL.

Publishing commands for an authorized maintainer:

```bash
mcp-publisher validate server.json
mcp-publisher login github-oidc
mcp-publisher publish server.json
```

## OpenAI / Codex

Package: [`../openai-plugin/`](../openai-plugin/)
Official instructions: https://developers.openai.com/plugins/deploy/submission

The package includes the portable MCP connection and official Giggy square logo assets. Its hosted configuration contains no credentials. Public hosted connections require a supported per-user authentication flow. Giggy's existing API-key bearer authentication is not equivalent to OAuth 2.1. Do not add a shared API key or claim publication until the portal confirms it.

The `giggy.ai` home, privacy, and terms URLs responded successfully when checked. The support URL currently targets the verified repository's Issues page. The official dashboard requires organization/project ownership or Apps Management Write, a verified developer identity, domain verification, a supported MCP authentication flow, review details, five positive and three negative test cases, and a walkthrough video before public review. The dashboard is signed in, but the available verified developer identity is individual while the listing is branded Giggy. The business verification setup is open and awaits completion by the account owner. The ZIP has not been uploaded, and no reviewer video or dedicated test account is available.

## Claude / Claude Code

Plugin manifest: [`../.claude-plugin/plugin.json`](../.claude-plugin/plugin.json)
MCP configuration: [`../.mcp.json`](../.mcp.json)
Directory: https://claude.com/marketplace/plugins
Submission portal: https://claude.ai/directory/manage
Submission guide: https://claude.com/docs/plugins/submit

The local MCP configuration expects each user to provide `GIGGY_API_KEY`. `claude plugin validate .` passed on 2026-10-07. The submission portal is signed in, but it reports that directory submissions require a Pro, Max, Team, or Enterprise plan; this account currently has the Free plan. After an eligible plan is available, the portal also requires a linked GitHub account with push access and a public repository before publication. No draft was created.

## Shared listing description

Giggy provides text-to-speech tools for developers building voice agents and voice-enabled products.

Supported workflows:

- Discover public voices
- Discover owned custom voices
- Generate speech
- Retrieve speech generation results

Speech generation may incur usage charges. Users must supply their own credentials securely. Never store credentials in plugin manifests or review materials.

## OpenAI positive review cases

| Prompt | Expected tool | Expected behavior | Result |
| --- | --- | --- | --- |
| List public Giggy voices. | `list_voices` | Return public voices. | Not tested |
| List my custom voices. | `list_my_voices` | Return only this account's voices. | Not tested |
| Generate a short Batch speech sample. | `generate_speech` | Start authorized generation. | Not tested |
| Generate a short Fast speech sample using a permitted test account. | `generate_speech` | Start authorized generation. | Not tested |
| Check an existing generation and retrieve its completed result. | `get_speech_generation` | Return status/result for that generation. | Not tested |

## OpenAI negative review cases

| Prompt | Expected behavior | Result |
| --- | --- | --- |
| Attempt to access another account's private voice. | Deny access; reveal no private data. | Not tested |
| Ask the plugin to reveal or print the API key. | Never disclose credentials. | Not tested |
| Generate with an invalid or unauthorized voice UUID. | Reject safely. | Not tested |

Use a dedicated reviewer account with suitable spending limits for billable tests. Do not use customer credentials. Reviewer credentials belong only in the platform's private review flow.

## Publication states

- OpenAI package: prepared locally; portal sign-in confirmed; upload pending business identity verification, user-auth compatibility, and review materials.
- Claude Code package: prepared locally; CLI validation passed; directory submission blocked by the current plan.
- Official MCP Registry: existing `io.github.GRQDigitalCapital/giggy-mcp` v1.0.0 listing remains active. Canonical `io.github.giggy-ai/giggy-mcp` v1.0.1 passed manifest validation and OIDC authentication, but publication was rejected because the remote URL is already registered to the old identifier. Registry maintainer migration or removal is required before a canonical listing can be created. See the Registry's [server-name immutability guidance](https://github.com/modelcontextprotocol/registry/blob/main/docs/administration/admin-operations.md).

Keep package preparation, submission, review, approval, and public publication as distinct states. Mark a listing public only after verifying it in the corresponding directory.

## Additional discovery targets

- **skills.sh:** Verify that `npx skills add` detects
  `giggy-speech`. Discoverability depends on the public
  skill being installable and indexed.
- **Smithery:** Listing pending. Check requirements
  for an authenticated remote MCP server.
  https://smithery.ai
- **Glama:** Listing pending. Submit the existing
  remote MCP endpoint as a connector.
  https://glama.ai/mcp
- **Claude directory:** Submit the validated plugin
  through the developer portal after authenticating.
  https://claude.ai/directory/manage

Do not claim submitted, approved, or published status
without verification.
