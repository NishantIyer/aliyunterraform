# terraform-alicloud-gpdb
Terraform module for creating AnalyticDB for PostgreSQL on Alibaba Cloud, designed by Nishant Iyer.

## Usage
You can use this in your Terraform template with the following steps.

1. Adding a module resource to your template, e.g., `main.tf`:
```hcl
module "gpdb" {
  source = "terraform-alicloud-modules/gpdb/alicloud"

  # variables for gpdb instance
  
  engine                       = "gpdb"
  engine_version               = "4.3"
  instance_class               = "gpdb.group.segsdx2"
  instance_group_count         = "2"
  description                  = "myGpdbInstance"
  availability_zone            = "cn-beijing-c"
  security_ips                 = ["11.193.54.0/24","101.37.74.0/24","10.137.42.0/24","121.43.18.0/24"]
  
  # variables for gpdb connection
  instance_id                  = "gp-2ze9173c2h1kh0czy"
  connection_prefix            = "my-adb4pg-prefix"
  port                         = "3333"
  
  number_of_instances          = "2"
}
Setting access_key and secret_key values through environment variables:

ALICLOUD_ACCESS_KEY
ALICLOUD_SECRET_KEY
ALICLOUD_REGION
Inputs
Name	Description	Type	Default	Required
engine	The type of the database. Possible values: gpdb	string	gpdb	yes
engine_version	The version of the database. Possible values: 4.3	string	4.3	yes
description	The name of the DB instance. It is a string of 2 to 256 characters.	string	""	no
instance_class	The type of the DB instance. For more information, refer to the Instance type table.	string	""	yes
instance_group_count	The number of instance groups.	string	2	yes
availability_zone	The zone in which to launch the DB instance. If vswitch_id is not set, this parameter cannot be left blank.	string	""	no
vswitch_id	The VSwitch ID. If you want to create a VPC, this parameter cannot be left blank.	string	""	no
number_of_instances	The number of instances you want to create	string	1	no
security_ips	List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32]).	list	[]	no
connection_prefix	The prefix of an Internet connection string. It must be checked for uniqueness. It may consist of lowercase letters, numbers, and underlines, and must start with a letter and have no more than 30 characters. Default to + 'tf'.	string	""	yes
port	The Internet connection port. Valid value: [3200-3999]. Default to 3306.	string	3306	no
Outputs
Name	Description
this_gpdb_instance_id	List of instance ID created.
this_gpdb_connection_id	List of instance ID of gpdb connection.
Notes
From the version v1.2.0, the module has removed the following provider setting:

hcl
Copy code
provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/gpdb"
}
If you still want to use the provider setting to apply this module, you can specify a supported version, like 1.1.0:

hcl
Copy code
module "gpdb" {
   source         = "terraform-alicloud-modules/gpdb/alicloud"
   version        = "1.1.0"
   region         = "cn-beijing"
   engine         = "gpdb"
   engine_version = "4.3"
   // ...
}
If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

hcl
Copy code
provider "alicloud" {
   region = "cn-beijing"
}
module "gpdb" {
   source         = "terraform-alicloud-modules/gpdb/alicloud"
   engine         = "gpdb"
   engine_version = "4.3"
   // ...
}
or specify an alias provider with a defined region to the module using providers:

hcl
Copy code
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "gpdb" {
   source         = "terraform-alicloud-modules/gpdb/alicloud"
   providers      = {
      alicloud = alicloud.bj
   }
   engine         = "gpdb"
   engine_version = "4.3"
   // ...
}
and then run terraform init and terraform apply to make the defined provider effect on the existing module state.

Terraform Versions
Name	Version
terraform	>= 0.13.0
alicloud	>= 1.56.0
Authors
Modified by Nishant Iyer, created by (terraform@alibabacloud.com)

Reference
Terraform-Provider-Alicloud GitHub
Terraform-Provider-Alicloud Release
Terraform-Provider-Alicloud Docs