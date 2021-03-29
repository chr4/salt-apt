# Make sure unattended-upgrades is installed/ removed according
{% if salt['pillar.get']('apt:unattended-upgrades:disable', false) %}
apt_disable_unattended_upgrades:
  file.managed:
    - name: /etc/apt/apt.conf.d/20auto-upgrades
    - contents:
      - APT::Periodic::Update-Package-Lists "0";
      - APT::Periodic::Unattended-Upgrade "0";

{% else %}
unattended-upgrades:
  pkg.installed: []

# Enable automatic updates system-wide
apt_enable_unattended_upgrades:
  file.managed:
    - name: /etc/apt/apt.conf.d/20auto-upgrades
    - contents:
      - APT::Periodic::Update-Package-Lists "1";
      - APT::Periodic::Unattended-Upgrade "1";

# Disable automatic updates for specific packages
apt_blacklist_unattended_upgrades:
  file.blockreplace:
    - name: /etc/apt/apt.conf.d/50unattended-upgrades
    - marker_start: 'Unattended-Upgrade::Package-Blacklist {'
    - marker_end: '};'
    - content: |
{%- for pkg in salt['pillar.get']('apt:unattended-upgrades:blacklist', []) %}
        "{{ pkg }}";
{%- endfor %}

# Enable automatic updates for all packages if specified in pillar
apt_upgrade_all_origins:
  file.blockreplace:
    - name: /etc/apt/apt.conf.d/50unattended-upgrades
    - marker_start: 'Unattended-Upgrade::Allowed-Origins {'
    - marker_end: '};'
    - content: |
        // Enable security updates (default)
        "${distro_id}:${distro_codename}";
        "${distro_id}:${distro_codename}-security";
        "${distro_id}ESMApps:${distro_codename}-apps-security";
        "${distro_id}ESM:${distro_codename}-infra-security";

{% if salt['pillar.get']('apt:unattended-upgrades:all-origins', false) %}
        // Enable automatic updates for other origins
        "${distro_id}:${distro_codename}-updates";
        "${distro_id}:${distro_codename}-proposed";
        "${distro_id}:${distro_codename}-backports";
{% endif %}

{% endif %}
