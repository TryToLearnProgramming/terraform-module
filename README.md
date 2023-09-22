# terraform-module
    created by Mr3ngineer
## VPC Module parameters**
```python
# only for IPv4 use
  name                       = name of the VPC
  availability_zones         = ["zone_a", "zone_b", "zone_c"] => use all zones
  vpc_cidr_block             = vpc_cidr_block (i.g: 10.0.0.0/16)
  public_subnet_cidr_blocks  = [enter public subnets CIDR as a list format] => use 3 CIDRs
  private_subnet_cidr_blocks = [enter private subnets CIDR as a list format] => use 3 CIDRs

  create_eip = true/false   # If want a EIP for NAT
  create_nat = true/false   # If want a NAT
```
## S3 Module parameters**
```python
# other resources have to created saperetely
  bucket_name = "enter a unique name"
  ############## Enable for public access ##############
  acl = "default value private" / "public-read" 
  block_public_acls = "default value true"
  block_public_policy = "default value true"
  ignore_public_acls = "default value true"
  restrict_public_buckets = "default value true"
```

## RDS Module parameters**
```python

```