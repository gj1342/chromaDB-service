FROM chromadb/chroma:latest

EXPOSE 8000

ENV IS_PERSISTENT=TRUE
ENV PERSIST_DIRECTORY=/data
ENV ANONYMIZED_TELEMETRY=TRUE

RUN mkdir -p /data && chmod 755 /data

ENTRYPOINT []
CMD chroma run --host 0.0.0.0 --port ${PORT:-8000} --path ${PERSIST_DIRECTORY:-/data}
