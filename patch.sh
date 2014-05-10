#!/bin/bash

curDir=`pwd`
TrunkRepo=$1
PatchRepo=$2
if [ -z $PatchRepo -o -z $TrunkRepo ]
then
  echo "Please pass parameter for Trunk and Patch directory, eg. trunkhosted OpenPetraPatchPlugin"
  exit 1
fi

cd $curDir/$TrunkRepo
for f in $curDir/$PatchRepo/patch/*; do patch -p1 < $f; done

cd $curDir/$PatchRepo/binary
for f in *
do
  path=`echo $f | sed "s#__#/#g"`
  echo "Patching " $path
  cp -f $f $curDir/$TrunkRepo/$path
done 

cd $curDir/$PatchRepo/delete
for f in *
do
  path=`echo $f | sed "s#__#/#g"`
  echo "Deleting " $path
  rm -f $curDir/$TrunkRepo/$path
done
