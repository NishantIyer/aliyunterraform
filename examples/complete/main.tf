data "alicloud_gpdb_zones" "default" {
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/16"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_gpdb_zones.default.zones.0.id]
}

module "gpdb_instance" {
  source = "../.."

  #alicloud_gpdb_instance
  number_of_instances  = 1
  engine               = "gpdb"
  engine_version       = "6.0"
  description          = var.description
  instance_class       = "gpdb.group.segsdx1"
  instance_group_count = "2"
  security_ip_list     = var.security_ip_list
  vswitch_id           = module.vpc.this_vswitch_ids[0]
  availability_zone    = data.alicloud_gpdb_zones.default.zones.0.id

  #alicloud_gpdb_connection
  connection_prefix = "tf-testacc"
  port              = var.port

}