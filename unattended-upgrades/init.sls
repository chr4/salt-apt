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
{% endif %}
