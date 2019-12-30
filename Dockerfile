FROM node:9.5
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install

ADD . /usr/src/app

HEALTHCHECK CMD curl --fail http://localhost:3000 || exit 1

CMD [ "node", "index.js" ]
