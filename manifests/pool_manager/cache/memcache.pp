# Class: designate::pool_manager::cache::memcache
#
class designate::pool_manager::cache::memcache(
  $memcached_servers = '127.0.0.1',
  $expiration        = '3600',
){
  designate_config {
    'service:pool_manager/cache_driver':             value => 'memcache';
    'pool_manager_cache:memcache/memcached_servers': value => $memcached_servers;
    'pool_manager_cache:memcache/expiration':        value => $expiration;
  }
}
