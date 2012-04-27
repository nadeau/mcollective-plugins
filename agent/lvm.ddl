metadata    :name        => "SimpleRPC Agent For LVM Management",
            :description => "Agent to query LVM commands via MCollective",
            :author      => "Billy Nadeau",
            :license     => "Apache License, Version 2.0",
            :version     => "1.0",
            :timeout     => 10


action "vgdisplay", :description => "Show Volume Groups Usage" do
    display :always

    output :total,
	   :description => "Total Disk Space",
           :display_as  => "Total"

    output :allocated,
	   :description => "Allocated Disk Space",
           :display_as  => "Allocated"

    output :free,
	   :description => "Free Disk Space",
           :display_as  => "Free"
end

action "lvdisplay", :description => "Show Logical Volumes Allocation" do
    display :always

    output :size,
	   :description => "Volume Space",
           :display_as  => "Size"
end

