
#------------ region_id

variable "region" {}

#------------- cidr_block of vpc

variable "cidr_vpc" {}

#------------ name of vpc 

variable "vpc_name" {}

#---------- name of k8s

variable "igw_name" {}

#------------- vars for subnets

variable "sub1_name" {}
variable "sub1_cidr" {}

variable "sub2_name" {}
variable "sub2_cidr" {}

#--------------- var for route_table name
variable "rtb_name" {}

#---------------- security group name
variable "sg_name" {}

#-------------- k8s name
variable "eks_name" {}

#---------------- nodes capacity

variable "ng-name" {}
variable "max-n" {}
variable "min-n" {}
variable "ami_type" {}
variable "capacity" {}
variable "ins_type" {}
variable "desired-n" {}
