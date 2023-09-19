#build edumeet 
FROM node:16-bullseye-slim AS edumeet-builder

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    git \
    bash \
    jq \ 
    build-essential \
    python \
    python3-pip \
    openssl \
    libssl-dev \
    pkg-config && \
    apt-get clean

COPY app /edumeet/app
COPY server /edumeet/server

#install app dep
WORKDIR /edumeet/app
RUN yarn && yarn build
#RUN yarn install --production=false

#set and build app in producion mode/minified/.
# ENV NODE_ENV="production"
# ENV REACT_APP_DEBUG=""
# RUN yarn run build

#install server dep
WORKDIR /edumeet/server
RUN yarn && yarn build
#RUN yarn install --production=false && yarn run build

# create edumeet package 
RUN ["/bin/bash", "-c", "cat <<< $(jq '.bundleDependencies += .dependencies' package.json) > package.json" ]
RUN npm pack

# create edumeet image
FROM node:16-bullseye-slim

COPY --from=edumeet-builder /edumeet/server/edumeet-server*.tgz  /edumeet/server/

WORKDIR /edumeet/server

RUN tar xzf edumeet-server*.tgz && mv package/* ./ && rm -r package edumeet-server*.tgz

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -yq openssl && \
    apt-get clean

# Web PORTS
EXPOSE 80 443 
EXPOSE 40000-49999/udp

## run server 
ENV DEBUG ""

#COPY docker-entrypoint.sh /
ENTRYPOINT ["node", "/edumeet/server/dist/server.js"]
