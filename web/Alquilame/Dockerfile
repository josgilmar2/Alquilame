FROM node:16.17.1-alpine as build-step
RUN mkdir -p /usr/local/app
WORKDIR /usr/local/app
COPY ./ /usr/local/app/
RUN npm install
RUN npm run build

FROM nginx:1.23.1-alpine
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build-step /usr/local/app/dist/alquilame /usr/share/nginx/html
EXPOSE 80
