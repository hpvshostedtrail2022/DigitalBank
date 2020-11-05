FROM soltest4hpvsop/hpvsop-base-ssh2:1.2.2-release-cedc95a

RUN apt-get install -y nodejs npm

WORKDIR /app
# Install app dependencies
COPY . /app
RUN cd /app; npm install; npm prune --production
ENV NODE_ENV production
ENV PORT 3400

EXPOSE 3400
CMD [ "npm","start" ]
