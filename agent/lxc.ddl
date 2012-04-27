metadata    :name        => "SimpleRPC Agent For LXC Containers Management",
            :description => "Agent to work with LXC via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License 2.0",
            :version     => "1.0",
            :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
            :timeout     => 10


action "list", :description => "List Containers" do
    display :always

    output :containers,
	   :description => "List of Containers",
           :display_as  => "Containers"
end
