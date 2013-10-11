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

      def startup_hook
        @path = File.directory?('/cgroup/lxc') ? '/cgroup/lxc' : '/cgroup';
      end

      action "list" do
        reply[:cgroups] = getcgroups
      end

      action "get" do
        key = request[:key]
        getcgroups.each do |cg|
          if File.directory?("#{@path}/#{cg}")
            reply[cg] = Hash.new
            File.open("#{@path}/#{cg}/#{key}", "r")		{ |f| reply[cg][key] = f.read.chomp }
          end
        end
      end

      action "set" do
        key = request[:key]
        getcgroups.each do |cg|
          if File.directory?("#{@path}/#{cg}")
            reply[cg] = Hash.new
            File.open("#{@path}/#{cg}/#{key}", "w")		{ |f| f.puts(request[:value]) }
            File.open("#{@path}/#{cg}/#{key}", "r")		{ |f| reply[cg][key] = f.read.chomp }
          end
        end
      end

      action "blkio" do
        getcgroups.each do |cg|
          if File.directory?("#{@path}/#{cg}")
            reply[cg] = Hash.new
            File.open("#{@path}/#{cg}/blkio.weight", "r")	{ |f| reply[cg][:weight] = f.read.chomp }
          end
        end
      end

      action "cpu" do
        getcgroups.each do |cg|
          if File.directory?("#{@path}/#{cg}")
            reply[cg] = Hash.new
            File.open("#{@path}/#{cg}/cpu.shares", "r")		{ |f| reply[cg][:shares] = f.read.chomp }
          end
        end
      end

      action "memory" do
        getcgroups.each do |cg|
          if File.directory?("#{@path}/#{cg}")
            reply[cg] = Hash.new
            File.open("#{@path}/#{cg}/memory.usage_in_bytes", "r")     { |f| reply[cg][:used]    = f.read.chomp.to_i / 1048576 }
            File.open("#{@path}/#{cg}/memory.max_usage_in_bytes", "r") { |f| reply[cg][:max]     = f.read.chomp.to_i / 1048576 }
            File.open("#{@path}/#{cg}/memory.limit_in_bytes", "r")     { |f| reply[cg][:limit]   = f.read.chomp.to_i / 1048576 }
            File.open("#{@path}/#{cg}/memory.failcnt", "r")            { |f| reply[cg][:failcnt] = f.read.chomp }
          end
        end
      end

      def getcgroups
        if request.include?(:cgroup) then
          [ request[:cgroup] ]
        else
          Dir.chdir("#{@path}")
          Dir.glob("*/").map{ |x| x.chop }
        end
      end

    end
  end
end
