# Continuous Delivery Playground
My playground for setting up a continuous delivery pipeline with Docker.

- Jenkins
- GitLab
- Using a simple Dropwizard microservice as an example application
- Using a Docker image (containing the microservice) to create reproducible environments for all stages of the continuous delivery pipeline.

# Getting started
````bash
./1startGitLab.sh
````
Wait for startup. Open GitLab on  localhost:10080, login as root (password: 5iveL!fe), change password to 12345678 and create project 'hello-world-app'.

 ````bash
./2createHelloWorldAppAndCommitToGitLab.sh
````

 ````bash
./3startJenkins.sh
````
Configure Jenkins and Jenkins Job:
- Installations:
  - open Jenkins on http://localhost:8090/configure and install Maven and JDK if not already done.
  - Install the "GIT Plugin" on http://localhost:8090/pluginManager/available if not already done.
- Create Maven Job 'hello-world-app' and configure it as follows:
  - Getting the ip of the host machine: run 'ip route' on your host system to get the ip of the host machine. Look for the IP after the "src" keyword. You can try if you can access an URL within the jenkins container by using 'docker-exec-bash jenkins' (getting bash inside the container) and  then 'curl <url>'
  - Configure the git repository in the job: 'http://<IpOfHostMachine>:10080/root/hello-world-app.git'. Also configure your GitLab credentials here.
  - Build > Goals and options: verify
- Press 'Build Now'




