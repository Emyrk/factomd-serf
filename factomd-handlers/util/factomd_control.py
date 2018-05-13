#!/usr/bin/env python
import subprocess
import os

import serfutil, dockerutil

def stop_factomd():
	factomd_do("stop")

def start_factomd():
	factomd_do("start")

def factomd_do(action):
	client = dockerutil.get_client()
	factomd_container = dockerutil.get_factomd_container(client)
	if action == "start":
		factomd_container.start()
	else if action == "stop":
		factomd_container.stop()
