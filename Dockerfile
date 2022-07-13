#build stage
FROM node:16.16.0 as build-stage

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY . .
RUN rm -rf node_modules package-lock.json && npm install
RUN npm run build

#production stage
FROM nginx as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]