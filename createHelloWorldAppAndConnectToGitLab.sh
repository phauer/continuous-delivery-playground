#! /bin/bash

# use same credentials for git as for gitlab user

echo "precondition: create project 'hello-world-app' in gitlab"
echo "The default user is 'root' and the pw is shown above"

TARGETFOLDER=~/Development/
TARGETPATH=$TARGETFOLDER/hello-world-app

rm -rf $TARGETPATH

git clone http://localhost:10080/root/hello-world-app.git $TARGETPATH

unzip hello-world-app.zip -d $TARGETFOLDER	

cd $TARGETPATH
git add .
git commit -m "inital commit"
git push -u origin master
