FROM debian:bookworm-slim
WORKDIR /automation
RUN apt-get update && apt install procps curl -y --no-install-recommends procps curl && rm -rf /var/lib/apt/lists/* 
COPY . .
RUN chmod +x healthcheck.sh
CMD [ "bash", "healthcheck.sh" ]
