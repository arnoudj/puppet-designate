# Class: designate::pool_manager_cache::sqlalchemy
#
# === Parameters
#
# [*connection*]
#  Connection string for SQLAlchemy. For instance:
#    sqlite:///$state_path/designate_pool_manager.sqlite
#
# [*connection_debug*]
#  Wether to show debug information for SQLAlchemy.
#
# [*connection_trace*]
#  Wether to show traces in SQLAlchemy.
#
# [*sqlite_synchronous*]
#  Wether or not to enable synchronous queries in SQLite.
#
# [*idle_timeout*]
#  (optional) Set idle timeout.
#
# [*max_retries*]
#  (optional) Set max retries.
#
# [*retry_interval*]
#  (optional) Set retry interval.
#
class designate::pool_manager_cache::sqlalchemy(
  $connection         = $::os_service_default,
  $connection_debug   = $::os_service_default,
  $connection_trace   = $::os_service_default,
  $sqlite_synchronous = $::os_service_default,
  $idle_timeout       = $::os_service_default,
  $max_retries        = $::os_service_default,
  $retry_interval     = $::os_service_default,
){
  designate_config {
    'service:pool_manager/cache_driver':                value => 'sqlalchemy';
    'pool_manager_cache:sqlalchemy/connection':         value => $connection;
    'pool_manager_cache:sqlalchemy/connection_debug':   value => $connection_debug;
    'pool_manager_cache:sqlalchemy/connection_trace':   value => $connection_trace;
    'pool_manager_cache:sqlalchemy/sqlite_synchronous': value => $sqlite_synchronous;
    'pool_manager_cache:sqlalchemy/idle_timeout':       value => $idle_timeout;
    'pool_manager_cache:sqlalchemy/max_retries':        value => $max_retries;
    'pool_manager_cache:sqlalchemy/retry_interval':     value => $retry_interval;
  }
}
