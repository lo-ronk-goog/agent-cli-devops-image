FROM python:3.11-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:${PATH}"

# Install google-agents-cli as a global tool
RUN uv tool install google-agents-cli

# Pre-install common heavy dependencies to speed up downstream project runs
RUN pip install google-adk litellm

# Default command
CMD ["agents-cli", "--help"]
