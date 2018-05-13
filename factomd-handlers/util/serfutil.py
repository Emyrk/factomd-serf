import os

def is_factomd():
	return os.environ.get('SERF_TAG_ROLE') == 'factomd'