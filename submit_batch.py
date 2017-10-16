# -*- coding: utf-8 -*-
import boto3
import time

QUEUE       = "openfoam-batch-queue"
JOBDEF      = "openfoam-batch-job"
REGION      = "us-west-2"
SHELLSCRIPT = "/root/openfoam_run.sh"

batch = boto3.client("batch", region_name=REGION)

xVelocityMin       = 1
xVelocityMax       = 20
xVelocityIncrement = 1

yVelocityMin       = 0
yVelocityMax       = 10
yVelocityIncrement = 2

zVelocityMin       = 0
zVelocityMax       = 10
zVelocityIncrement = 2

if __name__ == "__main__":
  ii = 1
  xVelocity = xVelocityMin
  while True:
    yVelocity = yVelocityMin
    while True:
      zVelocity = zVelocityMin
      while True:
        JOBNAME = "JOB_%05d"%ii
        COMMAND = [SHELLSCRIPT, "%f"%xVelocity, "%f"%yVelocity, "%f"%zVelocity]

        response = batch.submit_job(
          jobName=JOBNAME,
          jobQueue=QUEUE,
          jobDefinition=JOBDEF,
          containerOverrides={
            "command": COMMAND
          }
        )

        print("Submitted " + JOBNAME + " as " + response["jobId"])
        ii += 1
        # time.sleep(10)

        zVelocity += zVelocityIncrement
        if zVelocity > zVelocityMax:
          break

      yVelocity += yVelocityIncrement
      if yVelocity > yVelocityMax:
        break

    xVelocity += xVelocityIncrement
    if xVelocity > xVelocityMax:
      break

  print("All jobs have been submitted.")

