FROM erlang:26.1.1-slim

ENV GLEAM_VERSION 0.32.4
ENV NODE_VERSION 20.10.0

RUN apt update && apt install -y ca-certificates xz-utils

ADD https://github.com/gleam-lang/gleam/releases/download/v$GLEAM_VERSION/gleam-v$GLEAM_VERSION-x86_64-unknown-linux-musl.tar.gz gleam.tar.gz

RUN tar xvf gleam.tar.gz && chmod +x gleam && mv gleam /usr/bin/

ADD https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz node.tar.xz

RUN mkdir -p /usr/local/lib/nodejs && tar xJvf node.tar.xz -C /usr/local/lib/nodejs

ENV PATH="/usr/local/lib/nodejs/node-v$NODE_VERSION-linux-x64/bin:$PATH"

RUN useradd builduser

USER builduser

WORKDIR /home/builduser

CMD ["npx", "vite", "dev", "--port", "4000", "--host", "0.0.0.0"]
