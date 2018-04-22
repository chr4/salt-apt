# State to clean up apt packages

This state purges unused and removed packages from the system.

See [this blog post](https://chr4.org/blog/2013/08/04/apt-get-cleanup-commands/) for details.


# Usage

```bash
# Clean up packages
sudo salt-call state.apply apt.cleanup.now

# Setup systemd timer to automatically clean packages once a day
sudo salt-call state.apply apt.cleanup
```
