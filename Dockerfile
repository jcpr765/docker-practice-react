# FIRST PHASE - for building the web app
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
# Dependencies are only needed to execute npm run build
RUN npm install
COPY . .
RUN npm run build

# FINAL PHASE - for serving the app on an nginx web server
FROM nginx
# --from=builder to denote we;re copying form the previous phase. Copying to /usr/share/nginx/html per nginx config for sharing simple content
COPY --from=builder /app/build /usr/share/nginx/html
# We have not specified a CMD because the nginx image default starts up nginx automatically