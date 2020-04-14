#FROM us.icr.io/solutiontest/hpvsop-base-ssh:1.2.0.1-develop-58d19c1
FROM docker.io/cjing19/hpvsop-base-ssh:1.2.0-release-86a8e01

COPY files /
#COPY data /data
RUN chown -R `id -u` /data
RUN chmod +x /usr/local/nginx/start-nginx.sh

#CMD ["/usr/local/nginx/start-nginx.sh"]
ENTRYPOINT [". /usr/local/nginx/start-nginx.sh"]
