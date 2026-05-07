# Agent CLI DevOps Image

This repository maintains the shared Docker image used for running `agents-cli` operations in CI/CD pipelines.

## 🚀 Purpose

Building a Python environment with complex dependencies like `google-adk` and `litellm` on every CI run is slow. This repository creates a pre-baked image containing all the core tools, so that individual agent projects can run tests and evaluations instantly.

## 📦 What's Included

*   **Python 3.11-slim** (Base)
*   **uv** (Astral's fast Python package manager)
*   **agents-cli** (The Google Agents CLI tool)
*   **google-adk** & **litellm** (Pre-installed heavy dependencies)

## 🛠️ How to Use in Your Project

In your project's GitHub Actions workflow, instead of building the image on the fly, you can reference this image directly:

```yaml
jobs:
  test:
    runs-on: ubuntu-latest
    container:
      image: us-central1-docker.pkg.dev/YOUR_PROJECT_ID/YOUR_REGISTRY_NAME/agent-cli-runner:latest
      options: --rm
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
      
      - name: Run Evals
        env:
          GEMINI_API_KEY: ${{ secrets.GEMINI_API_KEY }}
        run: agents-cli eval run --evalset tests/eval/evalsets/basic.evalset.json
```

## 🔨 Building and Pushing

The included GitHub Actions workflow (`.github/workflows/push.yml`) is configured to build and push this image automatically when changes are pushed to `main` or when a version tag is created.

*Remember to update the registry placeholders in the workflow file with your actual GCP project details!*
