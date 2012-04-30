module MCollective
  module Agent
    class Cgroup<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For Control Groups Management",
                  :description => "Agent to work with Control Groups via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :version     => "1.0",
                  :timeout     => 5

      action "list" do
        reply[:cgroups] = getcgroups
      end

      action "get" do
        key = request[:key]
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            reply[cg] = Hash.new
            File.open("/cgroup/#{cg}/#{key}", "r")		{ |f| reply[cg][key] = f.read.chomp }
          end
        end
      end

      action "set" do
        key = request[:key]
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            reply[cg] = Hash.new
            File.open("/cgroup/#{cg}/#{key}", "w")		{ |f| f.puts(request[:value]) }
            File.open("/cgroup/#{cg}/#{key}", "r")		{ |f| reply[cg][key] = f.read.chomp }
          end
        end
      end

      action "blkio" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            reply[cg] = Hash.new
            File.open("/cgroup/#{cg}/blkio.weight", "r")	{ |f| reply[cg][:weight] = f.read.chomp }
          end
        end
      end

      action "cpu" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            reply[cg] = Hash.new
            File.open("/cgroup/#{cg}/cpu.shares", "r")		{ |f| reply[cg][:shares] = f.read.chomp }
          end
        end
      end

      action "memory" do
        getcgroups.each do |cg|
          if File.directory?("/cgroup/#{cg}")
            reply[cg] = Hash.new
            File.open("/cgroup/#{cg}/memory.usage_in_bytes", "r")     { |f| reply[cg][:used]    = f.read.chomp.to_i / 1048576 }
            File.open("/cgroup/#{cg}/memory.max_usage_in_bytes", "r") { |f| reply[cg][:max]     = f.read.chomp.to_i / 1048576 }
            File.open("/cgroup/#{cg}/memory.limit_in_bytes", "r")     { |f| reply[cg][:limit]   = f.read.chomp.to_i / 1048576 }
            File.open("/cgroup/#{cg}/memory.failcnt", "r")            { |f| reply[cg][:failcnt] = f.read.chomp }
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
