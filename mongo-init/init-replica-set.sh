#!/bin/bash
# MongoDB replica set initialization script
# Runs once on first startup when the data directory is empty

set -e

# Wait for mongo to be ready (localhost only, before replica set is configured)
until mongosh --quiet --host localhost --eval "db.adminCommand('ping')" >/dev/null 2>&1; do
    echo "Waiting for mongo to start..."
    sleep 1
done

# Check if replica set is already initialized
# Use --host localhost to avoid "MongoServerError: no replset config has been received"
RS_STATUS=$(mongosh --quiet --host localhost --eval "rs.status().ok" 2>/dev/null || echo "0")

if [ "$RS_STATUS" != "1" ]; then
    echo "Initializing replica set 'overleaf'..."
    mongosh --quiet --host localhost --eval '
        rs.initiate({
            _id: "overleaf",
            members: [{
                _id: 0,
                host: "mongo:27017"
            }]
        })
    '
    echo "Replica set initialized."
else
    echo "Replica set already initialized, skipping."
fi
