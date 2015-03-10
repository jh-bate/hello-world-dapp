# Decerver Tutorial

Eris decentralized applications are written in [Node.js](https://nodejs.org/) and built with the [Cloud Foundry Node.js buildpack](http://docs.cloudfoundry.org/buildpacks/node/).  You may want to read Cloud Foundry's [Tips for Node.js Applications](http://docs.cloudfoundry.org/buildpacks/node/node-tips.html). 

You need to use the `VCAP_APP_PORT` environment variable to determine which port your application should listen on:

    app.listen(process.env.VCAP_APP_PORT);

The source code directory for your application should be added first to [IPFS](http://ipfs.io/):

    ipfs add -recursive src
    
## Running Decerver

### Environment Variables

<table>
<tr><td>HASH</td><td>the IPFS hash of the source code directory</td></tr>
<tr><td>VCAP_APP_PORT</td><td>choose a non-system port</td></tr>
</table>
   
Example:

	export HASH=$(ipfs add -recursive -quiet src | tail -n -1)
	export VCAP_APP_PORT=3000

    docker run --name=hello-world --detach --env HASH --env VCAP_APP_PORT \
    	--publish 3000:$VCAP_APP_PORT eris/decerver
