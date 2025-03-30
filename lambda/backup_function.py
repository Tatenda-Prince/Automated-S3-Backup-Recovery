import boto3
import os

s3 = boto3.client('s3')
sns = boto3.client('sns')

REPLICA_BUCKET = os.environ['REPLICA_BUCKET']
SNS_TOPIC_ARN = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    try:
        # Get the source bucket and file from the event
        source_bucket = event['Records'][0]['s3']['bucket']['name']
        file_key = event['Records'][0]['s3']['object']['key']
        
        # Copy the file to the replica bucket
        copy_source = {'Bucket': source_bucket, 'Key': file_key}
        s3.copy_object(CopySource=copy_source, Bucket=REPLICA_BUCKET, Key=file_key)
        
        print(f"Backup successful: {file_key}")
        return {
            'statusCode': 200,
            'body': f"Backup successful: {file_key}"
        }
        
    except Exception as e:
        print(f"Error backing up file: {str(e)}")
        
        # Log when SNS publish is attempted
        print(f"Publishing to SNS topic: {SNS_TOPIC_ARN}")
        
        # Publish to SNS on failure
        sns.publish(
            TopicArn=SNS_TOPIC_ARN,
            Message=f"Backup failed for file: {file_key}. Error: {str(e)}",
            Subject='Backup Failure Notification'
        )
        
        return {
            'statusCode': 500,
            'body': f"Backup failed: {str(e)}"
        }

