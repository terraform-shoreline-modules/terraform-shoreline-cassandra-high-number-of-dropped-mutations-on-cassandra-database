
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# High Number of Dropped Mutations on Cassandra Database
---

This incident type refers to a situation where a high number of mutations are being dropped on a Cassandra database. Mutations are changes made to the database, such as inserting new data or updating existing data. When mutations are dropped, it means that they were not successfully recorded in the database. This can be caused by a variety of factors, such as hardware or network issues, configuration problems, or bugs in the software. When this occurs, it can result in data inconsistencies or loss, and can impact the performance and reliability of the application that relies on the database.

### Parameters
```shell
export KEYSPACE_NAME="PLACEHOLDER"

export TABLE_NAME="PLACEHOLDER"

export COLUMN_NAME="PLACEHOLDER"

export VALUE="PLACEHOLDER"

export CONSISTENCY_LEVEL="PLACEHOLDER"

export NEW_NODE_COUNT="PLACEHOLDER"

export NEW_REPLICATION_FACTOR="PLACEHOLDER"

export CASSANDRA_CLUSTER="PLACEHOLDER"
```

## Debug

### Check the status of Cassandra service
```shell
systemctl status cassandra
```

### Check the Cassandra log for any errors or warnings
```shell
tail -n 100 /var/log/cassandra/system.log
```

### Check the number of dropped mutations
```shell
nodetool tpstats | grep Dropped
```

### Check the status of the Cassandra node
```shell
nodetool status
```

### Check the load on the Cassandra node
```shell
nodetool info | grep Load
```

### Check the disk space usage on the Cassandra node
```shell
df -h
```

### Check the network connectivity between the Cassandra nodes
```shell
nodetool describecluster
```

### Check the replication factor for the affected keyspace
```shell
cqlsh -e "describe keyspace ${KEYSPACE_NAME};"
```

### Check the consistency level of the affected queries
```shell
cqlsh -e "select * from ${TABLE_NAME} where ${COLUMN_NAME} = ${VALUE} consistency ${CONSISTENCY_LEVEL};"
```

## Repair

### Increase the number of Cassandra nodes to handle the increased load and ensure that there is proper replication factor to avoid any data loss.
```shell


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


```