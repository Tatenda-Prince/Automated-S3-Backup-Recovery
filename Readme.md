## Automated S3 Backup & Recovery Using Terraform

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/d19a37b74e1a3cb1a200b2b97e64541061d82ed9/screenshots/Screenshot%202025-03-29%20214616.png)


## Project Overview
Data loss due to accidental deletion, corruption, or system failure is a major concern for businesses. This project automates the backup and recovery of S3 data across AWS regions using Terraform. By implementing versioning, cross-region replication, and automated backup monitoring, this system ensures high availability, disaster recovery, and business continuity.

## Project Objective
The main objective of this project is to automate the backup and recovery process of S3 objects using Terraform by:

1.Enabling versioning on primary and backup S3 buckets.

2.Setting up cross-region replication for disaster recovery.

3.Automating backups using AWS Lambda and CloudWatch Events.

4.Sending notifications via SNS when backup failures occur.

5.Implementing IAM security best practices.

## Features
1.Fully automated backup & recovery system.

2.S3 Versioning enabled for data protection.

3.Cross-Region Replication for disaster recovery.

4.AWS Lambda function to copy files automatically.

5.CloudWatch monitoring to capture logs.

6.SNS notifications for backup failures.

7.Terraform IaC (Infrastructure as Code) for deployment automation.

## Technologies Used
1.Terraform – Infrastructure as Code (IaC)

2.AWS S3 – Cloud Storage for backups

3.AWS Lambda – Serverless computing for automation

4.AWS CloudWatch – Monitoring and logging

5.AWS SNS – Backup failure notifications

6.AWS IAM – Secure access management


## Use Case
You work at a Up The Chels start up as a the only Cloud Engineer you are tasked with automating a cloud backup for online application by ensuring that the data is secured for data retention and meets the compliance for backups


## Prerequisites
Before deploying this project, ensure you have: 1.AWS CLI installed & configured (`aws configure`) 
1.AWS account with Administrator Access.

2.Terraform installed (>= v1.0 recommended).

3.AWS CLI configured with credentials.

4.Basic knowledge of Terraform and AWS services.

## Step 1: Clone the Repository
1.1.Clone this repository to your local machine.
```language
git clone https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery.git
```


## Step 2 : Run Terraform workflow to initialize, validate, plan then apply
2.1.Terraform will provision:

1.Two Amazon S3 Bucket in different aws regions

2.AWS Lambda

3.Amazon SNS


2.2.In your local terraform visual code environment terminal, to initialize the necessary providers, execute the following command in your environment terminal.

```language
terraform init
```

Upon completion of the initialization process, a successful prompt will be displayed, as shown below.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/11be3367350f45cdb22564cf963a972773f69efd/screenshots/Screenshot%202025-03-30%20200009.png)

2.3.Next, let’s ensure that our code does not contain any syntax errors by running the following command

```language
terraform validate
```

The command should generate a success message, confirming that it is valid, as demonstrated below.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/86d05fcf08cfeafa7810415db0fc0dc222fd0eff/screenshots/Screenshot%202025-03-30%20200204.png)


2.4.Let’s now execute the following command to generate a list of all the modifications that Terraform will apply.

```language
terraform plan 
```
![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/ff397f740feedec4deacbc9b57b10ed20f2c3c81/screenshots/Screenshot%202025-03-30%20200410.png)

The list of changes that Terraform is anticipated to apply to the infrastructure resources should be displayed. The “+” sign indicates what will be added, while the “-” sign indicates what will be removed.

2.5.Now, let’s deploy this infrastructure! Execute the following command to apply the changes and deploy the resources. Note — Make sure to type “yes” to agree to the changes after running this command.


```language
terraform apply
```
Terraform will initiate the process of applying all the changes to the infrastructure. Kindly wait for a few seconds for the deployment process to complete.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/e9eef2bf3b8ddeb9075e674d97c14f5eab4071e1/screenshots/Screenshot%202025-03-30%20200701.png)


## Success
The process should now conclude with a message indicating “Apply complete”, stating the total number of added, modified, and destroyed resources, accompanied by several resources.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/ac5cadd41a67cca23a340849627987c1b1be8b73/screenshots/Screenshot%202025-03-30%20200713.png)


## Step 3: Verify creation of our resources

3.1.In the AWS Management Console, head to the Amazon S3 Console and verify that you have two Buckets

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/9b0737a6e7568584224ac9a9ae2e9fbdbdce26f8/screenshots/Screenshot%202025-03-30%20200744.png)

3.2.In the AWS Management Console, head to the AWS Lambda and verify that there is Lambda Function  as shown below

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/d8793bbbff25ce8aae8809b66f2e527e759b6567/screenshots/Screenshot%202025-03-30%20200809.png)

3.3.In the AWS Management Console, head to the Amazon SNS dashboard and verify that you have a topic  created as shown below

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/69b666e3b4996b3d069f9f3f78d9a9eaa1225bb8/screenshots/Screenshot%202025-03-30%20200833.png)


## Step 4: Testing the System
4.1.Upload a files to the primary S3 bucket.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/f11605f66eb798af63fbbae5cf633afaf7975ae5/screenshots/Screenshot%202025-04-01%20100125.png)


4.2.Verify versioning by checking multiple versions of the file.

![image_alt](https://github.com/Tatenda-Prince/Automated-S3-Backup-Recovery/blob/28164f8f9e5b86da575faae03e092e8c74666eb3/screenshots/Screenshot%202025-04-01%20100651.png)


4.3.Confirm replication in the backup S3 bucket (secondary region).

![image_alt]()


4.4.Force a failure and check if SNS notifications are triggered.

![image_alt]()


4.4.Monitor CloudWatch logs for Lambda execution results.

Successful Backups

![image_alt]()


Error Backups

![image_alt]()


## Future Enhancements
1.Integrate AWS Backup service for extended retention policies.

2.Add Terraform CI/CD pipeline for automated deployment.

3.Implement cost optimization strategies (Intelligent-Tiering storage class).

## What We Learned

1.Terraform automation for AWS resources.

2.AWS S3 Versioning & Replication for data protection.

3.Event-driven AWS Lambda automation.

4.CloudWatch monitoring & SNS alerts for system reliability.

5.IAM security best practices.


## Congratulations
We have successfully created a  automates S3 backups & recovery using AWS services and Terraform Infrastructure as Code (IaC). It ensures high availability, security, and disaster recovery. By implementing this, businesses can prevent data loss, reduce downtime, and maintain compliance




