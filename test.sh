#!/bin/sh

docker build --tag=eris/test .
docker run -it -p 3000:3000 eris/test
