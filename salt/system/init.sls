# Install EPEL repository
base_epel:
  pkg.installed:
    - name: epel-release

# Install some handy utilities
base_utilities:
  pkg.installed:
    - pkgs:
      - bind-utils # DNS troubleshooting
      - htop # Compute metrics in a pinch
      - iotop # Disk metrics in a pinch
      - man-db # Manpages
      - nmap # Network troubleshooting
      - psmisc # killall and pstree
      - python2-httpie # HTTP troubleshooting
      - rsync # Fast file transfer
      - tcpdump # Network capture
      - tree # Nested directory list
      - vim-enhanced # A good text editor
    - require:
      - pkg: base_epel
