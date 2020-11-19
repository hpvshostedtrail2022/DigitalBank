#FROM soltest4hpvsop/hpvsop-base2:1.2.2-release-cedc95a
#FROM soltest4hpvsop/hpvsop-base-ssh2:1.2.2-release-cedc95a
FROM soltest4hpvsop/hpvsop-base2:1.2.2.1-release-2fe5052
#FROM us.icr.io/hpvs121/hpvsop-base:1.2.2-release-cedc95a

COPY --chown=root:root config/iptables.conf /etc/iptables/
COPY start.sh /root/start.sh

RUN apt-get update && \
    apt-get install -y \
    gnupg \
    wget && \ 
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    mkdir -p /etc/apt/sources.list.d && \
    #touch /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    echo "deb [ arch=s390x,s390x ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \    
    apt-get update && \
    ln -s /bin/true /usr/local/bin/systemctl && \
    apt-get install -y -q \
    mongodb-org-server \
    mongodb-org-shell \
    mongodb-org-mongos \
    mongodb-org-tools \
    mongodb-org && \
    /usr/local/bin/systemctl enable mongod && \
    chmod +x /root/start.sh && \
    rm -f /usr/local/bin/systemctl

COPY config/mongod.conf /etc/mongod.conf

#ENTRYPOINT ["/usr/bin/mongod","-f","/etc/mongod.conf"]
ENTRYPOINT ["/root/start.sh"] 
#ENTRYPOINT ["/sbin/init"]
#CMD ["/bin/bash"]
