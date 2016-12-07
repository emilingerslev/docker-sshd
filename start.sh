#!/bin/bash
[[ -z "$GITHUB_USERS" ]] && { echo "Please set GITHUB_USERS environment variable" ; exit 1; }

mkdir -p /root/.ssh

for user in ${GITHUB_USERS//,/ }
do
  curl -s "https://github.com/$user.keys" >> /root/.ssh/authorized_keys
  rc=$?; if [[ $rc != 0 ]]; then echo "curl failed for $user"; exit $rc; fi
  echo "Pulled keys for $user"
done

/usr/sbin/sshd -D
