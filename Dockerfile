FROM ubuntu:24.04
EXPOSE 80
EXPOSE 443

ENV TERM=xterm
ENV TZ=Etc/UTC
ENV DEBIAN_FRONTEND=noninteractive
ENV HIDDIFY_DISABLE_UPDATE=true
ENV DOCKER_MODE=true
USER root
WORKDIR /opt/hiddify-manager/

COPY . .

# python-systemctl must be a real file in /usr/bin (a relative symlink from

RUN mkdir -p /etc/sudoers.d/ && \
    apt-get update && apt-get install -y --no-install-recommends python3 ca-certificates && \
    mkdir -p /opt/hiddify-manager/data && \
    bash ./scripts/common/hiddify_installer.sh docker --no-gui --no-log && \
    rm -rf /var/cache/apt/archives /var/lib/apt/lists/* && \
    echo "Defaults:hiddify-panel !requiretty" >/etc/sudoers.d/hiddify && \
    echo "hiddify-panel ALL=(root) NOPASSWD: /opt/hiddify-manager/scripts/common/commander.py" >>/etc/sudoers.d/hiddify && \
    chmod 440 /etc/sudoers.d/hiddify



ENTRYPOINT ["./scripts/docker-init.sh"]
