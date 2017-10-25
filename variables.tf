#------------------------------------------#
# AWS Environment Variables
#------------------------------------------#
variable "region" {
    default     = "us-west-2"
    description = "The region of AWS, for AMI lookups"
}

variable "count" {
    default     = "2"
    description = "Number of HA servers to deploy"
}

variable "name_prefix" {
    default     = "rancher-ha"
    description = "Prefix for all AWS resource names"
}

variable "ami" {
    default     = "ami-7bba5a03"
    description = "Instance AMI ID"
}

variable "key_name" {
    description = "SSH key name in your AWS account for AWS instances"
}

variable "instance_type" {
    default     = "t2.large" # RAM Requirements >= 8gb
    description = "AWS Instance type"
}

variable "root_volume_size" {
    default     = "16"
    description = "Size in GB of the root volume for instances"
}

variable "vpc_cidr" {
    default     = "192.168.199.0/24"
    description = "Subnet in CIDR format to assign to VPC"
}

variable "subnet_cidrs" {
    default     = ["192.168.199.0/26", "192.168.199.64/26", "192.168.199.128/26"]
    description = "Subnet ranges (requires 3 entries)"
}

variable "availability_zones" {
    default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
    description = "Availability zones to place subnets"
}

variable "internal_elb" {
    default     = "false"
    description = "Force the ELB to be internal only"
}

#------------------------------------------#
# Database Variables
#------------------------------------------#
variable "db_name" {
    default     = "rancher"
    description = "Name of the RDS DB"
}

variable "db_user" {
    default     = "rancher"
    description = "Username used to connect to the RDS database"
}

variable "db_pass" {
    description = "Password used to connect to the RDS database"
}

#------------------------------------------#
# SSL Variables
#------------------------------------------#
variable "enable_https" {
    default     = false
    description = "Enable HTTPS termination on the loadbalancer"
}

variable "cert_body" {
    default = ""
}

variable "cert_private_key" {
    default = ""
}

variable "cert_chain" {
    default = ""
}

#------------------------------------------#
# Rancher Variables
#------------------------------------------#
variable "rancher_version" {
    default     = "stable"
    description = "Rancher version to deploy"
}
