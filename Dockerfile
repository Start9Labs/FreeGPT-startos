FROM ghcr.io/serge-chat/serge:main as main

ADD ./icon.png /usr/src/app/api/static/favicon.png
ADD ./health.sh /usr/local/bin/health.sh
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/*.sh
