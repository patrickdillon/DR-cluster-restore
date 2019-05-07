#!/bin/bash
set -x
RUNNING_ETCD_POD=$(crictl pods -q --label k8s-app=etcd --state=Ready)
RUNNING_ETCD_CONTAINER=$(crictl ps --pod ${RUNNING_ETCD_POD} --name etcd-member -q)
crictl exec ${RUNNING_ETCD_CONTAINER} /bin/sh -c 'source /run/etcd/environment && ETCDCTL_API=3 etcdctl --cert /etc/ssl/etcd/system:etcd-peer:${ETCD_DNS_NAME}.crt --key /etc/ssl/etcd/system:etcd-peer:${ETCD_DNS_NAME}.key --cacert /etc/ssl/etcd/ca.crt snapshot save /var/lib/etcd/snapshot.db'