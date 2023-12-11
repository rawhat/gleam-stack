FROM alpine@sha256:13b7e62e8df80264dbb747995705a986aa530415763a6c58f84a3ca8af9a5bcd as gleam

WORKDIR /opt/app

ADD https://github.com/gleam-lang/gleam/releases/download/v0.32.4/gleam-v0.32.4-x86_64-unknown-linux-musl.tar.gz gleam.tar.gz

RUN tar xfz gleam.tar.gz

FROM node@sha256:d016f19a31ac259d78dc870b4c78132cf9e52e89339ff319bdd9999912818f4a as client

WORKDIR /opt/app

ADD ./client/ ./
COPY --from=gleam /opt/app/gleam /usr/bin/

RUN npm install

RUN npx vite build

FROM erlang@sha256:da2c33176470f94c16198cb68f0f0c8a96e39e0ca2b3e3fa20674036c9658afd as server

WORKDIR /opt/app

ADD ./server/gleam.toml ./
ADD ./server/manifest.toml ./
ADD ./server/src ./src/
COPY --from=gleam /opt/app/gleam /usr/bin/

RUN gleam export erlang-shipment

FROM erlang@sha256:da2c33176470f94c16198cb68f0f0c8a96e39e0ca2b3e3fa20674036c9658afd

WORKDIR /opt/app

RUN mkdir priv

COPY --from=client /opt/app/dist/* ./priv/
COPY --from=server /opt/app/build/erlang-shipment/ ./

CMD ["./entrypoint.sh", "run"]
