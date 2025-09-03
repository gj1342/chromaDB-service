# ChromaDB Service

A containerized ChromaDB service for the D Knowledge Engine MERN stack application. This service provides a scalable vector database solution for storing and retrieving embeddings, enabling semantic search and AI-powered knowledge retrieval capabilities.

## Overview

ChromaDB is an open-source embedding database that allows you to:
- Store and query vector embeddings
- Perform semantic similarity searches
- Build AI-powered applications with RAG (Retrieval-Augmented Generation)
- Scale from prototype to production

## Architecture

This service is designed as a standalone microservice that can be:
- Run locally using Docker Compose
- Deployed to Railway for production use
- Integrated with other MERN stack components

## Prerequisites

- Docker and Docker Desktop (WSL2 backend on Windows)
- Railway CLI (for deployment)
- Port 8000 available (configurable)

## Quick Start

### Local Development

1. Clone the repository
```powershell
git clone <repository-url>
cd chromadb
```

2. Start the service
```powershell
docker compose up -d
```

3. Verify the service (v2 API)
```powershell
# Heartbeat
curl.exe http://localhost:8000/api/v2/heartbeat

# Create a collection
curl.exe -X POST "http://localhost:8000/api/v2/collections" \
  -H "Content-Type: application/json" \
  -d '{"name":"test"}'

# List collections
curl.exe "http://localhost:8000/api/v2/collections"
```
### Production Deployment (Railway)

1. Login and link
```powershell
railway login
railway link
```

2. Deploy (uses Dockerfile + railway.toml)
```powershell
railway up
```

3. Persistence (required)
- Create a Railway Volume and mount it to `/data` on the service.
- The service uses `IS_PERSISTENT=TRUE` and `PERSIST_DIRECTORY=/data`.

4. Verify
```powershell
# Replace with your Railway service URL
curl.exe https://<your-service>.railway.app/api/v2/heartbeat
```
## Configuration

### Environment Variables

- IS_PERSISTENT: TRUE (enable persistence)
- PERSIST_DIRECTORY: /data (persistence path inside container)
- PORT: 8000 (Railway injects this; default 8000 locally)
- ANONYMIZED_TELEMETRY: TRUE|FALSE (product telemetry)
- CHROMA_OTEL_COLLECTION_ENDPOINT: http://otel-collector:4317 (optional traces)
- CHROMA_OTEL_SERVICE_NAME: chroma (optional)
- CHROMA_OTEL_COLLECTION_HEADERS: authorization=Bearer <token> (optional)

### Ports
- Default: 8000 (mapped to host during local dev)
- Railway: uses injected `PORT`

## Monitoring and Logs

### Local
```powershell
docker compose logs -f chroma
docker stats
```

### Railway
```powershell
railway logs
railway status
```

## Troubleshooting

- Docker not running (Windows): start Docker Desktop and enable WSL2 backend.
- v1 API error: use `/api/v2/*` endpoints.
- Persistence missing on Railway: add a Volume and mount to `/data`.
- Port conflicts locally: change published port in `docker-compose.yml`.
