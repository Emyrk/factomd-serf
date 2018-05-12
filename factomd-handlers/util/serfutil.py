import os

def isFactomd():
	return os.environ.get('SERF_TAG_ROLE') == 'factomd'