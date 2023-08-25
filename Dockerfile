FROM debian:11.7

RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list

# Update packages, then install lua
RUN apt-get update -qq
RUN apt-get install -y lua5.3 luarocks liblua5.3-dev build-essential libssl-dev m4 git

# Copy over our LUA libraries/runtime
COPY ./src /opt/executor

# Add dkjson package
WORKDIR /opt/executor
RUN luarocks install dkjson
