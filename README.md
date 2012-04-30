Linux Containers related MCollective modules
============================================

cgroup
------

    Linux Control Groups agent
    
    Usage: mco cgroup [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]
    
    The ACTION can be one of the following:
    
      list    - returns list of active control groups
      get     - generic getter
      set     - generic setter
      blkio   - returns cgroup info about Block I/O
      cpu     - returns cgroup info about CPU Scheduling
      memory  - returns cgroup info about Memory Use
    
          --csv                        Output result in CSV format
          --cgroup GROUP               Single Group to target
          --key KEY                    CGroup Key
          --value VALUE                CGroup Value
    ...

Sample output:

    $ mco cgroup memory -T LXCHosts
    Host                        Group     Used      Max    Limit  FailCnt
    CANTON                Dev.Jabber1      679      751     2048        0
    HAMLET                Dev.Jabber2      680      773     2048        0
    GROVE                  IT.rabbit3      662      721     2048        0
    ...


lxc
---

    LXC agent, does stuff
    
    Usage: mco lxc [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]
    
    The ACTION can be one of the following:
    
      list     - returns list of LXC containers
      setauto  - set container(s) to be started on boot
      noauto   - set container(s) to be started manually
    
          --csv                        Output result in CSV format
          --container CONTAINER        Single Container to target
    ...

Sample output:

    $ mco lxc list -T LXCHosts
    Host         Container            Status   Startup
    STEPPE       QAMain.admin         RUNNING  Auto
    STEPPE       QAMain.apps          RUNNING  Auto
    STEPPE       QAMain.monitor       STOPPED  Manual
    ...


lvm
---

    LVM agent, get stats
    
    Usage: mco lvm [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]
    
    The ACTION can be one of the following:
    
      vgdisplay   - returns the status of all volume groups 
      lvdisplay   - returns the status of all logical volume
    
          --csv                        Output result in CSV format
    ...

Sample output:

    $ mco lvm lvdisplay -T LXCHosts
    Host                       Volume     Size
    LAKE                           IT    16.00
    LAKE                     Memcache    16.00
    LAKE                         root    29.80
    ...
