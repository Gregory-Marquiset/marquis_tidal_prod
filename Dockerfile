# ---- Build stage ----
FROM node:20-bookworm AS build

RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*
RUN corepack enable

WORKDIR /app
RUN git clone --depth 1 https://codeberg.org/uzu/strudel.git .

RUN pnpm install
RUN pnpm prestart

RUN pnpm -C website build

# ---- Runtime stage ----
FROM nginx:alpine AS runtime

RUN printf '%s\n' \
'server {' \
'  listen 80;' \
'  server_name _;' \
'  root /usr/share/nginx/html;' \
'  index index.html;' \
'  location / {' \
'    try_files $uri $uri/ /index.html;' \
'  }' \
'}' > /etc/nginx/conf.d/default.conf

COPY --from=build /app/website/dist /usr/share/nginx/html

EXPOSE 80
