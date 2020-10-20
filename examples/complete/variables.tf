# variables for alicloud_gpdb_instance
variable "description" {
  description = "The name of DB instance. It a string of 2 to 256 characters"
  type        = string
  default     = "tf-testacc-description"
}

variable "security_ip_list" {
  description = "List of IP addresses allowed to access all databases of an instance. The list contains up to 1,000 IP addresses, separated by commas. Supported formats include 0.0.0.0/0, 10.23.12.24 (IP), and 10.23.12.24/24 (Classless Inter-Domain Routing (CIDR) mode. /24 represents the length of the prefix in an IP address. The range of the prefix length is [1,32])."
  type        = list(string)
  default     = ["127.0.0.1"]
}

# variables for alicloud_gpdb_connection
variable "port" {
  description = "Internet connection port. Valid value: [3200-3999]. Default to 3306."
  type        = number
  default     = 3306
}