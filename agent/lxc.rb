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
        getcontainers.each do |ct|
          reply[ct] = Hash.new
          reply[ct][:startup] = File.exist?("/etc/lxc/auto/#{ct}") ? 'Auto' : 'Manual'

          f = open("|lxc-info -s -n #{ct}")
          reply[ct][:status]  = f.readline.match(/\w+$/).to_s
          f.close
        end
      end

      action "autostart" do
        getcontainers.each do |ct|
          unless File.exist?("/etc/lxc/auto/#{ct}")
            File.symlink( "/var/lib/lxc/#{ct}/config", "/etc/lxc/auto/#{ct}" )
            # reply[ct][:startup] = File.exist?("/etc/lxc/auto/#{ct}") ? 'Auto' : 'ERROR'
          end
        end
      end

      action "manualstart" do
        getcontainers.each do |ct|
          if File.exist?("/etc/lxc/auto/#{ct}")
            File.unlink( "/etc/lxc/auto/#{ct}" )
            # reply[ct][:startup] = File.exist?("/etc/lxc/auto/#{ct}") ? 'ERROR' : 'Manual'
          end
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
