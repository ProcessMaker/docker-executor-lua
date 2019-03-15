# Bring in from base debian docker image
FROM debian:9.5

ARG ROCKFILE
ENV ROCKFILE=$ROCKFILE

# Copy over our LUA libraries/runtime
COPY ./src /opt/executor

# Copy over our LUA SDK 
COPY $ROCKFILE /opt/executor/$ROCKFILE

# Set working directory to our /opt/executor location
WORKDIR /opt/executor

LABEL maintainer="taylor@processmaker.com"

# Update packages, then install lua
RUN apt-get update -qq && apt-get install -y lua5.3 luarocks liblua5.3-dev build-essential libssl-dev m4

RUN luarocks install dkjson
RUN luarocks install $ROCKFILE