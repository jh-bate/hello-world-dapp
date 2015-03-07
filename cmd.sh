#!/bin/sh

ipfs daemon &
sleep 10

# Get application source code from IPFS.
ipfs get --output=/home/node $HASH

cd /home/node
/opt/buildpack/bin/detect .
/opt/buildpack/bin/compile .
chown --recursive node: .

su node << EOSU
export PATH=/home/node/vendor/node/bin:$PATH

foreman start
EOSU
