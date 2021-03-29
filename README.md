## State to clean up apt packages

This state purges unused and removed packages from the system.

See [this blog post](https://chr4.org/blog/2013/08/04/apt-get-cleanup-commands/) for details.

```bash
# Clean up packages
sudo salt-call state.apply apt.cleanup.now

# Setup systemd timer to automatically clean packages once a day
sudo salt-call state.apply apt.cleanup
```


## State to configure unattended upgrades

This state enables/ disables automatic security upgrades on Ubuntu.
It also allows blacklisting certain packages.
See pillar.example for details.

```bash
sudo salt-call state.apply apt.unattended-upgrades
```


## State to keep modified configuration files automatically on updates

This state sets the `dpkg` configuration options `--force-confdef` and
`--force-confold`, so configuration files you've modified are kept
automatically upon updates.
