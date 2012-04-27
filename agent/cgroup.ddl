metadata    :name        => "SimpleRPC Agent For Control Groups Management",
            :description => "Agent to work with Control Groups via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License 2.0",
            :version     => "1.0",
            :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
            :timeout     => 10


action "list", :description => "List Control Groups" do
    display :always

    output :cgroups,
	   :description => "List of Control Groups",
           :display_as  => "Groups"
end

action "get", :description => "Get Control Groups value" do
    display :always

    output :cgroup,
	   :description => "Control Group Name",
           :display_as  => "Group"
    output :value,
	   :description => "Value",
           :display_as  => "Value"
end

action "set", :description => "Set Control Groups value" do
    output :cgroups,
	   :description => "List of Control Groups",
           :display_as  => "Groups"

    input :cgroup,
          :prompt      => "CGroup",
          :description => "Control Group to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    input :key,
          :prompt      => "Key",
          :description => "CGroup Key",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9_.]+$',
          :maxlength   => 32
    input :value,
          :prompt      => "Value",
          :description => "CGroup Value",
          :type        => :string,
          :validation  => '^[0-9.]+$'
end

action "blkio", :description => "Show Control Groups Block I/O stuff" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "Control Group to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "Control Group Name",
           :display_as  => "Group"
    output :weight,
	   :description => "I/O Priority",
           :display_as  => "Priority"
end

action "cpu", :description => "Show Control Groups CPU stuff" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "Control Group to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "Control Group Name",
           :display_as  => "Group"
    output :shares,
	   :description => "CPU Shares",
           :display_as  => "Priority"
end

action "memory", :description => "Show Control Groups memory usage" do
    display :always

    input :cgroup,
          :prompt      => "CGroup",
          :description => "Control Group to examine",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :cgroup,
	   :description => "Control Group Name",
           :display_as  => "Group"
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
