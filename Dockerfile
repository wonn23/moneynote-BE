FROM node:20.10.0

ARG NODE_ENV
ARG JWT_ACCESS_TOKEN_SECRET
ARG JWT_ACCESS_TOKEN_EXPIRATION_TIME
ARG JWT_REFRESH_TOKEN_SECRET
ARG JWT_REFRESH_TOKEN_EXPIRATION_TIME
ARG GOOGLE_CLIENT_ID
ARG GOOGLE_CLIENT_SECRET 
ARG REDIS_HOST
ARG REDIS_PORT
ARG REDIS_PASSWORD

ENV NODE_ENV=${NODE_ENV}
ENV JWT_ACCESS_TOKEN_SECRET=${JWT_ACCESS_TOKEN_SECRET}
ENV JWT_ACCESS_TOKEN_EXPIRATION_TIME=${JWT_ACCESS_TOKEN_EXPIRATION_TIME}
ENV JWT_REFRESH_TOKEN_SECRET=${JWT_REFRESH_TOKEN_SECRET}
ENV JWT_REFRESH_TOKEN_EXPIRATION_TIME=${JWT_REFRESH_TOKEN_EXPIRATION_TIME}
ENV GOOGLE_CLIENT_ID=${GOOGLE_CLIENT_ID}
ENV GOOGLE_CLIENT_SECRET=${GOOGLE_CLIENT_SECRET}
ENV REDIS_HOST=${REDIS_HOST}
ENV REDIS_PORT=${REDIS_PORT}
ENV REDIS_PASSWORD=${REDIS_PASSWORD}

WORKDIR /app
COPY package.json ./
RUN npm install

COPY . .

RUN npm run build


RUN npm run test

RUN npm run test:e2e

EXPOSE 3000

CMD ["pm2-runtime", "start", "dist/main.js"]
