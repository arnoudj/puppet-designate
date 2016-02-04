# == Define: designate::pool
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
# [*also_notifies*]
#  (optional) List of hostnames and port numbers to also notify on zone changes.
#
define designate::pool(
  $nameservers,
  $targets,
  $also_notifies = [],
){
  validate_array($nameservers)
  validate_array($targets)

  designate_config {
    "pool:${name}/nameservers":   value => join($nameservers,',');
    "pool:${name}/targets":       value => join($targets,',');
    "pool:${name}/also-notifies": value => join($also_notifies,',');
  }
}
