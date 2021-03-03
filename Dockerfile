FROM  alpine:latest

RUN apk update && apk upgrade && apk add supervisor nginx

RUN mkdir /run/nginx
RUN echo -e "server {       \n\
    listen      80;         \n\
    listen      [::]:80;    \n\
    server_name localhost;  \n\
}" > /etc/nginx/http.d/default.conf


#supervisor
RUN echo -e "\
[supervisord]                           \n\
nodaemon=true                           \n\
[program:nginx]                         \n\
command=nginx -c /etc/nginx/nginx.conf  \n\
autostart=true                          \n\
autorestart=true                        \n\
startretries=5                          \n\
stdout_logfile=/home/nginx.log          \n\
stderr_logfile=/home/nginxerr.log       \n\
" > /etc/supervisord.conf

EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
