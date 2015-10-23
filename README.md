# Continuous Delivery Playground
My playground for setting up a continuous delivery pipeline with Docker.

- Jenkins
- GitLab
- Using a simple Dropwizard microservice as an example application
- Using a Docker image (containing the microservice) to create reproducible environments for all stages of the continuous delivery pipeline.

# Getting started
First of all, you need the IP of your host machine (like 192.168.35.217). Therefore, run 'ip route' on your host system to get the ip of the host machine. Look for the IP after the "src" keyword. You can test the IP by trying to ping the IP within a container by running 'docker-exec-bash <containerId>' (getting bash inside the container) and  then 'ping \<IpOfHostMachine\>'

## The Commit Stage

````bash
./1startGitLab.sh
````
Wait for startup.
Configure GitLab Project 
- Open GitLab on  localhost:10080, login as root (password: 5iveL!fe), change password to 12345678
- create project 'hello-world-app'.
- go to http://localhost:10080/root/hello-world-app/hooks and create a WebHook for Push Events with the URL http://\<IpOfHostMachine\>:8090/git/notifyCommit?url=http://\<IpOfHostMachine\>:10080/root/hello-world-app.git
- do the same for the project 'hello-world-app-acceptance' and 'hello-world-app-deployment'

````bash
./createProjectsAndCommitToGitLab.sh
````

````bash
./3startDockerRegistry.sh
````

Configure the docker daemon to use an unsecure connection for accessing our local docker registry.
- add " --insecure-registry \<IpOfHostMachine\>:5000" to the DOCKER_OPS in /etc/default/docker.

````bash
./4startJenkins.sh
````
Configure Jenkins and Jenkins Job:
- Installations:
  - open Jenkins on http://localhost:8090/configure and install Maven and JDK if not already done.
  - Install the "GIT Plugin" on http://localhost:8090/pluginManager/available if not already done.
- Create Maven Job 'hello-world-app' and configure it as follows:
  - Configure the git repository in the job: 'http://\<IpOfHostMachine\>:10080/root/hello-world-app.git'. Also configure your GitLab credentials here.
  - Build > Goals and options: "deploy -Ddocker.registry.name=\<IpOfHostMachine\>:5000/"
  - Build Triggers > Poll SCM check 
- Press 'Build Now'
  - After the build has finished, you should find the created image in your local docker registry. Verify this by calling http://localhost:5000/v2/_catalog in your browser or take a look into the ~/docker-registry-data folder. 

## Acceptance Test Stage

After the docker image has been created in the Commit Stage, we'll run acceptance tests against the docker image.
- First of all, install "Build Pipeline Plugin" in Jenkins. The plugin provides an overview over our dependent jobs and our continuous delivery pipeline.
- Create Job 'hello-world-app-acceptance' in Jenkins
	- Git URL: http://\<IpOfHostMachine\>:10080/root/hello-world-app-acceptance.git
	- Build > Goals and options: "verify -Ddocker.host.address=\<IpOfHostMachine\>"
	- Build Triggers > Poll SCM check 
	- *Build after other project are built*: hello-world-app
- Create Build Pipeline View and select "hello-world-app" as Start Project
	- Create View and select "Build Pipeline View"
	- Select Initial Job: "hello-world-app"
- Open created Build Pipeline View
	- Hit "Run" and you can see your project is going through the build pipeline consisting out of 2 stages. :-)

## Deployment Stage

Finally, we want to run our built and tested docker image.
- Create a Jenkins Job "hello-world-app-deployment" as a Freestyle project
- Git-URL: http://\<IpOfHostMachine\>:10080/root/hello-world-app-deployment.git
- Build after other projects are built: hello-world-app-acceptance
- Add build step: "Execute shell" and insert `./runDockerContainer.sh`

Voila, that's it! We successfully set up a simple continuous delivery pipeline. Every time we push a change to our hello-world-app git project, the application goes through the whole pipeline and is finally deployed in "production". This way we get feedback quickly, increase the reliability of our delivery process and reduce the risk of releasing (due to automation).



