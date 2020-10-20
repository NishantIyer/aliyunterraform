output "this_gpdb_instance_id" {
  value = join(",", alicloud_gpdb_instance.this_instance.*.id)
}

output "this_gpdb_connection_id" {
  value = join(",", alicloud_gpdb_connection.connection.*.id)
}