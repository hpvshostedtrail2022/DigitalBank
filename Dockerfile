#ARG DOCKER_ACCOUNT
#ARG TAG
#FROM ${DOCKER_ACCOUNT}/hpvsop-base:${TAG}

#FROM us.icr.io/solutiontest/hpvsop-base-ssh:1.2.0.1-develop-58d19c1
#FROM hpvsst/hpvsop-base-ssh:1.2.0.1-release-d45a706
#FROM cjing19/hpvsop-base-ssh2:1.2.1-release-d45a706
FROM soltest4hpvsop/hpvsop-base-ssh:1.2.1-release-d45a706
#FROM jiangmz/hpvsop-base:1.2.1-release-d45a706
#FROM cjing19/hpvsop-base-ssh15:1.2.0.1-release-d45a706

COPY files /
#COPY data /data
RUN chown -R `id -u` /data
COPY scripts/start-nginx.sh /usr/bin

RUN chmod +x /usr/bin/start-nginx.sh
#EXPOSE 443

ENTRYPOINT ["/usr/bin/start-nginx.sh"]

#CMD ["sh","/usr/local/nginx/start-nginx.sh"]
#CMD ["/usr/local/nginx/sbin/nginx","-c","/data/conf/nginx.conf"]
