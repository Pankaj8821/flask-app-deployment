# Project Overview:

![Image Description](https://github.com/Pankaj8821/flask-app-deployment/blob/main/flaskapp.png)

# This project demonstrates how to deploy Flask app using Terraform, Amazon EKS, and the AWS Application load balancer. The infrastructure is fully provisioned using Terraform, including components like VPC, EKS Cluster, ALB, S3 Bucket.

We have created a CI/CD pipeline using GitHub Actions, which utilizes AWS and Docker Hub secrets for secure deployments.

# This is my GitHub Action Workflow File  -->  https://github.com/Pankaj8821/flask-app-deployment/blob/main/.github/workflows/flask-pipeline-main.yml

# TERRAFORM
# Create  S3 bucket  :

      aws s3api create-bucket \
        --bucket my-eks-terraform-state \
        --region us-east-1
     --create-bucket-configuration #LocationConstraint=us-west-2
    
NOTE  Not use  -- create-bucket-configuration LocationConstraint in us-east-1
Enable versioning and encryption (recommended for Terraform)
 # Enable versioning:
    aws s3api put-bucket-versioning \
       --bucket my-eks-terraform-state \
       --versioning-configuration Status=Enabled

# Enable server-side encryption:
         aws s3api put-bucket-encryption \
         --bucket my-eks-terraform-state \
         --server-side-encryption-configuration '{
           "Rules": [{
              "ApplyServerSideEncryptionByDefault": {
               "SSEAlgorithm": "AES256"
             }
           }]
         }'


# Create DynamoDB Table for State Locking
         
         aws dynamodb create-table \
         --table-name terraform-lock-table \
         --attribute-definitions AttributeName=LockID,AttributeType=S \
         --key-schema AttributeName=LockID,KeyType=HASH \
         --billing-mode PAY_PER_REQUEST \
         --region us-west-2

# Verify Table Created
         aws dynamodb list-tables --region us-west-2

# NOW #  Ready to Use with Terraform
  -- backend.tf 
    
         terraform {
                  backend "s3" {
                        bucket         = "my-eks-terraform-state"
                                    key            = "eks/terraform.tfstate"
                                   region         = "us-west-2"
                                  dynamodb_table = "terraform-lock-table"
                                   encrypt        = true
                                                }
                               }
