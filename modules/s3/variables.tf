variable "bucket_name" {
  description = "s3 bucket name"
}

variable "block_public_acls" {
  default = true
}

variable "block_public_policy" {
  default = true
}

variable "ignore_public_acls" {
  default = true
}

variable "restrict_public_buckets" {
  default = true
}

variable "acl" {
  description = "acl type i.g: private, public-read"
  type = string
  default = "private"
}