docker rmi $(docker images)
docker build -t server .
docker run -it --rm -p 80:80 -p 23:23 server
