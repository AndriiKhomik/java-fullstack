FROM node:14.5.0-alpine

WORKDIR /code
COPY package.json /code/package.json
COPY package-lock.json /code/package-lock.json

RUN npm ci
COPY . /code

CMD [ "npm", "start" ]