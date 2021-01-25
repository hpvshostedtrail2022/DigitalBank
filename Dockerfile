
# Upgrade npm to latest version
FROM hpvsdemo/hpvsbase:latest

RUN apt-get update && \
    apt-get install -y nodejs npm && \
    npm install -g yarnpkg && \
    yarn global add npm && \
    npm -v && \
    npm config set unsafe-perm=true

# Copy app & set working directory
WORKDIR /app
COPY . /app
COPY iptables.conf /etc/iptables/
RUN npm install; npm prune --production && \
    chmod +x /app/entrypoint.sh && \
    rm iptables.conf

ENV NODE_ENV production
ENV MONGO_CONN_STR mongodb://test:Passw0rd@129.40.15.19:27017/test
#ENV SESSION_SECRET 5a4e0d2c6198976aaff66bc8
#ENV MONGO_USERNAME mongo
#ENV MONGO_PASSWORD mongo1234
#ENV MONGO_DB admin


EXPOSE 3100 3200 3400 3600 3800 4000 4100

ENTRYPOINT ["/app/entrypoint.sh"]

#CMD ["/sbin/init"]
#ENTRYPOINT exec /app/entrypoint.sh $MONGO_CONN_STR
#ENTRYPOINT ["sh", "-c", "/app/entrypoint.sh $MONGO_CONN_STR"]
#CMD [ "${MONGO_CONN_STR}" ]
#CMD [ "npm","start" ]
