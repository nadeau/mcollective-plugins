module MCollective
  module Agent
    class Cgroup<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For Control Groups Management",
                  :description => "Agent to work with Control Groups via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "BSD",
                  :version     => "1.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :timeout     => 5

      action "list" do
        reply[:cgroups] = getcgroups
      end

      action "blkio" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            data = Hash.new
            File.open("/cgroup/#{cg}/blkio.weight", "r")	{ |f| data[:weight]  = f.read.chomp }
            reply[cg] = data
          end
        end
      end

      action "cpu" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            data = Hash.new
            File.open("/cgroup/#{cg}/cpu.shares", "r")		{ |f| data[:shares]  = f.read.chomp }
            reply[cg] = data
          end
        end
      end

      action "memory" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            data = Hash.new
            File.open("/cgroup/#{cg}/memory.usage_in_bytes", "r")     { |f| data[:used]  = f.read.chomp.to_i / 1048576 }
            File.open("/cgroup/#{cg}/memory.max_usage_in_bytes", "r") { |f| data[:max]   = f.read.chomp.to_i / 1048576 }
            File.open("/cgroup/#{cg}/memory.limit_in_bytes", "r")     { |f| data[:limit] = f.read.chomp.to_i / 1048576 }
            reply[cg] = data
          end
        end
      end

      def getcgroups
        if request.include?(:cgroup) then
          [ request[:cgroup] ]
        else
          Dir.chdir("/cgroup")
          Dir.glob("*/").map{ |x| x.chop }
        end
      end

    end
  end
end
