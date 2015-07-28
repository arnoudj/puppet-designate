# == Class: designate::pool_manager
#
# Configure designate pool manager service
#
# == Parameters
#
# [*pool_id*]
#  UUID of the pool to use.
#
# [*package_ensure*]
#  (optional) The state of the package
#  Defaults to 'present'
#
# [*manage_package*]
#   Whether Puppet should manage the package. Default is true.
#
# [*pool_manager_package_name*]
#  (optional) Name of the package containing pool manager
#  resources. Defaults to pool_manager_package_name from
#  designate::params
#
# [*enabled*]
#   (optional) Whether to enable services.
#   Defaults to true
#
# [*service_ensure*]
#  (optional) Whether the designate pool manager service will
#  be running.
#  Defaults to 'running'
#
# [*workers*]
#  (optional) Number of worker processes.
#
# [*threshold_percentage*]
#  (optional) Threshold percentage.
#
# [*poll_timeout*]
#  (optional) Poll timeout.
#
# [*poll_retry_interval*]
#  (optional) Poll retry interval.
#
# [*poll_max_retries*]
#  (optional) Poll max retries.
#
# [*poll_delay*]
#  (optional) Poll delay.
#
# [*periodic_recovery_interval*]
#  (optional) Periodic recovery interval.
#
# [*periodic_sync_interval*]
#  (optional) Periodic sync interval.
#
# [*periodic_sync_seconds*]
#  (optional) Periodic sync seconds.
#
class designate::pool_manager(
  $pool_id,
  $manage_package             = true,
  $package_ensure             = present,
  $pool_manager_package_name  = undef,
  $enabled                    = true,
  $service_ensure             = 'running',
  $workers                    = undef,
  $threshold_percentage       = undef,
  $poll_timeout               = undef,
  $poll_retry_interval        = undef,
  $poll_max_retries           = undef,
  $poll_delay                 = undef,
  $periodic_recovery_interval = undef,
  $periodic_sync_interval     = undef,
  $periodic_sync_seconds      = undef,
) {
  include designate::params

  if $pool_id !~ /^[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}$/ {
    fail('pool_id should be a valid UUID')
  }

  if $manage_package {
    package { 'designate-pool-manager':
      ensure => $package_ensure,
      name   => pick($pool_manager_package_name, $::designate::params::pool_manager_service_name),
      tag    => ['openstack', 'designate-package'],
    }
  }

  service { 'designate-pool-manager':
    ensure     => $service_ensure,
    name       => $::designate::params::pool_manager_service_name,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => ['openstack', 'designate-service'],
  }

  designate_config {
    'service:pool_manager/pool_id':                    value => $pool_id;
    'service:pool_manager/workers':                    value => $workers;
    'service:pool_manager/threshold_percentage':       value => $threshold_percentage;
    'service:pool_manager/poll_timeout':               value => $poll_timeout;
    'service:pool_manager/poll_retry_interval':        value => $poll_retry_interval;
    'service:pool_manager/poll_max_retries':           value => $poll_max_retries;
    'service:pool_manager/poll_delay':                 value => $poll_delay;
    'service:pool_manager/periodic_recovery_interval': value => $periodic_recovery_interval;
    'service:pool_manager/periodic_sync_interval':     value => $periodic_sync_interval;
    'service:pool_manager/periodic_sync_seconds':      value => $periodic_sync_seconds;
  }
}
