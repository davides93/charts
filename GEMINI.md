# Copilot Instructions for Chatwoot Helm Charts

## Architecture Overview

This repository contains a Helm chart for [Chatwoot](https://chatwoot.com), an open-source customer engagement platform. The chart deploys a **two-tier Rails application**:

- **Web tier**: Rails server handling HTTP traffic (`templates/web-deployment.yaml`)
- **Worker tier**: Sidekiq background job processor (`templates/worker-deployment.yaml`)
- **Dependencies**: PostgreSQL (database) and Redis (cache/job queue) via Bitnami subcharts

## Key Design Patterns

### Template Structure
- **Shared configuration**: All environment variables centralized in `templates/env-secret.yaml`
- **Helper functions**: `templates/_helpers.tpl` contains reusable template functions for PostgreSQL/Redis connection logic
- **Conditional dependencies**: External vs internal PostgreSQL/Redis handled via `.Values.postgresql.enabled` and `.Values.redis.enabled`

### Configuration Strategy
```yaml
# Example: Use helper templates for dynamic resource names
{{- include "chatwoot.postgresql.host" . -}}  # Returns internal service name OR external host
{{- include "chatwoot.redis.url" . -}}        # Builds redis:// or rediss:// URL with auth
```

### Database Migration Pattern
- **Pre-deployment hook**: `templates/migrations-job.yaml` runs `rails db:migrate` before web/worker startup
- **Hook annotations**: Uses `helm.sh/hook: post-install,post-upgrade` with weight `-1` for ordering

## Development Workflows

### Local Testing
```bash
# Validate chart syntax
helm lint charts/chatwoot/

# Render templates locally (dry-run)
helm template chatwoot charts/chatwoot/ --values charts/chatwoot/values.yaml

# Test with external dependencies
helm template chatwoot charts/chatwoot/ --set postgresql.enabled=false,redis.enabled=false
```

### Chart Dependencies
```bash
# Update dependency locks (when modifying Chart.yaml dependencies)
helm dependency update charts/chatwoot/
```

## Configuration Conventions

### Environment Variables
- **Rails app config**: Set via `env.*` values (e.g., `env.RAILS_ENV: production`)
- **External services**: Use `postgresql.postgresqlHost` and `redis.host` when `*.enabled=false`
- **Secrets**: External secrets referenced via `postgresql.auth.existingSecret` and `redis.existingSecret`

### Scaling Patterns
```yaml
# Separate HPA for web and worker tiers
web.hpa.enabled: true      # Scale based on HTTP load
worker.hpa.enabled: true   # Scale based on job queue depth
```

### Resource Naming
- **Fullname template**: `{{ template "chatwoot.fullname" . }}-web` ensures unique names
- **Dependency services**: Use helper templates like `{{ template "chatwoot.postgresql.fullname" . }}`

## Critical Files for Changes

- **`values.yaml`**: Primary configuration interface - update parameter tables in README when modified
- **`templates/_helpers.tpl`**: Database/Redis connection logic - test both internal and external scenarios
- **`templates/env-secret.yaml`**: Environment variable injection - verify base64 encoding for new vars
- **`Chart.yaml`**: Dependency versions - run `helm dependency update` after changes

## External Dependencies

### Bitnami Charts
- **PostgreSQL**: Version pinned in `Chart.yaml` - check compatibility when upgrading Chatwoot image
- **Redis**: Configured for both standalone and sentinel modes via `env.REDIS_SENTINELS`

### Integration Points
- **Storage**: Supports local disk or S3 via `env.ACTIVE_STORAGE_SERVICE`
- **Email**: SMTP configuration for transactional emails and inbound email processing
- **Third-party**: Facebook, Slack, Twitter integrations via respective `env.*` variables

## Upgrading

Detailed instructions for upgrading between major versions are available in `charts/chatwoot/README.md`. Key points include:
- Backing up the PostgreSQL database before upgrading.
- Deleting and recreating the Helm release for some versions.
- Manually migrating data for some upgrades.

## Testing Scenarios

When modifying templates, test these configurations:
1. **Default setup**: Internal PostgreSQL + Redis
2. **External databases**: `postgresql.enabled=false, redis.enabled=false`
3. **TLS Redis**: `env.REDIS_TLS=true` with `rediss://` URLs
4. **Existing secrets**: Using `postgresql.auth.existingSecret`
