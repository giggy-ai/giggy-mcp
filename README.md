# Giggy MCP — text-to-speech for AI agents

[![MCP Docs CI](https://github.com/GRQDigitalCapital/giggy-mcp/actions/workflows/ci.yml/badge.svg)](https://github.com/GRQDigitalCapital/giggy-mcp/actions/workflows/ci.yml)

Giggy MCP is a remote Streamable HTTP Model Context Protocol (MCP) server for using Giggy text-to-speech from coding agents and AI clients.

It provides Giggy speech tools to Codex, Claude Code, Cursor, VS Code, Cline, Windsurf-compatible clients, and other MCP clients.

## MCP registry and plugin directories

Giggy's remote speech MCP endpoint is:

`https://giggy.ai/mcp`

This repository contains the publication artifacts for:

- Official MCP Registry: [`server.json`](server.json)
- OpenAI / Codex: [`openai-plugin/`](openai-plugin/)
- Claude Code: [`.claude-plugin/plugin.json`](.claude-plugin/plugin.json)

See [directory submission status and requirements](docs/directory-submission.md).

A public registry listing, plugin submission, and approved plugin publication are separate steps. Consult the submission document for verified status.

## Quick setup

### Use Giggy MCP with Codex

Set `GIGGY_API_KEY` in your environment, then add to `~/.codex/config.toml`:

```toml
[mcp_servers.giggy-speech]
url = "https://giggy.ai/mcp"
bearer_token_env_var = "GIGGY_API_KEY"
```

### Use Giggy MCP with Claude Code

Set `GIGGY_API_KEY`, then configure:

```json
{
  "mcpServers": {
    "giggy-speech": {
      "type": "http",
      "url": "https://giggy.ai/mcp",
      "headers": { "Authorization": "Bearer ${GIGGY_API_KEY}" }
    }
  }
}
```

Keep API keys out of configuration files committed to source control.
## Remote MCP server

```text
https://giggy.ai/mcp
```

Transport:

```text
Streamable HTTP
```

The current Giggy MCP endpoint is stateless and accepts POST requests.

## Authentication

Use a Giggy API key:

```text
Authorization: Bearer $GIGGY_API_KEY
```

Giggy API keys begin with:

```text
giggy_sk_
```

Keep the key in your MCP client's secret or environment configuration.

Do not:

- put it in ordinary prompts
- commit it to source control
- embed it in browser JavaScript

## Speech tools

This repository documents these Giggy speech tools:

```text
list_voices
list_my_voices
generate_speech
get_speech_generation
```

The MCP server may expose other Giggy tools outside the speech scope of this repository.

## Recommended speech workflow

1. Call `list_voices` or `list_my_voices`.
2. Select the exact returned `voice_id`.
3. Call `generate_speech`.
4. Supply a fresh `idempotency_key` for each new intended generation.
5. Save `generation.generation_uuid`.
6. Call `get_speech_generation` while the status is `queued` or `processing`.
7. When the status becomes `completed`, use `generation.result.url`.

Do not resubmit a new generation while polling an existing generation.

## Use Giggy MCP with Codex

Set:

```bash
export GIGGY_API_KEY="giggy_sk_..."
```

Then add this to:

```text
~/.codex/config.toml
```

```toml
[mcp_servers.giggy-speech]
url = "https://giggy.ai/mcp"
bearer_token_env_var = "GIGGY_API_KEY"
```

A ready-to-copy version is included at:

```text
examples/codex-config.toml
```

Verify:

```bash
codex mcp list
```

## Use Giggy MCP with Claude Code

Set:

```bash
export GIGGY_API_KEY="giggy_sk_..."
```

A project MCP configuration is included at:

```text
examples/claude-code.mcp.json
```

Its contents are:

```json
{
  "mcpServers": {
    "giggy-speech": {
      "type": "http",
      "url": "https://giggy.ai/mcp",
      "headers": {
        "Authorization": "Bearer ${GIGGY_API_KEY}"
      }
    }
  }
}
```

Copy that configuration to:

```text
.mcp.json
```

in the project where Claude Code should use Giggy.

Then run:

```bash
claude mcp list
```

or use:

```text
/mcp
```

inside Claude Code.

## Other MCP clients

Ready-to-copy client configurations are included for:

| Client | Example |
| --- | --- |
| Codex | [examples/codex-config.toml](examples/codex-config.toml) |
| Claude Code | [examples/claude-code.mcp.json](examples/claude-code.mcp.json) |
| Cursor | [examples/cursor.mcp.json](examples/cursor.mcp.json) |
| VS Code | [examples/vscode.mcp.json](examples/vscode.mcp.json) |
| Cline | [examples/cline.mcp.json](examples/cline.mcp.json) |
| Windsurf-compatible clients | [examples/windsurf.mcp.json](examples/windsurf.mcp.json) |

### Cursor

Set:

```bash
export GIGGY_API_KEY="giggy_sk_..."
```

Copy or merge:

```text
examples/cursor.mcp.json
```

into:

```text
.cursor/mcp.json
```

for project configuration, or:

```text
~/.cursor/mcp.json
```

for global configuration.

### VS Code

Copy or merge:

```text
examples/vscode.mcp.json
```

into:

```text
.vscode/mcp.json
```

VS Code will prompt securely for the Giggy API key.

### Cline

Open Cline's MCP server configuration and copy the contents of:

```text
examples/cline.mcp.json
```

Replace:

```text
YOUR_GIGGY_API_KEY
```

in your local configuration only.

Do not commit the configured file.

### Windsurf-compatible clients

For installations that use:

```text
~/.codeium/windsurf/mcp_config.json
```

merge the contents of:

```text
examples/windsurf.mcp.json
```

and replace:

```text
YOUR_GIGGY_API_KEY
```

in the local configuration only.

## Raw MCP examples

Set:

```bash
export GIGGY_API_KEY="giggy_sk_..."
```

Initialize:

```bash
./examples/initialize.sh
```

List tools:

```bash
./examples/list-tools.sh
```

List public voices:

```bash
./examples/list-voices.sh
```

## Important behavior

`generate_speech` returns durable generation metadata.

It does not return live MP3 or PCM audio bytes through MCP.

For progressive PCM audio, use:

```text
POST https://giggy.ai/v1/text-to-speech
```

with:

```text
mode=streaming
output_format=pcm_24000
```

## Developer resources

Speech API documentation:

```text
https://giggy.ai/docs/speech-api
```

OpenAPI:

```text
https://giggy.ai/v1/openapi.json
```

Runnable examples:

```text
https://github.com/GRQDigitalCapital/giggy-examples
```

Pricing:

```text
https://giggy.ai/pricing
```


Official SDK and runnable examples:

- [Giggy JavaScript/TypeScript SDK](https://github.com/giggy-ai/giggy-js)
- [Giggy integration examples](https://github.com/GRQDigitalCapital/giggy-examples)
