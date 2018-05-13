# Serf Controller Docker Engine

This repo is aimed to design a control plane using serf to control a docker container named "factomd"

## Directory Structure

```
factomd-serf/
├── confs/
│   └──  serf.json # Configuration for a serf node controlling a factomd docker
├── confs-no-factomd/
│   └──  serf.json # Configuration for a serf node NOT controlling a factomd docker
├── logs/
│   └── Various files serf actions leave for debugging
├── factomd-handlers
│   └── Various plays serf can use to control factomd
├── start_factomd.sh 		# Quickstart for starting serf for factomd
├── start_non-factomd.sh 	# Quickstart for starting serf, without controlling a factomd
└── router_factomd.sh 		# Used by serf to handle events and queries
```

# Serf Queries/Events

## Queries

### start-factomd

Will run `docker start factomd`

```
serf query start-factomd
```

### stop-factomd

Will run `docker stop factomd`

```
serf query stop-factomd
```

### ping

Simple ping/pong

```
serf query ping
```

### version

Will return the top git commit of the repo each serf node is running with.

```
serf query version
```

## Events

### git-pull

Will do a git pull on this repo to update serf query/event scripts

```
serf event git-pull
```

# Run Serf controller in docker

## DO NOT USE SERF IN A DOCKER


See `build.sh` and `run.sh` 