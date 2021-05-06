apt_keep_configured_configuration_files:
  file.managed:
    - name: /etc/apt/apt.conf.d/20keep-oldconf
    - user: root
    - group: root
    - mode: 644
    - contents: |
        # confold: Do not modify configuration file, install with .dpkg-dist suffix instead
        # confdef: But let dpkg overwrite configuration files that where not touched yet
        Dpkg::Options {
          "--force-confdef";
          "--force-confold";
        }
