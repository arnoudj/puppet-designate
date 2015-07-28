# == Define: designate::pool_manager::target::bind9
#
# Configure a target for the iDesignate Pool Manager.
#
# == Parameters
#
# [*rndc_config_file*]
#   (optional) Location of the rndc configuration file.
#   Defaults to '/etc/rndc.conf'
#
# [*rndc_key_file*]
#  (optional) Location of the rndc key file.
#  Defaults to '/etc/rndc.key'
#
# [*rndc_host*]
#  (optional) Host running DNS service.
#  Defaults to '127.0.0.1'
#
# [*rndc_port*]
#  (optional) Port to use for dns service on rndc_host.
#  Defaults to '953'
#
# [*options*]
#  Options can vary according to the chosen type (powerdns or bind9).
#  See the example config file for designate for the config options.
#  For powerdns, this should at least contain the connection string.
#  For bind this should contain the rndc settings.
#  The options parameter should be a hash.
#
# [*type*]
#  Type of the target. This should be 'powerdns' or 'bind9'.
#  Defaults to 'powerdns'.
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
define designate::pool_manager::target::bind9 (
  $rndc_host        = '127.0.0.1',
  $rndc_port        = '953',
  $rndc_config_file = '/etc/rndc.conf',
  $rndc_key_file    = '/etc/rndc.key'
  $type = 'powerdns',
  $masters = ['127.0.0.1:5354'],
  $port = 53,
  $host = '127.0.0.1',
) {
  include ::designate

  validate_array($masters)

  designate_config {
    "pool_target:${name}/options": value => "rndc_host: ${rndc_host}, rndc_port: ${rndc_port}, rndc_config_file: ${rndc_config_file}, rndc_key_file: ${rndc_key_file}";
    "pool_target:${name}/type":    value => 'bind9';
    "pool_target:${name}/masters": value => join($masters,',');
    "pool_target:${name}/port":    value => $port;
    "pool_target:${name}/host":    value => $host;
  }
}
