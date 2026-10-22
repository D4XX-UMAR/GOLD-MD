FROM node:20-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates git openssh-client ffmpeg \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package.json ./
RUN npm install bytenode@1.5.6 --omit=dev >/dev/null 2>&1

COPY index.jsc setup.jsc ./
RUN node -r bytenode setup.jsc

ENV PORT=11221
ENV SUPERVISOR_ENABLED=1
EXPOSE 11221
CMD ["node", "-r", "bytenode", "index.jsc"]
