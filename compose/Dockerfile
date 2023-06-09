FROM node:14-buster-slim
RUN apt-get update && \
    apt-get install -y git build-essential python pkg-config libssl-dev python3-pip && \
    apt-get clean
WORKDIR /edumeet
ENV DEBUG=edumeet*,mediasoup*
RUN npm install -g nodemon && \
    npm install -g concurrently

RUN touch /.yarnrc && mkdir -p /.yarn /.cache/yarn && chmod -R 775 /.yarn /.yarnrc /.cache

COPY dist /edumeet

CMD concurrently --names "server,app" \
    "node server.js" \
    "HTTPS=true PORT=4443 react-scripts start"