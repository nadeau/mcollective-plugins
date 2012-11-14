metadata    :name        => "SimpleRPC Agent For LXC Containers Management",
            :description => "Agent to work with LXC via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License, Version 2.0",
            :version     => "1.0",
            :timeout     => 10


action "list", :description => "List Containers" do
    display :always

    input :container,
          :prompt      => "Container",
          :description => "Container to list",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :status,
	   :description => "State of the Container",
           :display_as  => "Status"

    output :startup,
	   :description => "Containers autostart status",
           :display_as  => "Auto Start"
end

action "autostart", :description => "Set Containers to be started on boot" do
    input :container,
          :prompt      => "Container",
          :description => "Container to edit",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32
end

action "autoclean", :description => "Removed broken start links" do
    display :always

    output :containers,
	   :description => "Containers start links",
           :display_as  => "Containers"
end

action "manualstart", :description => "Set Containers to be started manually" do
    input :container,
          :prompt      => "Container",
          :description => "Container to edit",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32
end

action "start", :description => "Start target container(s)" do
    input :container,
          :prompt      => "Container",
          :description => "Container to start",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :rc,
	   :description => "Return code from start command",
           :display_as  => "RC"
end

action "stop", :description => "Stop target container(s)" do
    input :container,
          :prompt      => "Container",
          :description => "Container to start",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9.]+$',
          :optional    => true,
          :maxlength   => 32

    output :rc,
	   :description => "Return code from start command",
           :display_as  => "RC"
end
