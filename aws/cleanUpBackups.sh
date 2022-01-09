#!/bin/bash

# Number of DynamoDB backups to retain
NUM_TO_RETAIN=3
REGION="us-east-1"
TABLE_NAME="wordfreq"

# ARNs for all backups in DynamoDB
backup_arns=$(aws dynamodb list-backups --table-name $TABLE_NAME --region $REGION)

# Get the count of backups
cur_num_backups=$(echo $backup_arns | jq '.BackupSummaries | length')

# Calculate number of backups to delete = Number of total backups - number to retain
num_to_del=$(($cur_num_backups-$NUM_TO_RETAIN))

echo "Number of backups in DynamoDB:" $cur_num_backups
echo "Number of backups to delete:" $num_to_del

# Delete oldest backups and retain only latest N number of backups
for (( i=0; i<$num_to_del; i++))
do
  arnToDel=$(echo $backup_arns | jq -r --argjson index $i '.BackupSummaries | .[$index] | .BackupArn') 
  echo "Deleting" $arnToDel
  result=$(aws dynamodb delete-backup --backup-arn $arnToDel --region $REGION)
  echo "Deleted" $arnToDel
done
