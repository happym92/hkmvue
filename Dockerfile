# base image (npm을 갖고 있는 baseimage 중 하나)
FROM node:16 as builder

# Working Directory 지정
WORKDIR /app

COPY package.json ./


# node의 종속성 다운로드
RUN npm install
COPY . .
RUN npm run build

#production stage
FROM nginx
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]