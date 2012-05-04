class MCollective::Application::Lvm<MCollective::Application
  description "LVM agent, get stats"
    usage <<-END_OF_USAGE
mco lvm [OPTIONS] [FILTERS] <ACTION> [CONCURRENCY]

The ACTION can be one of the following:

    vgdisplay   - returns the status of all volume groups 
    lvdisplay   - returns the status of all logical volume
    END_OF_USAGE

  option :csv,
  :description    => "Output result in CSV format",
  :arguments      => ["--csv"],
  :type           => :bool

  def post_option_parser(configuration)
    if ARGV.length >= 1
      configuration[:command] = ARGV.shift

      unless configuration[:command].match(/^(vgdisplay|lvdisplay)$/)
        raise "Action must be vgdisplay or lvdisplay"
      end
    else
      raise "Please specify an action."
    end
  end

  def main
    mc = rpcclient("lvm", :options => options)

    case configuration[:command]

    when "vgdisplay"

      if configuration[:csv]
        format = '"%s","%s","%s","%s"' + "\n"
      else
        format = "%-12s %8s %8s %8s\n"
      end

      printf( format, "Host", "Total", "Alloc", "Free" )

      mc.vgdisplay() do |resp|
        begin
          printf( format,
                  resp[:senderid].upcase,
                  resp[:body][:data][:total],
                  resp[:body][:data][:allocated],
                  resp[:body][:data][:free] )
        rescue RPCError => e
          puts "The RPC agent returned an error: #{e}"
        end
      end

    when "lvdisplay"

      if configuration[:csv]
        format = '"%s","%s","%s"' + "\n"
      else
        format = "%-12s %20s %8s\n"
      end

      printf( format, "Host", "Volume", "Size" )

      mc.lvdisplay() do |resp|
        begin
          resp[:body][:data].keys.sort.each do |volume|
            printf( format,
                    resp[:senderid].upcase,
                    volume,
                    resp[:body][:data][volume] )
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
