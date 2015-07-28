# == Define: designate::pool_manager::pool
#
# Define a pool.
#
# === Parameters
#
# [*nameservers*]
#  An array of UUID's of the nameservers in this pool
#
# [*targets*]
#  An array of UUID's of the targets in this pool
#
define designate::pool_manager::pool(
  $nameservers = [],
  $targets = [],
){
  validate_array($nameservers)
  validate_array($targets)

  designate_config {
    "pool:${name}/nameservers": value => join($nameservers,',');
    "pool:${name}/targets":     value => join($targets,',');
  }
}
