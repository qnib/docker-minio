# docker-minio
Docker image holding the minio object store (S3 compatible)


```
$ docker run -d -p 9000:9000 -v $/export/ -v ${HOME}/.minio:/root/.minio/ \
             -e "MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE" \
             -e "MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" \
             qnib/minio
$
```

## Service

```
$ docker service create --name minio -p 9000:9000 \
                      -e MINIO_ACCESS_KEY=AKIAIOSFODNN7EXAMPLE \
                      -e MINIO_SECRET_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY \
                      --mount type=bind,source=/var/minio/data/,target=/export/ \
                      --mount type=bind,source=/var/minio/config/,target=/root/.minio/ \
                      qnib/minio
$
```
