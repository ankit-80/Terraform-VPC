#------------- VPC NAME -------------------------------------

variable "vpc_name" {
    type = string
    default = "ankit-vpc-1"
}

#------------- VPC CIDR BLOCK -------------------------------

variable "vpc-cidr" {
    type = string
    default = "10.0.0.0/24"
}

#-------------- igw tag/name --------------------------------

variable "igw-tag" {
    type = string
    default = "ankit-igw"   
}

#--------------------------------------------------
## public subnet-1 CIDR 
variable "public-subnet-1-cidr" {
    type = string
    default = "10.0.0.0/26"
}

# -----------------map public ip------------------------------  

variable "map_public_ip_on_launch" {
    type = bool
    default = null
}

## public subnet-1-tag

variable "public-subnet-1-tag" {
    type = string
    default = "ankit-public-subnet-1"

  
}
## PUBLIC SUBNET-2
variable "public-subnet-2-tag" {
    type = string
    default = "ankit-public-subnet-2"
 
}

variable "public-subnet-2-cidr" {
    type = string
    default = "10.0.0.64/26"
  
}
#-------------------------------------------------------
#private subnet

#----------------------------------------------

# PRIVATE SUBNET
variable "private-subnet-1-cidr" {
    type = string
    default = "10.0.0.128/26"
  
}

variable "private-subnet-1-tag" {
    type = string
    default = "ankit-private-subnet-1"

}



#-----------------------------------------------

#-----------------------------------------------

#route table

variable "public-route-table-tag" {
    type = string
    default = "ankit-public-route-table-1"
  
}


variable "private-route-table-tag" {
    type = string
    default = "ankit-private-route-table-1"
  
}