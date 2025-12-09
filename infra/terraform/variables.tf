variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cluster_name" {
  description = "EKS Cluster name"
  type        = string
  default     = "flask-eks-cluster"
}

variable "node_instance_type" {
  description = "EC2 instance type for node group"
  type        = string
  default     = "t2.medium"
}

variable "desired_size" {
  description = "Desired number of nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of nodes"
  type        = number
  default     = 2
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "dev"
    Terraform   = "true"
  }
}

variable "k8s_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
  default     = "1.29"
}


