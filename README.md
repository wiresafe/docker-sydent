# docker-sydent
Docker deployment of matrix-org/sydent identity server for matrix-org/synapse

## build docker image
```sh
$ docker build -t sydent .
```

## testing
```sh
$ docker run --name sydent -p 8090:8090 -d sydent

$ docker logs sydent

INFO:sydent.db.sqlitedb:Using DB file sydent.db
WARNING:__main__:You had not specified a server name. I have guessed that this server is called '358dbc92c4a3'  and saved this in the config file. If this is incorrect, you should edit server.name in the config file.
INFO:sydent.sign.ed25519:This server does not yet have an ed25519 signing key. Creating one and saving it in the config file.
INFO:sydent.sign.ed25519:Key saved
WARNING:sydent.http.httpcommon:No HTTPS private key / cert found: not starting replication server or doing replication pushes
INFO:sydent.http.httpserver:Starting Client API HTTP server on port 8090
INFO:twisted:Site starting on 8090
INFO:twisted:Starting factory <twisted.web.server.Site instance at 0x7ff80dc48f38>
Unhandled error in Deferred:
CRITICAL:twisted:Unhandled error in Deferred:

CRITICAL:twisted:
Traceback (most recent call last):
  File "/usr/local/lib/python2.7/site-packages/twisted/internet/defer.py", line 150, in maybeDeferred
    result = f(*args, **kw)
  File "/usr/local/lib/python2.7/site-packages/sydent/replication/pusher.py", line 76, in scheduledPush
    peers = self.peerStore.getAllPeers()
  File "/usr/local/lib/python2.7/site-packages/sydent/db/peers.py", line 52, in getAllPeers
    res = cur.execute("select p.name, p.port, p.lastSentVersion, pk.alg, pk.key from peers p, peer_pubkeys pk "
OperationalError: no such table: peers

```