FROM soltest4hpvsop/hpvsop-base-ssh2:1.2.2-release-cedc95a

RUN apt-get install -y gnupg && \ 
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
    mkdir -p /etc/apt/sources.list.d && \
    #touch /etc/apt/sources.list.d/mongodb-org-3.4.list && \
    echo "deb [ arch=s390x,s390x ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \    
    apt-get update && \
    apt-get install -y mongodb-org 
   
ENTRYPOINT ["systemctl start mongod"]
 
