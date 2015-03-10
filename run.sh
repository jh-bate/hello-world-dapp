export HASH=$(ipfs add -recursive -quiet src | tail -n -1)

docker rm hello-world

docker run --name=hello-world --detach --env HASH --env VCAP_APP_PORT=3000 \
  --publish 3000:3000 \
  --volume /home eris/decerver2
