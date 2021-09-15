#!/bin/bash
# This script is to create an AWS CodeDeploy deployment.
# Author: Jayden Aung

# UPDATE THE FOLLOWING VARIABLES ACCORDING TO YOUR ENV.
APPNAME="deom_app"
DCONFIG="CodeDeployDefault.AllAtOnce"
DGNAME="cd_dg1"
DESCRIPTION="Demo Deployment"
BUCKET="S3Bucket Name"
ETAG="ETAG's NAME"
BUNDLETYPE="zip"
KEY="demo_app.zip"
REGION="ap-southeast-1"

aws deploy create-deployment \
    --application-name ${APPNAME} \
    --deployment-config-name ${DCONFIG} \
    --deployment-group-name ${DGNAME} \
    --description ${DESCRIPTION} \
    --s3-location bucket=${BUCKET},bundleType=${BUNDLETYPE},eTag=${ETAG},key=${KEY} \
    --region ${REGION}