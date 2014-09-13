# DOCKER-VERSION 0.3.4
FROM ubuntu

RUN apt-get update && apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get -y install nodejs

# Bundle app source
COPY . /app

# Install app dependencies
RUN cd /app; npm install

EXPOSE 8080
CMD ["node", "/app/index.js"]
