FROM ghcr.io/start9labs/free-gpt:main

ADD ./health.sh /usr/local/bin/health.sh
ADD ./docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
RUN chmod a+x /usr/local/bin/*.sh
