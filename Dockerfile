## Part A: Define the base operating system
FROM soltest4hpvsop/hpvsop-base-ssh2:1.2.2-release-cedc95a

## Part B Setup the environment with Libraries and set permissions to directories and 
## Adding dbadmin user and wcs user
RUN apt-get update && \
    apt-get install -y \
    curl \
    libaio1 \
    binutils \
    gcc \
    libstdc++6 && \
    groupadd -g 666 db2iadm1 && \
    groupadd -g 667 db2fsdm1 && \
    groupadd -g 668 dasadm1 && \
    useradd -u 1004 -g db2iadm1 -m -d /home/db2inst1 db2inst1 && \
    useradd -u 1003 -g db2fsdm1 -m -d /home/db2fenc1 db2fenc1 && \
    useradd -u 1002 -g dasadm1 -m -d /home/dasusr1 dasusr1

# Part C # Environment variables are needed by the base DB2 image 
# Specify a password for use db2inst1 

#ENV DB2INST1_PASSWORD passw0rd 
ENV PATH /SETUP/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin 
ENV LD_LIBRARY_PATH /home/db2inst1/sqllib/lib64:/home/db2inst1/sqllib/lib64/gskit:/home/db2inst1/sqllib/lib32 

# Part D 
COPY SETUP /SETUP/ 

# Part E, Extract, run the setup file, add license and delete the temporary files 
RUN mkdir -p /SETUP/tmp/DB2INSTALLER && \
    curl -o /SETUP/tmp/DB2INSTALLER/DB2INSTALLER.tar.gz http://9.46.66.119:10010/DB2S_11.5.4_LSZML.tar.gz && \
    tar -xzf /SETUP/tmp/DB2INSTALLER/DB2INSTALLER.tar.gz -C /SETUP/tmp/DB2INSTALLER/ && \
    /SETUP/tmp/DB2INSTALLER/server_dec/db2setup -r /SETUP/tmp/db2server.rsp && \
    chmod +x /SETUP/bin/* && \
    rm -r /SETUP/tmp


# Part F 
#Start the DB2 server and print out the diag log 
ENTRYPOINT ["/bin/bash","/SETUP/bin/entrypoint.sh" ] 
CMD [ "test","start" ] 

# Part G # DB2 instance port 
EXPOSE 50000 50001
