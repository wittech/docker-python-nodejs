FROM python:bookworm
LABEL org.opencontainers.image.authors="Nikolai R Kristiansen <nikolaik@gmail.com>"

RUN groupadd --gid 1000 pn && useradd --uid 1000 --gid pn --shell /bin/bash --create-home pn
ENV POETRY_HOME=/usr/local
# Install node prereqs, nodejs and yarn
# Ref: https://deb.nodesource.com/setup_20.x
# Ref: https://yarnpkg.com/en/docs/install
RUN \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
  wget -qO- https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/yarnpkg.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
  wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/yarnpkg.gpg && \
  apt-get update && \
  apt-get upgrade -yqq && \
  apt-get install -yqq nodejs yarn && \
  pip install -U pip && pip install pipenv && \
  curl -sSL https://install.python-poetry.org | python - && \
  rm -rf /var/lib/apt/lists/*
