
docker run -d -p 8080:8080 --name jenkins -v /var/run/docker.sock:/var/run/docker.sock \
    --volumes-from jenkins-volume identijenk
