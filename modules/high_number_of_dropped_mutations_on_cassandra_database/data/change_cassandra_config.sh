

#!/bin/bash



# Define the number of nodes and replication factor

CASSANDRA_NODES=${NUMBER_OF_NODES}

REPLICATION_FACTOR=${REPLICATION_FACTOR}



# Stop Cassandra service

sudo systemctl stop cassandra.service



# Update Cassandra configuration to increase the number of nodes

sudo sed -i "s/num_tokens: 256/num_tokens: ${CASSANDRA_NODES}/g" /etc/cassandra/cassandra.yaml



# Update Cassandra configuration to set the replication factor

sudo sed -i "s/replication_factor: 1/replication_factor: ${REPLICATION_FACTOR}/g" /etc/cassandra/cassandra.yaml



# Start Cassandra service

sudo systemctl start cassandra.service