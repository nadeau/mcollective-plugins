module MCollective
  module Agent
    class Lxc<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For LXC Containers Management",
                  :description => "Agent to work with LXC via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :version     => "1.0",
                  :timeout     => 5

      action "list" do
        reply[:containers] = Hash.new
        getcontainers.each do |ct|
          f = open("|lxc-info -s -n #{ct}")
          reply[:containers][ct] = f.readline.match(/\w+$/).to_s
          f.close
        end
      end

      def getcontainers
        if request.include?(:container) then
          [ request[:container] ]
        else
          Dir.chdir("/var/lib/lxc")
          Dir.glob("*/").map{ |ct| ct.chop }
        end
      end

    end
  end
end
