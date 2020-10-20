variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  type        = string
  default     = ""
}

# variables for alicloud_gpdb_instance
variable "number_of_instances" {
  description = "The number of launching instances one time."
  type        = number
  default     = 1
}

variable "engine" {
  description = "The database engine to use"
  type        = string
  default     = "gpdb"
}

variable "engine_version" {
  description = "The engine version to use"
  type        = string
  default     = "6.0"
}

variable "description" {
  description = "The name of DB instance. It a string of 2 to 256 characters"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "DB Instance type, for example: gpdb.group.segsdx2. fall list is : https://www.alibabacloud.com/help/doc-detail/35406.htm"
  type        = string
  default     = "gpdb.group.segsdx1"
}

variable "instance_group_count" {
  description = "The number of instance group."
  type        = string
  default     = "2"
}

variable "security_ip_list" {
  description = "List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = []
}

variable "vswitch_id" {
  description = "The vswitch id used to launch one or more instances."
  type        = string
  default     = ""
}

variable "availability_zone" {
  description = "The available zone to launch ecs instance and other resources."
  type        = string
  default     = ""
}

# variables for alicloud_gpdb_connection
variable "connection_prefix" {
  description = "Prefix of an Internet connection string. It must be checked for uniqueness. It may consist of lowercase letters, numbers, and underlines, and must start with a letter and have no more than 30 characters. Default to + 'tf'."
  type        = string
  default     = ""
}

variable "port" {
  description = "Internet connection port. Valid value: [3200-3999]. Default to 3306."
  type        = number
  default     = 3306
}