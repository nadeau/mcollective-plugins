module MCollective
  module Agent
    class Procfs<RPC::Agent
      metadata    :name        => "SimpleRPC Agent For Control Groups Management",
                  :description => "Agent to work with Control Groups via MCollective",
                  :author      => "Billy Nadeau",
                  :license     => "Apache License, Version 2.0",
                  :url         => "http://projects.puppetlabs.com/projects/mcollective-plugins/wiki",
                  :version     => "0.1",
                  :timeout     => 5

      action "get" do
        key = reply[:key] = request[:key]
        File.open("/proc/#{key}", "r")		{ |f| reply[:value] = f.read.chomp }
      end

      action "set" do
        key = reply[:key] = request[:key]
        if File.writable?("/key/#{key}")
          File.open("/proc/#{key}", "w")	{ |f| f.puts(request[:value]) }
          File.open("/proc/#{key}", "r")	{ |f| reply[value] = f.read.chomp }
        end
      end

      action "load" do
        File.open("/proc/loadavg", "r") do |f|
          values = f.read.split
          reply[:load1] = values[0]
          reply[:load5] = values[1]
          reply[:load15] = values[2]
          ( reply[:running], reply[:processes] ) = values[3].split('/')
          f.close
        end
      end

    end
  end
end
