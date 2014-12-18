# dockernode

Simple node.js app, running in a Docker container on top of an Ubuntu Trusty Thar image. 
This project is based on [docker-node-hello](https://github.com/enokd/docker-node-hello/).

# Prerequisites

* Get the source into some place where docker is installed, e.g. a CoreOS node (a Vagrant-shared folder worked fine for me). Alternatively, use [boot2docker](https://github.com/steeve/boot2docker) (especially on a Mac).

* In order to simplify running the commands, permanently export the URL of the remote (VM) docker host:

        $ export DOCKER_HOST=tcp://192.168.59.103:2375

# Building and testing the image

1. Build the docker image

        $ sudo docker build -t nerab/hello-node .

1. Start the image in the foreground

        $ docker run -p 49160:8080 nerab/hello-node

1. Access the node app running in the container

        $ curl http://192.168.59.103:49160

  The IP address is the one of the `$DOCKER_HOST`, but using the port we mapped via the `-p` parameter above.

1. Stop the container and start it again in the background, which is what we will do in reality:

        $ docker run -p 49160:8080 -d nerab/hello-node

1. Push the container (I did it as a public container):

        $ docker push nerab/hello-node

# Running the container in production

* Log on to the docker-enabled production machine

* Try to run the image manually:

        $ docker run -p 49160:8080 --name hello-node nerab/hello-node

  Running with `--name hello-node` gives this image a local name, which we will refer to later on in the upstart job.

* Install the upstart job to run the container permanently by following https://docs.docker.com/articles/host_integration/

  WATCH OUT! The article seems to have a bug in that it accidentially overwrites the `/etc/default/docker` file. I think it should append, instead:

        $ sh -c "echo 'DOCKER_OPTS=\"-r=false\"' >> /etc/default/docker"

  There is [pull request 8023](https://github.com/docker/docker/pull/8023) to fix this.

* Start the container using upstart

        $ initctl start

* Check the log file

        $ tail -f /var/log/upstart/hello-node.log
