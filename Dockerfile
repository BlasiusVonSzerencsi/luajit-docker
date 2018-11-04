FROM alpine

ARG LUAJIT_VERSION=2.0.5
ARG LUAROCKS_VERSION=3.0.4

RUN apk update
RUN apk add build-base openssl unzip wget

RUN wget http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
RUN tar -xzvf LuaJIT-${LUAJIT_VERSION}.tar.gz
RUN cd LuaJIT-${LUAJIT_VERSION} && make && make install
RUN ln -s /usr/local/bin/luajit /usr/local/bin/lua

RUN wget http://luarocks.github.io/luarocks/releases/luarocks-${LUAROCKS_VERSION}.tar.gz
RUN tar -xzvf luarocks-${LUAROCKS_VERSION}.tar.gz
RUN cd luarocks-${LUAROCKS_VERSION} && ./configure --prefix=/usr/local && make && make install

ENV USER=root

RUN echo "#!/bin/sh" > /docker-entrypoint.sh
RUN luarocks path >> /docker-entrypoint.sh
RUN echo 'exec "$@"' >> /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
