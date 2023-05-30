# Deploy systemd-timer
apt-cleanup.timer:
  service.running:
    - enable: true
    - watch:
      - file: /etc/systemd/system/apt-cleanup.timer
    - require:
      - file: /etc/systemd/system/apt-cleanup.timer
      - cmd: systemctl daemon-reload
  file.managed:
    - name: /etc/systemd/system/apt-cleanup.timer
    - source: salt://{{ tpldir }}/apt-cleanup.timer
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /etc/systemd/system/apt-cleanup.timer

/etc/systemd/system/apt-cleanup.service:
  file.managed:
    - source: salt://{{ tpldir }}/apt-cleanup.service
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /etc/systemd/system/apt-cleanup.service

apt_clean_packages:
  file.managed:
    - name: /etc/apt/apt.conf.d/30clean-packages
    - contents: |
        APT::Keep-Downloaded-Packages "false";
