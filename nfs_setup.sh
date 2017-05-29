#!/bin/bash

PERMISSIONS_FILE=/docker-entrypoint/permissions.sh
MOUNT_OPTS=${MOUNT_OPTS:-rw,sync,no_subtree_check,fsid=0,no_root_squash}
NFS_CLIENTS=${NFS_CLIENTS:-*}

set -e

mounts="${@}"

rm /etc/exports

for mnt in "${mounts[@]}"; do
  src=$(echo ${mnt} | awk -F':' '{ print $1 }')
  mkdir -p ${src}
  echo "${src} ${NFS_CLIENTS}(${MOUNT_OPTS})" >> /etc/exports
done

cat <<'EOF' >/etc/services
nfs     2049/tcp    # Network File System
nfs     2049/udp    # Network File System
EOF

if [ -f "${PERMISSIONS_FILE}" ]; then
  /bin/sh ${PERMISSIONS_FILE}
fi

exec runsvdir /etc/sv
