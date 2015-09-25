#! /bin/bash

PROJECTNAME=hello-world-app
TARGETFOLDER=~/Development
TARGETPATH=$TARGETFOLDER/$PROJECTNAME

cp -fr $PROJECTNAME $TARGETFOLDER
rm -fr $TARGETPATH/target
rm -fr $TARGETPATH/.settings
rm -fr $TARGETPATH/.classpath
rm -fr $TARGETPATH/.project

cd $TARGETPATH
git add .
git commit -m "update"
git push -u origin master

# the notification is done by a web hook definied in the giblab project with the line:
#http://192.168.35.82:8090/git/notifyCommit?url=http://192.168.35.82:10080/root/hello-world-app.git
# you can trigger is manually on the host running 'curl http://localhost:8090/git/notifyCommit?url=http://192.168.35.82:10080/root/hello-world-app.git'