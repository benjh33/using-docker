COMPOSE_ARGS=" -f jenkins.yml -p jenkins"
# remove old system if it exists for some reason
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm -f -v
# rebuild
sudo docker-compose $COMPOSE_ARGS build --no-cache
sudo docker-compose $COMPOSE_ARGS up -d
# start
sudo docker-compose $COMPOSE_ARGS run --no-deps --rm -e ENV=UNIT identidock
ERR=$
# run system tests if units passed
if [ $ERR -eq 0 ];then
    IP=$(sudo docker inspect -f {{ .NetworkSettings.IPAddress }} jenkins_identidock_1)
    CODE=$(curl -sL -w "%{http_code}" $IP:9090/monster/bla -o /dev/null) || true
    if [ $CODE -ne 200 ]; then
        echo "Site returned " $CODE
        ERR=1
    fi
fi
# destroy system
sudo docker-compose $COMPOSE_ARGS stop
sudo docker-compose $COMPOSE_ARGS rm -f -v
        
