#!/bin/bash

set -e

mounts="${@}"

rm /etc/exports

for mnt in "${mounts[@]}"; do
  src=$(echo $mnt | awk -F':' '{ print $1 }')
  mkdir -p $src
  echo "$src *(rw,async,no_subtree_check,no_auth_nlm,no_root_squash,crossmnt,noac,fsid=0)" >> /etc/exports
done

cat <<'EOF' >/etc/services
nfs     2049/tcp    # Network File System
nfs     2049/udp    # Network File System
EOF

exec runsvdir /etc/sv
