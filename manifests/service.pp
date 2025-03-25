# Class: zookeeper::service

class zookeeper::service(
  $cfg_dir = '/etc/zookeeper/conf',
  Boolean $restart_zookeeper = true,
){
  require zookeeper::install
  require zookeeper::config

  service { 'zookeeper':
    ensure     => 'running',
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
    require    => [
      File["${cfg_dir}/zoo.cfg"]
    ]
  }

  if $restart_zookeeper {
    File["${cfg_dir}/myid"] ~> Service['zookeeper']
    File["${cfg_dir}/zoo.cfg"] ~> Service['zookeeper']
    File["${cfg_dir}/environment"] ~> Service['zookeeper']
    File["${cfg_dir}/log4j.properties"] ~> Service['zookeeper']
  }
}
