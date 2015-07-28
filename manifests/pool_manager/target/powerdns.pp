# == Define: designate::pool_manager::target::powerdns
#
# Configure a target for the iDesignate Pool Manager.
#
# == Parameters
#
# [*connection*]
#  Connect string to the PowerDNS database.
#
# [*use_db_reconnect*]
#  Wether to use DB reconnect or not.
#  Defaults to True.
#
# [*master*]
#  IP address and port of the master DNS server. This should point
#  to the Designate mDNS server and port.
#
# [*port*]
#  Port number of the target DNS server.
#
# [*host*]
#  IP address or hostname of the target DNS server.
#
define designate::pool_manager::target::powerdns (
  $connection,
  $use_db_reconnect = 'True',
  $masters          = ['127.0.0.1:5354'],
  $port             = 53,
  $host             = '127.0.0.1',
) {
  include ::designate
  include ::powerdns
  include ::powerdns::mysql

  validate_array($masters)

  designate_config {
    "pool_target:${name}/options": value => "connection: ${connection}, use_db_reconnect: ${use_db_reconnect}";
    "pool_target:${name}/type":    value => 'powerdns';
    "pool_target:${name}/masters": value => join($masters,',');
    "pool_target:${name}/port":    value => $port;
    "pool_target:${name}/host":    value => $host;
  }

  exec { "designate-powerdns-dbsync ${name}":
    command     => "${::designate::params::powerdns_dbsync_command} ${name}",
    path        => '/usr/bin',
    user        => 'root',
    refreshonly => true,
    logoutput   => on_failure,
  }

  # Have to have a valid configuration file before running migrations
  Designate_config<||> -> Exec["designate-powerdns-dbsync ${name}"]
  Exec["designate-powerdns-dbsync ${name}"] ~> Service<| title == 'designate-central' |>
}
