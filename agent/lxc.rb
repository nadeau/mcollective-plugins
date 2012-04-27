module MCollective
  module Agent
    class Lxc<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For LXC Containers Management",
                  :description => "Agent to work with LXC via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "BSD",
                  :version     => "1.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :timeout     => 5

      action "list" do
        Dir.chdir("/var/lib/lxc")
        reply[:containers] = Dir.glob("*")
      end

      def getcontainers
        if request.include?(:container) then
          [ request[:container] ]
        else
          Dir.chdir("/var/lib/lxc")
          reply[:containers] = Dir.glob("*/")
        end
      end

    end
  end
end
