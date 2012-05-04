metadata    :name        => "SimpleRPC Agent For Querying the /proc filesystem",
            :description => "Agent to query /proc via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License, Version 2.0",
            :version     => "0.1",
            :timeout     => 5


action "load", :description => "Show System Load Average" do
    display :always

    output :load1,
	   :description => "Load Average 1 min",
           :display_as  => "Load 1"
    output :load5,
	   :description => "Load Average 5 min",
           :display_as  => "Load 5"
    output :load15,
	   :description => "Load Average 15 min",
           :display_as  => "Load 15"
    output :processes,
	   :description => "Number of Processes",
           :display_as  => "Processes"
    output :running,
	   :description => "Number of Running Processes",
           :display_as  => "Running"
end

action "get", :description => "Get /proc file value" do
    display :always

#    input :key,
#          :prompt      => "File",
#          :description => "Proc filename",
#          :type        => :string,
#          :validation  => '^[a-zA-Z0-9_.]+$',
#          :maxlength   => 16

    output :key,
	   :description => "File Name",
           :display_as  => "File"
    output :value,
	   :description => "File Content",
           :display_as  => "Content"
end

action "set", :description => "Set /proc file value" do
    input :key,
          :prompt      => "File",
          :description => "Proc filename",
          :type        => :string,
          :validation  => '^[a-zA-Z0-9_.]+$',
          :maxlength   => 16
    input :value,
          :prompt      => "Value",
          :description => "File content",
          :type        => :string,
          :validation  => '^[0-9.]+$'
end
