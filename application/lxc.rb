class MCollective::Application::Lxc<MCollective::Application
  description "LXC agent, does stuff"
    usage <<-END_OF_USAGE
mco lxc [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]

The ACTION can be one of the following:

    list     - returns list of LXC containers
    setauto  - set container(s) to be started on boot
    noauto   - set container(s) to be started manually
    END_OF_USAGE

  option :csv,
  :description    => "Output result in CSV format",
  :arguments      => ["--csv"],
  :type           => :bool

  option :container,
  :description    => "Single Container to target",
  :arguments      => ["--container CONTAINER"]

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift

      unless configuration[:command].match(/^(list|autostart|manualstart)$/)
        raise "Action must be one of list, autostart or manualstart"
      end
    else
      raise "Please specify an action."
    end
  end

  def main
    mc = rpcclient("lxc", :options => options)

    case configuration[:command]

    when "list"

      if configuration[:csv]
        format = '"%s","%s","%s","%s"' + "\n"
      else
        format = "%-12s %-20s %-8s %-8s\n"
      end

      printf( format, "Host", "Container", "Status", "Startup" )

      mc.list(configuration) do |resp|
        begin
          resp[:body][:data].keys.sort.each do |ct|
            printf( format,
                    resp[:senderid].upcase,
                    ct,
                    resp[:body][:data][ct][:status],
                    resp[:body][:data][ct][:startup] )
          end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "autostart"
      mc.autostart(configuration)

    when "manualstart"
      mc.manualstart(configuration)

    end
    mc.disconnect
    printrpcstats
    end
end
