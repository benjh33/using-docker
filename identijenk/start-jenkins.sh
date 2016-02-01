
docker run -d -p 8080:8080 -e DOCKER_PASS=$DOCKER_PASS --name jenkins -v /var/run/docker.sock:/var/run/docker.sock \
    --volumes-from jenkins-volume identijenk
