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
    Host                        Group     Used      Max    Limit
    CANTON                Dev.Jabber1      679      751     2048
    HAMLET                Dev.Jabber2      680      773     2048
    GROVE                  IT.rabbit3      662      721     2048
    ...


lxc
---

    LXC agent, does stuff
    
    Usage: mco lxc [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]
    
    The ACTION can be one of the following:
    
      list    - returns list of LXC containers
    
          --csv                        Output result in CSV format
    ...

Sample output:

    $ mco lxc list -T LXCHosts
    Host         Container            Status  
    STEPPE       QAMain.admin         RUNNING 
    STEPPE       QAMain.apps          RUNNING 
    STEPPE       QAMain.monitor       STOPPED 
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
