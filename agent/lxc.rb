module MCollective
  module Agent
    class Lxc<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For LXC Containers Management",
                  :description => "Agent to work with LXC via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :version     => "1.0",
                  :timeout     => 5

      action "list" do
        reply[:containers] = Hash.new
        getcontainers.each do |ct|
          reply[:containers][ct] = open("|lxc-info -s -n #{ct}").readline.match(/\w+$/).to_s
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
