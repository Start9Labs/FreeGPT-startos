FROM node:20-bullseye-slim as frontend

WORKDIR /usr/src/app
COPY ./freegpt/web/package.json ./freegpt/web/package-lock.json ./
RUN npm ci

COPY ./freegpt/web /usr/src/app/web/
WORKDIR /usr/src/app/web/
RUN npm run build

FROM ghcr.io/serge-chat/serge:main as final

COPY --from=frontend /usr/src/app/web/build /usr/src/app/api/static/
COPY ./freegpt/api /usr/src/app/api

ADD ./health.sh /usr/local/bin/health.sh
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/*.sh
