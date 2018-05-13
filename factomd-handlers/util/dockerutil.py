import docker

def get_client():
	client = docker.from_env()
	return client

def get_factomd_container(client):
	return client.containers.list(all=True, filters={'label': 'name=factomd'})[0]