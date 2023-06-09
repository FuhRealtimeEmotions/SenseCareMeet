FROM node:14-buster-slim as base
RUN apt-get update && \
    apt-get install -y git build-essential python pkg-config libssl-dev python3-pip && \
    apt-get clean

RUN npm install -g nodemon && \
    npm install -g concurrently
RUN npm install -g typescript

RUN touch /.yarnrc && mkdir -p /.yarn /.cache/yarn && chmod -R 775 /.yarn /.yarnrc /.cache

FROM base as builder

WORKDIR /edumeet
COPY . .

ENV DEBUG=edumeet*,mediasoup*

RUN cd server && yarn && yarn build
RUN cd app && yarn && yarn build

#FROM node:14-buster-slim
#
#USER node
#
#WORKDIR /edumeet
#
#COPY --from=builder --chown=node /edumeet .
#COPY --from=builder --chown=node /edumeet/server/dist ./dist
#COPY --from=builder --chown=node /edumeet/server/dist/public ./public
#COPY --from=builder --chown=node /edumeet/app/package.json .
#
#CMD [ "yarn", "start" ]


CMD concurrently --names "server,app" \
    "cd server && yarn start" \
    "cd app && yarn start"