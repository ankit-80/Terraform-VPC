###########################################################
# VPC CREATION
############################################################
resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc-cidr
    tags       = {
        Name= var.vpc_name
    }
  
}

############################################################
# INTERNET GATEWAY
###########################################################
resource "aws_internet_gateway" "myigw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = var.igw-tag
    }
  
}

#############################################################
# PUBLIC SUBNETS
#############################################################

# PUBLIC SUBNET-1

resource "aws_subnet" "public-subnet-1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.public-subnet-1-cidr
    availability_zone       = data.aws_availability_zones.available_1.names[0]
    map_public_ip_on_launch = var.map_public_ip_on_launch
    tags = {
      Name = var.public-subnet-1-tag
    }


  
}
# PUBLIC SUBNET-2
resource "aws_subnet" "public-subnet-2" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.public-subnet-2-cidr
    availability_zone       = data.aws_availability_zones.available_1.names[1]
    map_public_ip_on_launch = var.map_public_ip_on_launch
    tags = {
      Name = var.public-subnet-2-tag

    }
  
}

#############################################################
# PRIVATE SUBNETS
#############################################################
resource "aws_subnet" "private-subnet-1" {
    vpc_id                  = aws_vpc.myvpc.id
    cidr_block              = var.private-subnet-1-cidr
    availability_zone       = data.aws_availability_zones.available_1.names[2]
    tags = {
      Name = var.private-subnet-1-tag

    }  
}



#############################################################
# ROUTE TABLE CREATION 
#############################################################

#PUBLIC ROUTE TABLE

resource "aws_route_table" "public-route" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = var.public-route-table-tag

    }
}
# adding internet gatewy in route table
resource "aws_route" "add-route-to-table" {
    route_table_id = aws_route_table.public-route.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myigw.id
  
}


# PRIVATE ROUTE TABLE

resource "aws_route_table" "private-route" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
      Name = var.private-route-table-tag

    }
  
}


#############################################################
## subnet association
#############################################################

resource "aws_route_table_association" "public-route-association-1" {
    subnet_id       = aws_subnet.public-subnet-1.id
    route_table_id  = aws_route_table.public-route.id  
}

resource "aws_route_table_association" "public-route-table-association-2" {
    subnet_id       = aws_subnet.public-subnet-2.id
    route_table_id  = aws_route_table.public-route.id

     
}

resource "aws_route_table_association" "private-route-table-association" {
    subnet_id       = aws_subnet.private-subnet-1.id
    route_table_id  = aws_route_table.private-route.id
  
}

#------------------------------------------------------------
# SECURITY GROUP
#-----------------------------------------------------------

resource "aws_security_group" "sg-group" {
    name        = "tcw_security_group"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress = [    # inbound traffic
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [                    # outbound traffic
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "tcw_security_group"
  }
}
  

  resource "aws_instance" "ec-2" {
    ami = "ami-0fa377108253bf620"
    instance_type = "t2.micro"
    key_name = "ankit-key-pair"
    tags = {
      Name = "ubunu-linux"
    }
    subnet_id = aws_subnet.public-subnet-1.id
  }

