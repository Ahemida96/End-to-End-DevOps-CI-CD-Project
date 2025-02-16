#---------------------Create VPC------------------------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = var.vpc_name
  }
}

#---------------------Internet Gateway------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

#----------------------Create Subnets--------------------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_block
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = var.public_subnet_name
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "public_rt_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

#----------------------Security Groups-----------------------
resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

#---------------------------Create EC2 Instances----------------------------------

locals {
  instances = {
    instance1 = {
      ami           = data.aws_ami.ubuntu.id
      instance_type = "t2.micro"
    }
  }
}

resource "aws_instance" "this" {

  for_each        = local.instances
  ami             = each.value.ami
  instance_type   = each.value.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.public_sg.id]
  key_name        = aws_key_pair.key_pair.key_name
  associate_public_ip_address = true

  tags = {
    Name = "public-{$each.key}"
  }

}

#--------------------------Inventory host resource-------------------------------------
resource "ansible_host" "this" {
  for_each = local.instances
  name     = each.key
  groups   = ["aws"] # Groups this host is part of.

  variables = {
    # Connection vars.
    ansible_user = "ubuntu" # Default user depends on the OS.
    ansible_host = aws_instance.this[each.key].public_ip

    # Custom vars that we might use in roles/tasks.
    hostname = "app01"
    # fqdn     = "${each.key}.example.com"
  }
}