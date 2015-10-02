# Continuous Delivery Playground
My playground for setting up a continuous delivery pipeline with Docker.

- Jenkins
- GitLab
- Using a simple Dropwizard microservice as an example application
- Using a Docker image (containing the microservice) to create reproducible environments for all stages of the continuous delivery pipeline.

# Getting started
First of all, you need the IP of your host machine (like 192.168.35.217). Therefore, run 'ip route' on your host system to get the ip of the host machine. Look for the IP after the "src" keyword. You can test the IP by trying to access a URL within a container by running 'docker-exec-bash <containerId>' (getting bash inside the container) and  then 'ping \<IpOfHostMachine\>'

````bash
./1startGitLab.sh
````
Wait for startup.
Configure GitLab Project 
- Open GitLab on  localhost:10080, login as root (password: 5iveL!fe), change password to 12345678
- create project 'hello-world-app'.
- go to http://localhost:10080/root/hello-world-app/hooks and create a WebHook for Push Events with the URL http://\<IpOfHostMachine\>:8090/git/notifyCommit?url=http://\<IpOfHostMachine\>:10080/root/hello-world-app.git (for host IP see  below)

````bash
./2createHelloWorldAppAndCommitToGitLab.sh
````

````bash
./4startDockerRegistry.sh
````

````bash
./3startJenkins.sh
````
Configure Jenkins and Jenkins Job:
- Installations:
  - open Jenkins on http://localhost:8090/configure and install Maven and JDK if not already done.
  - Install the "GIT Plugin" on http://localhost:8090/pluginManager/available if not already done.
- Create Maven Job 'hello-world-app' and configure it as follows:
  - Configure the git repository in the job: 'http://\<IpOfHostMachine\>:10080/root/hello-world-app.git'. Also configure your GitLab credentials here.
  - Build > Goals and options: deploy -Ddocker.registry.name=http://\<IpOfHostMachine\>:5000/
  - Build Triggers > Poll SCM check 
- Press 'Build Now'

After a commit, Jenkins should build an image with the hello-world-app and pushed the image to your local docker registry. You should see the image when calling http://localhost:5000/v2/_catalog in your browser.
