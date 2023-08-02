linux-image-meta-package:
  pkg.installed:
    - pkgs:
        - {{ salt['pillar.get']('apt:kernel:linux-image-meta-package', 'linux-image-generic') }}
