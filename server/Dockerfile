FROM erlang:26.1.1-slim

ENV GLEAM_VERSION 0.32.4

RUN apt update && apt install -y ca-certificates xz-utils

ADD https://github.com/gleam-lang/gleam/releases/download/v$GLEAM_VERSION/gleam-v$GLEAM_VERSION-x86_64-unknown-linux-musl.tar.gz gleam.tar.gz

RUN tar xvf gleam.tar.gz && chmod +x gleam && mv gleam /usr/bin/

ADD https://github.com/watchexec/watchexec/releases/download/v1.24.0/watchexec-1.24.0-x86_64-unknown-linux-musl.tar.xz watchexec.tar.gz

RUN tar xvf watchexec.tar.gz && chmod +x watchexec-1.24.0-x86_64-unknown-linux-musl/watchexec && mv watchexec-1.24.0-x86_64-unknown-linux-musl/watchexec /usr/bin/

RUN useradd builduser

USER builduser

WORKDIR /home/builduser

CMD ["watchexec", "-r", "gleam", "run"]
