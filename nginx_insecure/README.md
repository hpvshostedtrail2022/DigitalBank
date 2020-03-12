The nginx config file is at: `/data/conf/nginx.conf`
The nginx sample UI pages are at: `/data/html`



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
