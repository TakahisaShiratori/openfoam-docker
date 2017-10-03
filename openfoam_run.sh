#!/bin/bash

# geting JOB ID, bucket name
BUCKETNAME="openfoam-batch-bucket"

# run OpenFoam4 with tutrial model "pitzDaily"
source /opt/openfoam4/etc/bashrc
source /root/.bashrc
export PATH=/root/.local/bin:$PATH

cd /root
mkdir -p $FOAM_RUN
cd $FOAM_RUN
cp -r $FOAM_TUTORIALS/incompressible/simpleFoam/pitzDaily .
cd pitzDaily
rm ./0/U
cp /root/U_template ./0/U
sed -i -e "s/\${xVelocity}/$1/g" 0/U
sed -i -e "s/\${yVelocity}/$2/g" 0/U
sed -i -e "s/\${zVelocity}/$3/g" 0/U
blockMesh
simpleFoam

# upload U to S3
TIMESTAMP=`date +%Y%m%d%H%M%S%N`
aws s3 cp ./ s3://$BUCKETNAME/$TIMESTAMP/ --recursive
