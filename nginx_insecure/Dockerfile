FROM <docker_username>/hpvsop-base:<image-tag>

COPY files /

RUN chmod +x /usr/local/nginx/start-nginx.sh

#CMD ["/usr/local/nginx/start-nginx.sh"]
ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]