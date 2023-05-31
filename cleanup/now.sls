apt_purge_kernels:
  cmd.run:
    - env:
      - DEBIAN_FRONTEND: noninteractive
    - name: |
        apt-get purge -y $( \
          dpkg --list | \
          egrep 'linux-image-[0-9]' | \
          awk '{print $3,$2}' | \
          sort -nr | \
          tail -n +2 | \
          grep -v $(uname -r) | \
          awk '{ print $2}' | \
          tr '[:space:]' ' ' \
        )

apt_purge_packages:
  cmd.run:
    - env:
      - DEBIAN_FRONTEND: noninteractive
    - name: |
        apt-get autoremove -y; \
        apt-get purge -y $( \
          dpkg --list | \
          grep '^rc' | \
          awk '{print $2}' | \
          tr '[:space:]' ' ' \
        )

apt_clean_packages:
  cmd.run:
    - env:
      - DEBIAN_FRONTEND: noninteractive
    - name: apt-get clean -y
