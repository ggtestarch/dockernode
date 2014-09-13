# Building the initial image

1. Get the source onto a machine that has docker installed, e.g. one of the CoreOS nodes. A Varant-shared folder worked fine for me.

1. Build the docker container

      $ sudo docker build -t nerab/hello-node .

1. Push the container (I did it as a public container):

      $ docker push nerab/hello-node

1. Start the container in the background

      $ docker run -p 49160:8080 -d nerab/hello-node
