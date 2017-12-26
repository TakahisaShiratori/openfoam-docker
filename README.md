# openfoam-docker-awsbatch

## overview
running OpenFoam job on AWS Batch

## description
by using these scripts and commands, you can run OpenFoam job on AWS Batch.
- building up base infrastructure and Docker build server for AWS Batch by CloudFormation
- CloudFormation will create...
  - VPC
  - Public Subnet
  - Security Group
  - Ubuntu16.6 (for Docker Build)
  - SpotFleet Role
  - AWS Batch Service Role
  - AWS Batch Job Role
  - Docker Container repo (ECR)
  - S3 Bucket

- after the base infrastructure become ready, build docker image and push it to AWS ECR.
- create job definition, compute environment and job queue for AWS Batch
- submit jobs to AWS Batch
- part of result data will be upload to S3 bucket which is created by CloudFormation

this docker image was verified with following version
ubuntu = 14.04
openfoam = 4.1
paraview = 5.0
awscli = 1.11.123


# Usage
1. login to aws console with admin
2. go to EC2
3. create a KeyPair
4. run CloudFormation for AWS Batch base infrastructure
5. login to bastion ubuntu server
6. run ubuntu setup script
7. build Docker images with the Dockerfile
8. push the images to AWS ECR
9. edit json files based on created AWS resources
10. create job definition on AWS Batch
11. create computing environment on AWS Batch
12. create job queue on AWS Batch
13. submit jobs

# See Also
## English
[Submitting OpenFOAM jobs to AWS Batch while sweeping its parameter](http://blog.serverworks.co.jp/tech/2017/11/27/aws-batch-openfoam-en/)
## 日本語
[AWS Batchにいろんな条件のOpenFOAMのジョブを投入する](http://blog.serverworks.co.jp/tech/2017/10/23/aws-batch-openfoam/)
