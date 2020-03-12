FROM hpvstest/hpvsop-base:latest

COPY files /
COPY data /data

RUN chmod +x /usr/local/nginx/start-nginx.sh

#CMD ["/usr/local/nginx/start-nginx.sh"]
ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]
