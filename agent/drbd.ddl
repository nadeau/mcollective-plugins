metadata    :name        => "SimpleRPC Agent For Using Replicated Block Devices",
            :description => "Agent to work with DRBD via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License, Version 2.0",
            :version     => "0.1",
            :timeout     => 5


action "list", :description => "List Replicated Block Devices" do
    display :always

    output :Devices,
	   :description => "List of Replicated Block Devices",
           :display_as  => "Devices"
end
