#! /bin/bash

# use same credentials for git as for gitlab user

echo "precondition: create project 'hello-world-app' in gitlab"
echo "The default user is 'root' and the pw is shown above"

PROJECTNAME=hello-world-app
TARGETFOLDER=~/Development
TARGETPATH=$TARGETFOLDER/$PROJECTNAME
GITLAB_USER=root
GITLAB_PW=12345678

rm -fr $TARGETPATH

git clone http://$GITLAB_USER:$GITLAB_PW@localhost:10080/root/hello-world-app.git $TARGETPATH
git config user.name $GITLAB_USER #don't use --global!
git config credential.helper cache #caches password for 15 min

cp -r $PROJECTNAME $TARGETFOLDER
rm -fr $TARGETPATH/target
rm -fr $TARGETPATH/.settings
rm -fr $TARGETPATH/.classpath
rm -fr $TARGETPATH/.project

cd $TARGETPATH
git add .
git commit -m "inital commit"
git push -u origin master
