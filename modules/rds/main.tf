terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}


######################### RDS #########################
resource "aws_db_instance" "this" {
  allocated_storage    = 10
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = aws_db_parameter_group.parameter_group.name
  skip_final_snapshot  = true
  identifier           = var.name
  db_subnet_group_name = aws_db_subnet_group.subnet_group[0].name
  storage_encrypted           = true
  multi_az = var.multi_az
  vpc_security_group_ids = [aws_security_group.this.id]
  
  depends_on = [ 
    aws_db_parameter_group.parameter_group, 
    aws_db_subnet_group.subnet_group, 
    aws_security_group.this 
    ]

}

######################### Parameter Group #########################
resource "aws_db_parameter_group" "parameter_group" {
  name = "${var.name}-parameter-group"
  family = "mysql${var.engine_version}"
  dynamic "parameter" {
    for_each = var.parameters
    content {
    name  = "character_set_server"
    value = "utf8"
  }
  }
}

######################### Subnet Group #########################
resource "aws_db_subnet_group" "subnet_group" {
  name       = "${var.name}-subnet-group"
  count = length(var.subnet_ids)
  subnet_ids = [var.subnet_ids[count.index]]

  tags = {
    Name = "${var.name}-subnet-group"
  }
}

######################### Security Group #########################
resource "aws_security_group" "this" {
  name = "${var.name}-security-group"
  description = "Allow TLS inbound traffic"
  vpc_id = var.vpc_id
  
  ingress {
    description      = "TLS from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [var.sg_cidr_blocks]
  }
}