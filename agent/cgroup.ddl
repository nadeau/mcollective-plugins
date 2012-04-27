metadata    :name        => "SimpleRPC Agent For CGroups Management",
            :description => "Agent to work with cgroups via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License 2.0",
            :version     => "1.0",
            :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
            :timeout     => 10


action "list", :description => "List CGroups" do
    display :always

    output :cgroups,
	   :description => "List of CGroups",
           :display_as  => "CGroups"
end

action "blkio", :description => "Show CGroups Block I/O stuff" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "CGroup to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "CGroup Name",
           :display_as  => "CGroup"
    output :weight,
	   :description => "I/O Priority",
           :display_as  => "Priority"
end

action "cpu", :description => "Show CGroups CPU stuff" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "CGroup to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "CGroup Name",
           :display_as  => "CGroup"
    output :shares,
	   :description => "CPU Shares",
           :display_as  => "Priority"
end

action "memory", :description => "Show CGroups memory usage" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "CGroup to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "CGroup Name",
           :display_as  => "CGroup"
    output :used,
	   :description => "Memory Usage",
           :display_as  => "Used MB"
    output :max,
	   :description => "Max Used Memory",
           :display_as  => "Max MB"
    output :limit,
	   :description => "Memory Limit",
           :display_as  => "Limit MB"
end
