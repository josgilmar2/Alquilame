# Etapa de compilación
FROM node:16.17.1-alpine as build
WORKDIR /app
COPY . .
RUN npm ci && npm run build

# Etapa de producción
FROM nginx:alpine
COPY --from=build /app/dist/alquilame /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
