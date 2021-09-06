FROM elixir:slim AS app_builder

# Set environment variables for building the application
ENV MIX_ENV=prod \
    LANG=C.UTF-8

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y git build-essential bash make gcc curl
RUN curl -sL https://deb.nodesource.com/setup_16.x  | bash -
RUN apt-get -y install nodejs 

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Create the application build directory
RUN mkdir /app
WORKDIR /app

# Copy over all the necessary application files and directories
COPY config ./config
COPY lib ./lib
COPY priv ./priv
COPY assets ./assets
COPY mix.exs .
COPY mix.lock .

# Fetch the application dependencies and build the application
ENV DATABASE_URL= \
    SECRET_KEY_BASE=
RUN npm install --prefix ./assets
RUN mix deps.get
RUN mix deps.compile
RUN mix assets.deploy
RUN mix release

# ---- Application Stage ----
FROM debian:bullseye-slim AS app

ENV LANG=C.UTF-8

# Copy over the build artifact from the previous step and create a non root user
WORKDIR /app

RUN adduser --disabled-login -u 1000 app
COPY --from=app_builder --chown=app:app /app/_build/ .

COPY migrate_and_run.sh .
RUN chmod +x migrate_and_run.sh

ENV HOME=/app

ENTRYPOINT ./migrate_and_run.sh
