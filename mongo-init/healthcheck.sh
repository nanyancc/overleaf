#!/bin/bash
set -euo pipefail

# Healthy only after the single-node replica set is initialized and PRIMARY.
if mongosh --quiet --host localhost --eval 'quit(rs.status().ok === 1 ? 0 : 1)' >/dev/null 2>&1; then
  exit 0
fi

# On a fresh /data/db, Mongo starts without a replica-set config. Initialize it
# from the final mongod process, not from /docker-entrypoint-initdb.d, because
# the official entrypoint's temporary init mongod binds only to 127.0.0.1 and
# cannot validate member host "mongo:27017".
mongosh --quiet --host localhost --eval '
  try {
    rs.initiate({_id: "overleaf", members: [{_id: 0, host: "mongo:27017"}]})
  } catch (e) {
    if (!/already initialized|already been initialized/i.test(e.message)) {
      print(e.name + ": " + e.message)
    }
  }
' >/dev/null 2>&1 || true

# It can take a few seconds to elect PRIMARY; Docker will retry this healthcheck.
mongosh --quiet --host localhost --eval 'quit(rs.status().ok === 1 ? 0 : 1)' >/dev/null 2>&1
