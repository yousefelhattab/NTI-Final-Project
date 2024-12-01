resource "aws_vpc" "project" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "project-vpc"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}
resource "aws_subnet" "project" {
  count             = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(aws_vpc.project.cidr_block, 8, count.index)
  vpc_id            = aws_vpc.project.id
  map_public_ip_on_launch = true
  tags = {
    Name = "project-subnet-${count.index}"
  }
}

resource "null_resource" "cluster_subnet_tag" {
  depends_on = [aws_eks_cluster.project]
  
 
}
resource "aws_security_group" "project" {
  name        = "project-sg"
  description = "Security group for project"

  vpc_id = aws_vpc.project.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_internet_gateway" "project_igw" {
  vpc_id = aws_vpc.project.id
}

resource "aws_route_table" "project_rt" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.project_igw.id
  }
}

resource "aws_route_table_association" "project_rt_association" {
  count          = 2
  subnet_id      = aws_subnet.project[count.index].id
  route_table_id = aws_route_table.project_rt.id
  }
