apt_purge_kernels:
  cmd.run:
    - name: |
        apt-get purge -y $( \
          dpkg --list | \
          egrep 'linux-image-[0-9]' | \
          awk '{print $3,$2}' | \
          sort -nr | \
          tail -n +2 | \
          grep -v $(uname -r) | \
          awk '{ print $2}' \
        )

apt_purge_packages:
  cmd.run:
    - name: |
        apt-get autoremove -y; \
        apt-get purge -y $( \
          dpkg --list | \
          grep '^rc' | \
          awk '{print $2}' \
        )
