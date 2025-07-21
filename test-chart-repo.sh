#!/bin/bash
set -e

echo "Testing Chatwoot Helm Chart Repository"
echo "======================================"

# Test if the chart repository is accessible
echo "Testing chart repository accessibility..."
curl -f -s "https://davides93.github.io/chatwoot-charts/index.yaml" > /dev/null && echo "✓ Repository index.yaml is accessible" || echo "✗ Repository index.yaml is not accessible"

# Test adding the repository
echo "Testing helm repo add..."
helm repo add chatwoot-test https://davides93.github.io/chatwoot-charts 2>/dev/null && echo "✓ Repository can be added to Helm" || echo "✗ Repository cannot be added to Helm"

# Test updating repository
echo "Testing helm repo update..."
helm repo update chatwoot-test 2>/dev/null && echo "✓ Repository can be updated" || echo "✗ Repository cannot be updated"

# Test searching for charts
echo "Testing chart search..."
helm search repo chatwoot-test/chatwoot 2>/dev/null && echo "✓ Chart can be found in repository" || echo "✗ Chart cannot be found in repository"

# Test chart installation (dry-run)
echo "Testing chart installation (dry-run)..."
helm install chatwoot-test chatwoot-test/chatwoot --dry-run --debug > /dev/null 2>&1 && echo "✓ Chart can be installed" || echo "✗ Chart cannot be installed"

# Cleanup
helm repo remove chatwoot-test 2>/dev/null || true

echo "======================================"
echo "Test completed"