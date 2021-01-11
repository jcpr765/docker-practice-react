# FIRST PHASE - for building the web app
FROM node:alpine
WORKDIR '/app'
COPY package.json .
# Dependencies are only needed to execute npm run build
RUN npm install
COPY . .
RUN npm run build

# FINAL PHASE - for serving the app on an nginx web server
FROM nginx
# Usually meant as a note for developers. This instruction does nothing automatically, but AWS EBS will take this instruction and know what to map to
EXPOSE 80
# --from=builder to denote we;re copying form the previous phase. Copying to /usr/share/nginx/html per nginx config for sharing simple content
COPY --from=0 /app/build /usr/share/nginx/html
# We have not specified a CMD because the nginx image default starts up nginx automatically