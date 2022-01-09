#!/bin/bash

REGION="us-east-1"
SERVICE_NAME="wordfreq_service"
CLUSTER_NAME="wordfreq-cluster"

echo "WORDFREQ ECS SERVICE STATUS (CTRL + Z to stop)"
for (( ; ;))
do
  service_details=$(aws ecs describe-services --services $SERVICE_NAME --cluster $CLUSTER_NAME --region $REGION)
  cluster_details=$(aws ecs describe-clusters --clusters $CLUSTER_NAME --region $REGION)

  runningCount=$(echo $service_details | jq --arg servName $SERVICE_NAME '.services | .[] | select(.serviceName | contains($servName)) | .runningCount')
  pendingCount=$(echo $service_details | jq --arg servName $SERVICE_NAME '.services | .[] | select(.serviceName | contains($servName)) | .pendingCount')
  desiredCount=$(echo $service_details | jq --arg servName $SERVICE_NAME '.services | .[] | select(.serviceName | contains($servName)) | .desiredCount')
  registeredInstanceCount=$(echo $cluster_details | jq --arg clusName $CLUSTER_NAME '.clusters | .[] | select(.clusterName | contains($clusName)) | .registeredContainerInstancesCount')

  echo "Running count:" $runningCount "Desired Count:" $desiredCount "Pending Count:" $pendingCount "Cluster instance count:" $registeredInstanceCount

  sleep 5
done
