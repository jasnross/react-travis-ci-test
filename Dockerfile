FROM node:alpine as builder
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY src/ ./src
COPY public ./public
COPY tsconfig.json ./
RUN yarn run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html