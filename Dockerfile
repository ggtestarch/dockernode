# DOCKER-VERSION 0.3.4
FROM ubuntu

RUN apt-get update && apt-get install -y npm

# Bundle app source
COPY . /app

# Install app dependencies
RUN cd /app; npm install

EXPOSE 8080
CMD ["node", "/app/index.js"]
