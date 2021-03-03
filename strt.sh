docker rmi $(docker images -q)
docker build -t server .
docker run --rm -it -p 80:80 -p 23:23 -p 443 server
