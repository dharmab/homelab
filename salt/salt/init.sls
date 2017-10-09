salt_repository:
  pkgrepo.managed:
    - name: salt-latest
    - humanname: SaltStack Latest Release Channel for RHEL/Centos $releasever
    - baseurl: https://repo.saltstack.com/yum/redhat/7/$basearch/latest
    - enabled: True
    - failovermethod: priority
    - gpgcheck: 1
    - gpgkey: file:///etc/pki/rpm-gpg/saltstack-signing-key
