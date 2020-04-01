FROM us.icr.io/solutiontest/hpvsop-base-ssh:1.2.0.1-develop-58d19c1

COPY files /
#COPY data /data

RUN chmod +x /usr/local/nginx/start-nginx.sh

#CMD ["/usr/local/nginx/start-nginx.sh"]
ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]
