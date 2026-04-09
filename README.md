# Docker Sandbox: Claude + Ollama

Sandboxed Claude Code with Ollama cloud model support. Runs Claude Code inside a Docker container with your local directory mounted, using Ollama's cloud models for inference.

## Build & Push

```bash
docker build -t joncanning/claude-ollama:latest --push .
```

## Run

```bash
./run "your prompt here"
```

### First-time setup

```bash
# Sign in to Ollama (persists across runs)
./run "ollama login"
```

### Environment

| Variable | Default | Description |
|---|---|---|
| `OLLAMA_MODEL` | `glm-5.1:cloud` | Model for `ollama launch` |
| `IMAGE` | `claude-ollama-alpine` | Docker image to use |
| `OLLAMA_DIR` | `~/.ollama-sandbox` | Persisted ollama identity + auth |
| `CLAUDE_DIR` | `~/.claude-sandbox` | Persisted claude config |

### How it works

- Mounts current directory as `/home/agent/workspace`
- Starts `ollama serve` in background, polls until ready, then launches Claude Code
- `IS_DEMO=1` skips Claude Code onboarding screens
- `--dangerously-skip-permissions --print` for unattended execution
- `~/.ollama-sandbox` and `~/.claude-sandbox` persist across runs