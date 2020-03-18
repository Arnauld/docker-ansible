FROM alpine:3.7

ARG ANSIBLE_VERSION="2.9.6"

# https://pkgs.alpinelinux.org/packages
RUN    apk upgrade --no-cache \
    && apk add --no-cache --update \
        curl \
        tar \
        bash \
        procps \
        zsh \
        git \
        ncurses \
        ca-certificates \
        openssl \
        openssh-client \
        python3 \
        rsync \
        sshpass \
        sudo \
    && apk add --no-cache --update --virtual \
        build-dependencies \
        python3-dev \
        libffi-dev \
        openssl-dev \
        build-base \
    && pip3 install --no-cache --upgrade pip cffi \
    && pip3 install --no-cache --upgrade setuptools ansible==${ANSIBLE_VERSION} \
    && apk del --no-cache --purge build-dependencies \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && mkdir -p /etc/ansible/ \
    && /bin/echo -e "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    && mkdir -p ~/.ssh \
    && echo "Host *" > ~/.ssh/config \
    && echo " StrictHostKeyChecking no" >> ~/.ssh/config \
    && touch ~/.ssh/known_hosts

# ZSH
ADD data/.zshrc /root/.zshrc

RUN bash -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
    && echo "export PROMPT=Docker$PROMPT" >> ~/.zshrc


CMD ["bash"]
