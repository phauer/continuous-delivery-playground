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
