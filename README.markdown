# Prerequisites

* Get the source onto a machine that has docker installed, e.g. one of the CoreOS nodes. A Vagrant-shared folder worked fine for me, too.

* Alternatively, use boot2docker (especially on a Mac). In order to simplify running the commands, permanently export the URL of the remote (VM) docker host:

      export DOCKER_HOST=tcp://192.168.59.103:2375

# Building the initial image

1. Build the docker image

      $ sudo docker build -t nerab/hello-node .

1. Start the image in the foreground

      $ docker run -p 49160:8080 nerab/hello-node

1. Access the node app running in the container

      $ curl http://192.168.59.103:49160

  The IP address is the one of the $DOCKER_HOST, but using the port we mapped via the -p parameter above.

1. Stop the container and start it again in the background, which is what we will do in reality:

      $ docker run -p 49160:8080 -d nerab/hello-node

1. Push the container (I did it as a public container):

      $ docker push nerab/hello-node

# Running the container in production

* Log on to the docker-enabled production machine

* Try to run the image manually:

      $ docker run -p 49160:8080 --name hello-node nerab/hello-node

  Running with --name hello-node gives this image a local name, which we will refer to later on in the upstart job.

* Install the upstart job to run the container permanently by following https://docs.docker.com/articles/host_integration/

WATCH OUT! The article seems to have a bug in that it accidentially overwrites the `/etc/default/docker` file. I think it should append, instead:

      $ sh -c "echo 'DOCKER_OPTS=\"-r=false\"' >> /etc/default/docker"

* Start the container using upstart

      $ initctl start

* Check the log file

      $ tail -f /var/log/upstart/hello-node.log
