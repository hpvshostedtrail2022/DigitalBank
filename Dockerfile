FROM soltest4hpvsop/hpvsop-base-ssh2:1.2.2-release-cedc95a

# Upgrade npm to latest version

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
ARG MONGO_CONN_STR mongodb://9.30.238.160:27017/test
#ENV SESSION_SECRET 5a4e0d2c6198976aaff66bc8
#ENV MONGO_USERNAME mongo
#ENV MONGO_PASSWORD mongo1234
#ENV MONGO_DB admin


EXPOSE 3100 3200 3400 3600 3800 4000 4100

ENTRYPOINT ["sh", "-c", "/app/entrypoint.sh $MONGO_CONN_STR"]
#CMD [ "${MONGO_CONN_STR}" ]
#CMD [ "npm","start" ]
