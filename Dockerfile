#build stage
FROM node as builder

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

#production stage
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]