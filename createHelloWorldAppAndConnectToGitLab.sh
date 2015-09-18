#! /bin/bash

# precondition: create project 'hello-world-app' in gitlab
# use same credentials for git as for gitlab user

TARGETFOLDER=~/Development/
TARGETPATH=$TARGETFOLDER/hello-world-app

rm -rf $TARGETPATH

git clone http://localhost:10080/root/hello-world-app.git $TARGETPATH

unzip hello-world-app.zip -d $TARGETFOLDER

cd $TARGETPATH
git add .
git commit -m "inital commit"
git push -u origin master
