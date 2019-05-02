# Temporary container for building phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Final container that will be serving static content
FROM nginx
# Exposing the container to the world (used by Elastic Beanstalk)
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
