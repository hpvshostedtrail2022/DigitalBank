The nginx config file is at: `/data/conf/nginx.conf`
The nginx sample UI pages are at: `/data/html`

Nginx will listen on port 8080 when it is setup. Make sure to map the port when run the image.

`docker run -dit image:tag -p <hostport>:8080`

**NOTE:**

Update the Dockerfile before build the image.



```
  FROM hpvstest/hpvsop-base:latest

  COPY files /

  RUN chmod +x /usr/local/nginx/start-nginx.sh

  #CMD ["/usr/local/nginx/start-nginx.sh"]
  ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]

```

At the first line:

- Update the `hpvstest` with your own **docker account** if needed.
- Update the `latest` with the specified tag of image `hpvsop-base` if needed..
~                                                                                                   
