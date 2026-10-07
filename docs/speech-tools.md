# Giggy MCP speech tools

This document covers the speech-related MCP tools exposed by Giggy.

The remote server is:

```text
https://giggy.ai/mcp
```

Authentication:

```text
Authorization: Bearer $GIGGY_API_KEY
```

## `list_voices`

List public Giggy voices.

### Arguments

```json
{
  "query": "optional search string",
  "language": "optional language",
  "limit": 10,
  "offset": 0
}
```

### Constraints

```text
query       optional
language    optional
limit       integer, 1 through 20
offset      integer, 0 or greater
```

Use the returned `voice_id` exactly when calling `generate_speech`.

---

## `list_my_voices`

List completed custom voices owned by the Personal space or Workspace associated with the authenticated Giggy API key.

### Arguments

```json
{
  "limit": 10,
  "offset": 0
}
```

### Constraints

```text
limit       integer, 1 through 20
offset      integer, 0 or greater
```

---

## `generate_speech`

Create a Giggy speech generation.

### Minimum arguments

```json
{
  "text": "Hello from Giggy.",
  "voice_id": "00000000-0000-0000-0000-000000000000"
}
```

### Full argument shape

```json
{
  "text": "Hello from Giggy.",
  "voice_id": "00000000-0000-0000-0000-000000000000",
  "speed": 1,
  "mode": "fast",
  "stream": true,
  "seed": 1234,
  "idempotency_key": "example-generation-1"
}
```

### Fields

`text`

Required Unicode text.

Current limits are mode-dependent.

Consult the live Speech API documentation for the exact current text bounds.

`voice_id`

Required Giggy voice UUID returned by `list_voices` or `list_my_voices`.

`speed`

Optional.

Range:

```text
0.25 through 4
```

`mode`

Optional.

Values:

```text
batch
fast
streaming
```

Default:

```text
fast
```

Current pricing semantics:

```text
batch       zero-credit Batch queue
fast        credit-backed
streaming   credit-backed
```

`stream`

Optional.

This is a Streaming-mode transport control.

Do not supply it with Batch or Fast mode.

`seed`

Optional.

Range:

```text
0 through 4294967295
```

`idempotency_key`

Optional but strongly recommended whenever the client may retry.

Generate a new value for a new intended synthesis.

Reuse the same value only when retrying that exact synthesis operation.

### Important result behavior

The MCP tool returns generation metadata.

It does not return live audio bytes.

Save:

```text
generation.generation_uuid
```

and poll the generation with `get_speech_generation`.

---

## `get_speech_generation`

Read durable generation state.

### Arguments

```json
{
  "generation_uuid": "00000000-0000-0000-0000-000000000000"
}
```

### Typical statuses

```text
queued
processing
completed
failed
```

While the generation is:

```text
queued
processing
```

poll this tool.

When:

```text
completed
```

use:

```text
generation.result.url
```

The result URL is temporary.

Do not start another generation merely because an existing generation is still processing.
