variable "name" {
  description = "Name of the RDS"
  type = string
}

variable "db_name" {
  description = "Name of Database"
  type = string
}
variable "engine" {
  description = "engin name"
  type = string
}
variable "engine_version" {
  description = "engine version"
  type = string
}
variable "instance_class" {
  description = "instance type"
  type = string
}
variable "username" {
  description = "username for database"
  type = string
}
variable "password" {
  description = "password for database"
  type = string
}
variable "parameters" {
  type = list(map(string))
  default = [
    {
      name  = "character_set_server"
      value = "utf8"
    },
    {
      name  = "character_set_client"
      value = "utf8"
    }
    # Add more parameters as needed
  ]
}
variable "vpc_id" {
  description = "VPC ID"
  type = string
}
variable "subnet_ids" {
  description = "Subnet IDs"
  type = list(string)
}
variable "sg_cidr_blocks" {
  description = "CIDR block"
  type = string
}