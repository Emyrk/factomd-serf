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