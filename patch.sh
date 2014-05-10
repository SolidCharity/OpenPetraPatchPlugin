#!/bin/bash

curDir=`pwd`
TrunkRepo=$1
PatchRepo=$2
if [ -z $PatchRepo -o -z $TrunkRepo ]
then
  echo "Please pass parameter for Trunk and Patch directory, eg. trunkhosted OpenPetraPatchSomething"
  exit 1
fi

cd $curDir/$TrunkRepo
for f in $curDir/$PatchRepo/patch/*; do patch -p1 < $f; done

if [ -d $curDir/$PatchRepo/binary ]
then
  cd $curDir/$PatchRepo/binary
  for f in *
  do
    if [[ "$f" != "*" ]]
    then
      path=`echo $f | sed "s#__#/#g"`
      echo "Patching " $path
      cp -f $f $curDir/$TrunkRepo/$path
    fi
  done 
fi

if [ -d $curDir/$PatchRepo/delete ]
then
  cd $curDir/$PatchRepo/delete
  for f in *
  do
    if [[ "$f" != "*" ]]
    then
      path=`echo $f | sed "s#__#/#g"`
      echo "Deleting " $path
      rm -f $curDir/$TrunkRepo/$path
    fi
  done
fi
