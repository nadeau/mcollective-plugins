module MCollective
  module Agent
    class Drbd<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For Using Replicated Block Devices",
                  :description => "Agent to work with DRBD via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :version     => "0.1",
                  :timeout     => 5

      action "list" do
        f = File.open("/proc/drbd", "r")

        f.readlines.each do |line|
          if line.match( /(\d): cs:(\w+) ro:(\w+)\/(\w+) ds:(\w+)\/(\w+)/ )
            reply[$1] = {
              :connection => $2,
              :role => $3,
              :peerrole => $4,
              :disk => $5,
              :peerdisk => $6
            }
          end
        end

        f.close
      end

    end
  end
end
