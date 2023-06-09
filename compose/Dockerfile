FROM node:14-buster-slim as builder
RUN apt-get update && \
    apt-get install -y git build-essential python pkg-config libssl-dev python3-pip && \
    apt-get clean

WORKDIR /edumeet
COPY ../app /edumeet/app

ENV DEBUG=edumeet*,mediasoup*

RUN npm install -g nodemon && \
    npm install -g concurrently

RUN touch /.yarnrc && mkdir -p /.yarn /.cache/yarn && chmod -R 775 /.yarn /.yarnrc /.cache

WORKDIR /edumeet/app
RUN yarn install --production && yarn build

FROM node:14-buster-slim

USER node

WORKDIR /edumeet

COPY --from=builder --chown=node /edumeet/app/node_modules ./node_modules
COPY --from=builder --chown=node /edumeet/app/dist ./dist
COPY --from=builder --chown=node /edumeet/dist/public ./public
COPY --from=builder --chown=node /edumeet/app/package.json .

CMD [ "yarn", "start" ]


#CMD concurrently --names "server,app" \
#    "node server.js" \
#    "NODE_ENV=production HTTPS=true PORT=4443 node_modules/react-scripts/bin/react-scripts.js start"