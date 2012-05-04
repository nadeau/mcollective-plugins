class MCollective::Application::Drbd<MCollective::Application
  description "Linux Replicated Block Device Agent"
    usage <<-END_OF_USAGE
mco drbd [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]

The ACTION can be one of the following:

    list    - returns list of replicated block devices
    END_OF_USAGE

  option :csv,
  :description    => "Output result in CSV format",
  :arguments      => ["--csv"],
  :type           => :bool

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift

      unless configuration[:command].match(/^list$/)
        raise "Action must be one of list, list or list"
      end
    else
      raise "Please specify an action."
    end
  end

  def main
    mc = rpcclient("drbd", :options => options)

    case configuration[:command]

    when "list"

      if configuration[:csv]
        format = '"%s","%s","%s","%s","%s","%s","%s"' + "\n"
      else
        format = "%-20s %-5s %-12s %-12s %-12s %-12s %-12s\n"
      end

      printf( format, "Host", "Dev", "Connection", "Role", "Peer Role", "Disk", "Peer Disk" )

      mc.list(configuration) do |resp|
        begin
           resp[:body][:data].keys.each do |dev|
            printf( format,
                    resp[:senderid].upcase,
                    dev,
                    resp[:body][:data][dev][:connection],
                    resp[:body][:data][dev][:role],
                    resp[:body][:data][dev][:peerrole],
                    resp[:body][:data][dev][:disk],
                    resp[:body][:data][dev][:peerdisk] )
           end

        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    end
    mc.disconnect
    printrpcstats
  end
end
