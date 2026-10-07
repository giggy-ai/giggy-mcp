# Giggy MCP

Use Giggy text-to-speech from MCP-compatible coding agents and AI clients.

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

## Codex

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

## Claude Code

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
https://github.com/giggy-ai/giggy-examples
```

Pricing:

```text
https://giggy.ai/pricing
```
