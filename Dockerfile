# Pull official base image
FROM node:17.0 as build-deps
# A directory within the virtualized Docker environment
# Becomes more relevant when using Docker Compose later
WORKDIR /usr/src/app
# Copies package.json and package-lock.json to Docker environment
COPY package.json ./
# Installs all node packages
RUN yarn install
# Copies everything over to Docker environment
COPY . ./
# Installs all node packages
RUN yarn build
# the base image for this is an alpine based nginx image


FROM nginx:1.20-alpine
COPY --from=build-deps /usr/src/app/build /usr/share/nginx/html
RUN apk add python3 python3-dev py3-pip build-base libressl-dev musl-dev libffi-dev rust cargo
RUN pip3 install pip --upgrade
RUN pip3 install certbot-nginx
RUN mkdir /etc/letsencrypt
COPY default.conf /etc/nginx/conf.d/default.conf
