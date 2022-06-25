#!/bin/sh
# https://unix.stackexchange.com/questions/343942/shell-check-if-docker-container-is-existing
container=$(docker ps -q -f name=csapp-lab)

if [[ -z "$container" ]]; then
docker run -d -it \
	--name csapp-lab \
	-v "$(pwd)"/labs:/home/csapp \
	ubuntu 
echo "waiting 3s to enter the terminal..."

sleep 3

docker exec -it csapp-lab bash
else
echo "container existed"
docker exec -it csapp-lab bash
 
fi
