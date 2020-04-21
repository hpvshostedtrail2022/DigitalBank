#FROM us.icr.io/solutiontest/hpvsop-base-ssh:1.2.0.1-develop-58d19c1
#FROM hpvsst/hpvsop-base-ssh:1.2.0.1-release-d45a706
FROM cjing19/hpvsop-base-ssh1:1.2.0.1-develop-58d19c1
#FROM ubuntu:latest

COPY files /
#COPY data /data
RUN chown -R `id -u` /data
RUN chmod +x /usr/local/nginx/start-nginx.sh
EXPOSE 443

CMD ["sh","/usr/local/nginx/start-nginx.sh"]
#ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]
#CMD ["/usr/local/nginx/sbin/nginx","-c","/data/conf/nginx.conf"]
#CMD ["/bin/bash"]
