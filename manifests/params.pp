# @!visibility private
class zfs::params {

  $conf_dir       = '/etc/zfs'
  $kmod_type      = 'dkms'
  $service_manage = true
  $zed_conf_dir   = "${conf_dir}/zed.d"

  case $::osfamily {
    'RedHat': {
      $manage_repo      = true
      $zed_package_name = undef
      $zed_service_name = 'zfs-zed'
      $zedlet_dir       = '/usr/libexec/zfs/zed.d'
      $zedlets          = {
        'all-syslog.sh'             => {},
        'checksum-notify.sh'        => {},
        'checksum-spare.sh'         => {},
        'data-notify.sh'            => {},
        'io-notify.sh'              => {},
        'io-spare.sh'               => {},
        'resilver.finish-notify.sh' => {},
        'scrub.finish-notify.sh'    => {},
      }
      $zfs_package_name = 'zfs'
    }
    'Debian': {
      $zed_package_name = 'zfs-zed'

      case $::operatingsystem {
        'Ubuntu': {
          $zed_service_name = 'zed'

          case $::operatingsystemrelease {
            '12.04', '14.04': {
              $manage_repo      = true
              $zedlet_dir       = '/usr/lib/zfs-linux/zfs/zed.d'
              $zedlets          = {
                'all-syslog.sh'             => {},
                'checksum-notify.sh'        => {},
                'checksum-spare.sh'         => {},
                'data-notify.sh'            => {},
                'io-notify.sh'              => {},
                'io-spare.sh'               => {},
                'resilver.finish-notify.sh' => {},
                'scrub.finish-notify.sh'    => {},
              }
              $zfs_package_name = 'ubuntu-zfs'
            }
            '16.04': {
              $manage_repo      = false
              $zedlet_dir       = '/usr/lib/zfs-linux/zfs/zed.d'
              $zedlets          = {
                'all-syslog.sh'             => {},
                'checksum-notify.sh'        => {},
                'checksum-spare.sh'         => {},
                'data-notify.sh'            => {},
                'io-notify.sh'              => {},
                'io-spare.sh'               => {},
                'resilver.finish-notify.sh' => {},
                'scrub.finish-notify.sh'    => {},
              }
              $zfs_package_name = 'zfsutils-linux'
            }
            default: {
              $manage_repo      = false
              $zedlet_dir       = '/usr/lib/x86_64-linux-gnu/zfs/zed.d'
              $zedlets          = {
                'all-syslog.sh'             => {},
                'data-notify.sh'            => {},
                'pool_import-led.sh'        => {},
                'resilver_finish-notify.sh' => {},
                'scrub_finish-notify.sh'    => {},
                'statechange-led.sh'        => {},
                'statechange-notify.sh'     => {},
                'vdev_attach-led.sh'        => {},
                'vdev_clear-led.sh'         => {},
              }
              $zfs_package_name = 'zfsutils-linux'
            }
          }
        }
        default: {
          $manage_repo      = true
          $zed_service_name = 'zfs-zed'
          $zedlet_dir       = '/usr/lib/x86_64-linux-gnu/zfs/zed.d'
          $zedlets          = {
            'all-syslog.sh'             => {},
            'checksum-notify.sh'        => {},
            'checksum-spare.sh'         => {},
            'data-notify.sh'            => {},
            'io-notify.sh'              => {},
            'io-spare.sh'               => {},
            'resilver.finish-notify.sh' => {},
            'scrub.finish-notify.sh'    => {},
          }
          $zfs_package_name = [
            'zfs-dkms',
            'zfsutils-linux',
          ]
        }
      }
    }
    default: {
      fail("The ${module_name} module is not supported on an ${::osfamily} based system.")
    }
  }
}
