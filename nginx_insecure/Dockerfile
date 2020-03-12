FROM hpvstest/hpvsop-base-ssh:1.2.0-release-86a8e01

COPY files /

RUN chmod +x /usr/local/nginx/start-nginx.sh

#CMD ["/usr/local/nginx/start-nginx.sh"]
ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]
