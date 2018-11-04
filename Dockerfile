FROM alpine

ARG LUAJIT_VERSION=2.0.5

RUN apk update
RUN apk add build-base wget

RUN wget http://luajit.org/download/LuaJIT-${LUAJIT_VERSION}.tar.gz
RUN tar -xzvf LuaJIT-${LUAJIT_VERSION}.tar.gz
RUN cd LuaJIT-${LUAJIT_VERSION} && make && make install
RUN ln -s /usr/local/bin/luajit /usr/local/bin/lua
