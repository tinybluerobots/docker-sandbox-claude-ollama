FROM alpine/ollama

# System deps (Wolfi uses apk with Chainguard repos)
USER root
RUN apk add --no-cache \
    nodejs-22 \
    npm \
    git \
    curl \
    ca-certificates \
    bash

# Install Claude Code CLI
RUN npm install -g @anthropic-ai/claude-code

# Create non-root agent user
RUN adduser -D -s /bin/bash agent && \
    mkdir -p /home/agent/.ollama && \
    chown -R agent:agent /home/agent/.ollama

USER agent
WORKDIR /home/agent

# Configurable via environment at runtime
ENV OLLAMA_MODEL=""

# Override ollama's default entrypoint to start server + shell
ENTRYPOINT ["sh", "-c"]
CMD ["ollama serve & disown; sleep 4; exec bash"]