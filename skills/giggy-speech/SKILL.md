---
name: giggy-speech
description: Generate text-to-speech and transcribe recorded audio using authenticated Giggy MCP tools in Codex, Claude Code, or other AI agents.
---

# Giggy Speech

Use Giggy's existing MCP tools to generate audio from text or transcribe an authorised recording.

## When to use

Use this skill when the user requests speech synthesis,
narration, a voiceover, spoken audio from text, or recorded-audio transcription.

## Text-to-speech workflow

1. Check that Giggy MCP tools are available.
2. If not configured, direct the user to:
   https://github.com/giggy-ai/giggy-mcp
3. Call `list_voices` for public voices or
   `list_my_voices` for the user's custom voices.
4. Select an actual returned `voice_id`. Never invent one.
5. Call `generate_speech` using valid tool parameters.
6. Prefer Batch mode unless lower latency is required.
7. Use a fresh `idempotency_key` for each new generation.
8. Save `generation.generation_uuid`.
9. Poll `get_speech_generation` while queued or processing.
10. When completed, return `generation.result.url`.

Do not resubmit generation while polling.

## Recorded-transcription workflow

1. Check the connected server's `transcribe_audio` schema for supported inputs, modes and limits. Do not invent parameters or assume a local path is accessible to the remote server.
2. Prepare the user's authorised recording according to that schema. Explain paid usage before invoking a paid mode.
3. Call `transcribe_audio` once with a fresh idempotency key for the intended operation; retain the returned generation UUID.
4. Poll `get_speech_generation` for that UUID without resubmitting. Admission is not the final transcript.
5. After durable completion, retrieve the canonical transcript result using the returned result metadata. Do not fabricate transcript text or claim completion after an error.

MCP does not capture microphones or transport live PCM frames. For that workflow use the existing SDK guides at https://giggy.ai/docs/speech-api#api-developer-tools. Do not claim diarization, word timestamps, sentiment analysis or PII redaction from the current transcript contract.

## Rules

- Read the MCP tool schemas before invoking tools.
- Do not fabricate audio URLs or generation results.
- Keep API keys out of source code and prompts.
- Explain paid Fast or Streaming usage before invoking it.
- Do not use custom voices without authorization.
- Do not claim MCP returns live MP3 or PCM bytes.
- Use https://giggy.ai/pricing for current pricing.

## API

MCP endpoint: https://giggy.ai/mcp

Documentation: https://giggy.ai/docs/speech-api
