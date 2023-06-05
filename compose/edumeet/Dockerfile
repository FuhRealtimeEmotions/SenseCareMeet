FROM edumeetbase:latest



WORKDIR /
COPY ./app /app
COPY ./server /server
#WORKDIR /edumeet
ENV DEBUG=edumeet*,mediasoup*
CMD concurrently --names "server,app" \
    "cd server && yarn && yarn dev" \
    "cd app && yarn && yarn build && yarn start"
