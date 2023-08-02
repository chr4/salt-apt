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


## State to ensure linux-image meta package is installed

```bash
sudo salt-call state.apply apt.kernel
```

This package ensures that kernel packages are updated. There are multiple meta-packages for differnet platforms, e.g.:

- `linux-image-aws` - Linux kernel image for Amazon Web Services (AWS) systems.
- `linux-image-azure` - Linux kernel image for Azure systems.
- `linux-image-gcp` - Google Cloud Platform (GCP) Linux kernel image
- `linux-image-generic` - Generic Linux kernel image
- `linux-image-gke` - Linux kernel image for gke systems.
- `linux-image-ibm` - IBM Cloud Platform (ibm) Linux kernel image
- `linux-image-kvm` - Linux kernel image for virtual systems.
- `linux-image-lowlatency` - lowlatency Linux kernel image
- `linux-image-oracle` - Linux kernel image for Oracle systems.
- `linux-image-virtual` - Virtual Linux kernel image
- `linux-image-nvidia` - Linux kernel image for Nvidia systems.
- `linux-image-gkeop` - GKEOP Linux kernel image
- `linux-image-realtime` - Linux kernel image for real-time systems.

It's impossible to automatically choose the right one, so it needs to be specified in pillars. Defaults to `linux-image-generic`.
