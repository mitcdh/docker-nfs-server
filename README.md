## Docker NFS Server

### Environment Variables

* `MOUNT_OPTS`: mount options to apply to all mounts
* `NFS_CLIENTS`: nfs client specification for all mounts

### Usage
```bash
docker run -d \
--name nfs \
--cap-add SYS_ADMIN \
-e MOUNT_OPTS='rw,async' \
-e NFS_CLIENTS='192.168.1.0/24' \
-v /local-path:/share1 \
mitcdh/nfs-server \
/share1
```

### Credits
* [cpuguy83/docker-nfs-server](https://github.com/cpuguy83/docker-nfs-server)
