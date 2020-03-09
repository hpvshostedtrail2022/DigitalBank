**NOTE:**

Update the Dockerfile before build the image.



```
  FROM <docker_username>/hpvsop-base:<image-tag>

  COPY files /

  RUN chmod +x /usr/local/nginx/start-nginx.sh

  #CMD ["/usr/local/nginx/start-nginx.sh"]
  ENTRYPOINT ["/usr/local/nginx/start-nginx.sh"]

```

At the first line:

- Update the `<docker_username>` with the **docker account**.
- Update the `<image_tag>` with the tag of image `hpvsop-base` in the specified docker account.

