FROM  alpine:latest

RUN apk update && apk upgrade && apk add nginx supervisor

RUN mkdir /run/nginx
RUN echo -e "server {       \n\
    listen      80;         \n\
    listen      [::]:80;    \n\
    server_name localhost;  \n\
}" > /etc/nginx/http.d/default.conf

#supervisor
RUN echo -e "\
[supervisord]                                   \n\
nodaemon=true                                   \n\
[program:nginx]                                 \n\
command=nginx                                   \n\
autostart=true                                  \n\
autorestart=true                                \n\
startretries=1                                  \n\
stdout_logfile=/home/nginx.log                  \n\
stderr_logfile=/home/nginxerr.log               \n\
" > /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
