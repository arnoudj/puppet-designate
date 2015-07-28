# == Class designate::mdns
#
# Configure designate mdns service
#
# == Parameters
#
# [*package_ensure*]
#  (optional) The state of the package
#  Defaults to 'present'
#
# [*mdns_package_name*]
#  (optional) Name of the package containing mdns resources
#  Defaults to mdns_package_name from designate::params
#
# [*enabled*]
#   (optional) Whether to enable services.
#   Defaults to true
#
# [*service_ensure*]
#  (optional) Whether the designate mdns service will be running.
#  Defaults to 'running'
#
class designate::mdns (
  $package_ensure    = present,
  $manage_package    = true,
  $mdns_package_name = undef,
  $enabled           = true,
  $service_ensure    = 'running',
) {
  include ::designate::params

  if $manage_package {
    package { 'designate-mdns':
      ensure => $package_ensure,
      name   => pick($mdns_package_name, $::designate::params::mdns_service_name),
      tag    => ['openstack', 'designate-package'],
    }
  }

  service { 'designate-mdns':
    ensure     => $service_ensure,
    name       => $::designate::params::mdns_service_name,
    enable     => $enabled,
    hasstatus  => true,
    hasrestart => true,
    tag        => ['openstack', 'designate-service'],
  }
}
