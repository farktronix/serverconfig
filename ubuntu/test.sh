#!/bin/bash

containerID=`docker run --rm -d -p 2222:22 \
            -v "$HOME/.ssh/id_rsa.pub":/root/.ssh/authorized_keys:ro \
            -v "$HOME/.ssh/id_rsa.pub":/etc/authorized_keys/alpine:ro \
           farktronix/ansible_dummy:latest-ubuntu`
ansible-playbook ./playbook.yml -i 127.0.0.1, -u ubuntu --ssh-extra-args "-p 2222" -K
echo "Alpine image is set up! Log in and test it with this command:"
echo "ssh -p 2222 ubuntu@localhost"
read -n 1 -p "Press any key to continue. The docker container will be destroyed." garbage
docker stop $containerID
