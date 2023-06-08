terraform-alicloud-gpdb - Nishant Version
=====================

Terraform module for provisioning AnalyticDB for PostgreSQL instances on Alibaba Cloud By Nishant Iyer.

* * * * *

Usage
-----

You can incorporate this module into your Terraform template using the following steps:

1.  Add a module resource to your template, for example, `main.tf`:

hclCopy code

`module "gpdb" {
  source = "terraform-alicloud-modules/gpdb/alicloud"

  # GPDB instance variables

  engine                       = "gpdb"
  engine_version               = "4.3"
  instance_class               = "gpdb.group.segsdx2"
  instance_group_count         = "2"
  description                  = "myGpdbInstance"
  availability_zone            = "cn-beijing-c"
  security_ips                 = ["11.193.54.0/24","101.37.74.0/24","10.137.42.0/24","121.43.18.0/24"]

  # GPDB connection variables
  instance_id                  = "gp-2ze9173c2h1kh0czy"
  connection_prefix            = "my-adb4pg-prefix"
  port                         = "3333"

  number_of_instances          = "2"
}`

1.  Set the values for `access_key` and `secret_key` through environment variables:

    -   `ALICLOUD_ACCESS_KEY`
    -   `ALICLOUD_SECRET_KEY`
    -   `ALICLOUD_REGION`

* * * * *

Inputs
------

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | --- |
| engine | The type of database. Valid options: `gpdb` | string | gpdb | yes |
| engine_version | The version of the database. Valid options: `4.3` | string | 4.3 | yes |
| description | The name of the DB instance. A string of 2 to 256 characters. | string | "" | no |
| instance_class | The type of DB instance. Refer to the [Instance Type Table](https://www.alibabacloud.com/help/doc-detail/35406.htm) for more details. | string | "" | yes |
| instance_group_count | The number of instance groups. | string | 2 | yes |
| availability_zone | The zone in which to launch the DB instance. If `vswitch_id` is not set, this parameter cannot be left blank. | string | "" | no |
| vswitch_id | The ID of the VSwitch. If you want to create a VPC, this parameter cannot be left blank. | string | "" | no |
| number_of_instances | The number of instances you want to create. | string | 1 | no |
| security_ips | A list of IP addresses allowed to access all databases of an instance. The list can contain up to 1,000 IP addresses, separated by commas. Supported formats include `0.0.0.0/0`, `10.23.12.24` (IP), and `10.23.12.24/24` (CIDR mode, where `/24` represents the length of the prefix in an IP address. The range of the prefix length is `[1,32]`). | list | [] | no |
| connection_prefix | The prefix of the internet connection string. It must be unique and may consist of lowercase letters, numbers, and underscores. It must start with a letter and have no more than 30 characters. The default is 'tf'. | string | "" | yes |
| port | The internet connection port. Valid value range: `[3200-3999]`. The default is `3306`. | string | 3306 | no |

* * * * *

Outputs
-------

| Name | Description |
| --- | --- |
| this_gpdb_instance_id | A list of instance IDs created. |
| this_gpdb_connection_id | A list of instance IDs of GPDB connections. |

* * * * *

Notes
-----

Starting from version v1.2.0, the module has removed the following `provider` configuration:

hclCopy code

`provider "alicloud" {
   version              = ">=1.56.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/gpdb"
}`

If you still want to use the `provider` configuration with this module, you can specify a supported version, such as 1.1.0:

hclCopy code

`module "gpdb" {
   source         = "terraform-alicloud-modules/gpdb/alicloud"
   version        = "1.1.0"
   region         = "cn-beijing"
   engine         = "gpdb"
   engine_version = "4.3"
   // ...
}`

If you want to upgrade the module to version 1.2.0 or higher in-place, you can define a provider in the same region as the previous region:

hclCopy code

`provider "alicloud" {
   region = "cn-beijing"
}

module "gpdb" {
   source         = "terraform-alicloud-modules/gpdb/alicloud"
   engine         = "gpdb"
   engine_version = "4.3"
   // ...
}`

Alternatively, you can specify an alias provider with a defined region for the module using `providers`:

hclCopy code

`provider "alicloud" {
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
}`

After making these changes, run `terraform init` and `terraform apply` to apply the defined provider to the existing module state.

For more details, refer to [How to Use Providers in Modules](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly).

* * * * *

Terraform Versions
------------------

| Name | Version |
| --- | --- |
| <a name="requirement_terraform"></a> [terraform](https://chat.openai.com/?model=text-davinci-002-render-sha#requirement_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](https://chat.openai.com/?model=text-davinci-002-render-sha#requirement_alicloud) | >= 1.56.0 |

* * * * *

Authors
-------

Created, Modified by Nishant Iyer and credits to the Alibaba Cloud Terraform Team (<nishant.iyer62@gmail.com>).

* * * * *

References
----------

-   [Terraform-Provider-Alicloud GitHub](https://github.com/terraform-providers/terraform-provider-alicloud)
-   [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
-   [Terraform-Provider-Alicloud Documentation](https://www.terraform.io/docs/providers/alicloud/index.html)
