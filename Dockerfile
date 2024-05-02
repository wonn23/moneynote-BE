FROM node:alpine as development

# 환경변수 설정
ARG NODE_ENV
ARG PORT
ARG DB_HOSTNAME
ARG DB_PORT
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_DATABASE
ARG DB_SYNCHRONIZE
ARG REDIS_HOST
ARG REDIS_PORT
ARG REDIS_PASSWORD
ARG JWT_ACCESS_TOKEN_SECRET
ARG JWT_ACCESS_TOKEN_EXPIRATION_TIME
ARG JWT_REFRESH_TOKEN_SECRET
ARG JWT_REFRESH_TOKEN_EXPIRATION_TIME
ARG GOOGLE_CLIENT_ID
ARG GOOGLE_CLIENT_SECRET
ARG GOOGLE_CALLBACK_URL

ENV NODE_ENV=$NODE_ENV
ENV PORT=$PORT
ENV DB_HOSTNAME=$DB_HOSTNAME
ENV DB_PORT=$DB_USERNAME
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_DATABASE=$DB_DATABASE
ENV DB_SYNCHRONIZE=$DB_SYNCHRONIZE
ENV REDIS_HOST=$REDIS_HOST
ENV REDIS_PORT=$REDIS_PORT
ENV REDIS_PASSWORD=$REDIS_PASSWORD
ENV JWT_ACCESS_TOKEN_SECRET=$JWT_ACCESS_TOKEN_SECRET
ENV JWT_ACCESS_TOKEN_EXPIRATION_TIME=$JWT_ACCESS_TOKEN_EXPIRATION_TIME
ENV JWT_REFRESH_TOKEN_SECRET=$JWT_REFRESH_TOKEN_SECRET
ENV JWT_REFRESH_TOKEN_EXPIRATION_TIME=$JWT_REFRESH_TOKEN_EXPIRATION_TIME
ENV GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID
ENV GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET
ENV GOOGLE_CALLBACK_URL=$GOOGLE_CALLBACK_URL

WORKDIR /app

COPY package*.json ./

# rimraf를 글로벌로 설치
RUN npm install -g rimraf

# 모든 의존성 설치
RUN npm install

COPY . .

RUN npm run build

FROM node:alpine as production

WORKDIR /app

COPY --from=development /app/dist ./dist
COPY package*.json ./

RUN npm install --only=production

CMD ["node","dist/main"]
