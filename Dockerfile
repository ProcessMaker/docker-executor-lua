FROM debian:9.5

# Update packages, then install lua
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list
RUN apt-get update -qq
RUN apt-get install -y lua5.3 luarocks liblua5.3-dev build-essential libssl-dev m4 git

# Copy over our LUA libraries/runtime
COPY ./src /opt/executor

# Add dkjson package
WORKDIR /opt/executor
RUN luarocks install dkjson
