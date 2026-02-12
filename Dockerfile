FROM node:20-bookworm

RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*
RUN corepack enable

WORKDIR /app
RUN git clone --depth 1 https://codeberg.org/uzu/strudel.git .
RUN pnpm install
RUN pnpm prestart

EXPOSE 4321
CMD ["pnpm","-C","website","dev","--","--host","0.0.0.0","--port","4321"]
