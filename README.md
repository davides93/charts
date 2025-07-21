# Chatwoot Helm Charts
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/artifact-hub)](https://artifacthub.io/packages/helm/chatwoot/chatwoot)

This repository contains helm charts for [Chatwoot](https://github.com/chatwoot/chatwoot).

## Installation

### Add the Helm Repository

```bash
helm repo add chatwoot https://davides93.github.io/chatwoot-charts
helm repo update
```

### Install Chatwoot

```bash
helm install chatwoot chatwoot/chatwoot
```

### Install with Custom Values

```bash
helm install chatwoot chatwoot/chatwoot -f my-values.yaml
```

## Available Charts

| Chart | Description | Version |
|-------|-------------|---------|
| [chatwoot](./charts/chatwoot/) | Open-source customer engagement suite | [![Chart Version](https://img.shields.io/badge/dynamic/yaml?url=https%3A//davides93.github.io/chatwoot-charts/index.yaml&query=%24.entries.chatwoot%5B0%5D.version&label=Chart%20Version)](https://davides93.github.io/chatwoot-charts/) |

## Configuration

Check the [README.md](./charts/chatwoot/README.md) for detailed configuration options.

## Using the Chart Repository

This repository publishes Helm charts to GitHub Pages at `https://davides93.github.io/chatwoot-charts`. 

The charts are automatically packaged and published when changes are pushed to the `main` branch. The index and chart packages are served from the `gh-pages` branch.

### Manual Chart Installation

If you prefer to install directly from releases:

```bash
# Download and install specific version
curl -L https://github.com/davides93/chatwoot-charts/releases/download/chatwoot-2.0.5/chatwoot-2.0.5.tgz -o chatwoot-2.0.5.tgz
helm install chatwoot ./chatwoot-2.0.5.tgz
```

## Development

### Testing Charts Locally

```bash
# Lint the chart
helm lint charts/chatwoot/

# Test rendering templates
helm template chatwoot charts/chatwoot/ --values charts/chatwoot/values.yaml

# Install locally for testing
helm install chatwoot-test charts/chatwoot/ --dry-run --debug
```

## Questions? Feedback?
[Join our discord server.](https://discord.gg/cJXdrwS)
