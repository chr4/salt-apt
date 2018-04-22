# Deploy systemd-timer
apt-cleanup.timer:
  service.running:
    - enable: true
    - watch:
      - file: /lib/systemd/system/apt-cleanup.timer
    - require:
      - file: /lib/systemd/system/apt-cleanup.timer
      - cmd: systemctl daemon-reload
  file.managed:
    - name: /lib/systemd/system/apt-cleanup.timer
    - source: salt://{{ slspath }}/apt-cleanup.timer
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /lib/systemd/system/apt-cleanup.timer

/lib/systemd/system/apt-cleanup.service:
  file.managed:
    - source: salt://{{ slspath }}/apt-cleanup.service
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: /lib/systemd/system/apt-cleanup.service
