#! /bin/bash

# use same credentials for git as for gitlab user

echo "precondition: create project 'hello-world-app' in gitlab"
echo "The default user is 'root' and the pw is shown above"

PROJECTNAME=hello-world-app
TARGETFOLDER=~/Development
TARGETPATH=$TARGETFOLDER/$PROJECTNAME

rm -fr $TARGETPATH

git clone http://localhost:10080/root/hello-world-app.git $TARGETPATH

cp -r $PROJECTNAME $TARGETFOLDER
rm -fr $TARGETPATH/target
rm -fr $TARGETPATH/.settings
rm -fr $TARGETPATH/.classpath
rm -fr $TARGETPATH/.project

cd $TARGETPATH
git add .
git commit -m "inital commit"
git push -u origin master
